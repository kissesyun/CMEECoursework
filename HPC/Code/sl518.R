#!/usr/bin/env Rscript

#clear the space
rm(list=ls())
graphics.off()

#store the simulated system
#community <- c(1,4,4,5,1,6,1)

###Q1
#define function to know the species richness
species_richness <- function(community){
  a <- unique(community)
  length(a)
}
#species_richness(community)

###Q2 AND Q3
#given the size of the community
#size <- 7

#generate an initial state for the simulation community
initialise_max <- function(size){
  seq(size)
}

initialise_min <- function(size){
  rep(1,size)
}
#species_richness(initialise_min(x))
#species_richness(initialise_max(x))

###Q4
#choose two sample from a list
choose_two <- function(x){
  sample(seq(x),2,replace = FALSE)
}

###Q5
#define one single neutral step: one individual die and replaced by another's offspring
neutral_step <- function(community){ 
  indexes <- choose_two(length(community)) 
  community[indexes[1]] <- community[indexes[2]]  
  return(community)
}

###Q6
#simulate several neutral steps to form a simulation on a generation scale
neutral_generation <- function(community){ 
  #ceiling can be used to round up uneven abundances
  for (i in 1:ceiling((length(community)/2))){ 
    community <- neutral_step(community) 
  }
  return(community)
}

###Q7
#a time series of species richness during a certain amount of gernations of neutral theory simulation 
neutral_time_series <- function(initial, duration){ 
  time_series <- c(species_richness(initial)) 
  for (i in 1:duration){ 
    initial <- neutral_generation(initial) 
    time_series[i+1] <- species_richness(initial) 
  }
  return(time_series) 
}

###Q8
#plot a time series graph for n generations simulation
question_8 <- function(){ 
  pdf(file = "../Result/Q8Plot.pdf") 
  plot(neutral_time_series(initial=initialise_max(100), duration=200), 
       type = "l", 
       xlab = "Generations", 
       ylab = "Species Richness", 
       main = "Neutral Model Simulation without speciation") 
  dev.off() # turns graphics off
}
#The system will always converge to a equilibrium state of minimal species richness. 
#Because in this simulation there is no speciation therefore no new species introduced.
#And the existing species will eventually be lost and replaced by other species in the system.
#Therefore the species richness is expected to drop as generations go on and finally remain a single species system.

###Q9
#a step of neutral model with speciation
neutral_step_speciation <- function(community, v){ 
  indexes <- choose_two(length(community)) 
  #speciation occurs when the random number generated is smaller than v 
  #speciated individual will be replaced with a new one
  if ((runif(1, 0, 1) <= v)){ 
    nextstep <- replace(community, indexes[1], (max(community)+1)) 
  }
  #if speciation doesn't happen, do it with ordinary neutral step 
  else{ 
    nextstep <- replace(community, indexes[1], community[indexes[2]]) 
  }
  return(nextstep) 
}  

###Q10
#simulate several neutral steps (with speciation) to form a simulation (with speciation) on a generation scale
neutral_generation_speciation <- function(community,v){ 
  #ceiling can be used to round up uneven abundances
  for (i in 1:ceiling((length(community)/2))){ 
    community <- neutral_step_speciation(community,v) 
  }
  return(community)
}

###Q11
#a time series of species richness during a certain amount of gernations of neutral theory simulation (with speciation)
neutral_time_series_speciation <- function(community,v,duration){ 
  time_series <- c(species_richness(community)) 
  for (i in 1:duration){ 
    community <- neutral_generation_speciation(community,v) 
    time_series[i+1] <- species_richness(community) 
  }
  return(time_series) 
}

###Q12
#plot a time series graph for n generations simulation (with speciation)
question_12 <- function(){ 
  pdf(file = "../Result/Q12Plot.pdf") 
  plot(neutral_time_series_speciation(community = initialise_max(100), v = 0.1, duration = 200), 
       type = "l", 
       col = "red",
       xlab = "Generations", 
       ylab = "Species Richness", 
       main = "Neutral Model Simulation with speciation") 
  lines(neutral_time_series_speciation(community = initialise_min(100), v = 0.1, duration = 200),
        col = "green")
  dev.off() # turns graphics off
}
#From this plot I found that the initial conditions do not affect the final state of neutral model simulation.
#For both 2 communities with different initial species richness, they end up with similar fluctuating equilibrium in species richness.
#Because there is a certain speciation rate indicating the chance of introduction of new species in this system.
#the final approximate species richness is influenced by the speciation rate and the initial community size regardless of the initial species richness.

###Q13
#the abundance othe all the species in the system
species_abundance <- function(community){
  as.vector(sort(table(community), decreasing = T)) 
}
#species_abundance(c(1,5,3,6,5,6,1,1))

###Q14
#this is a way to bin the abundances of species
#first value: abundance of 1; 2nd value: abundance of 2 and 3; 3rd value: abundance of 4, 5, 6, 7;
octaves <- function(community){ 
  #the boundary is less than 2^n, so use ?floor
  #tabulate only takes integers into account, so no zero
  tabulate(floor(log2(community)) + 1)
}
#octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

###Q15
#return the sum od two vectors
sum_vect <- function(x,y){
  if (length(x)<length(y)){ 
    x <- append(x, rep(0, (length(y)-length(x)))) 
  }
  if (length(y)<length(x)){ 
    y <- append(y, rep(0, (length(x)-length(y)))) 
  }
  x + y 
}
#sum_vect(c(1,3),c(1,0,5,2))

###Q16
#record the species abundance octave vector for every 20 generation after the burn-in period (200 generations)
question_16 <- function(){
  #burn-in period
  community_200 = initialise_max(100)
  #community_200 = initialise_min(100)
  for (i in 1:200){ 
    community_200 <- neutral_generation_speciation(community_200, v = 0.1) 
  }
  abundance <- octaves(species_abundance(community_200))
  #for another 2000 rounds
  community_2000 = community_200
  for (i in 1:2000){ 
    community_2000 <- neutral_generation_speciation(community_2000, v = 0.1) 
    #record every 20 generation
    if (i %% 20 == 0){ 
      abundance <- sum_vect(abundance, octaves(species_abundance(community_2000))) 
    }
  }
  avg_abundance <- abundance/101 
  
  pdf(file = "../Result/Q16Plot1.pdf")
  #pdf(file = "../Result/Q16Plot2.pdf")
  
  names = c("1", "2-3", "4-7", "8-15", "16-31", "32-63")
  barplot(avg_abundance, 
          names.arg = names,
          main = "Species abundance for neutral model with speciation (max initial)",
          xlab = "Species abundance",
          ylab = "Frequency") 
  dev.off() 
}
#try again for initialise_min(100)

challenge_A <- function(){
  comm1 = initialise_max(100)
  comm2 = initialise_min(100)
  
  rich1_total = data.frame()
  rich2_total= data.frame()
  for (i in 1:100) {
    rich1 = neutral_time_series_speciation(comm1, 0.1, 200)
    rich2 = neutral_time_series_speciation(comm2, 0.1, 200)
    rich1_total = rbind(rich1_total,rich1)
    rich2_total = rbind(rich2_total,rich2)
  }
  
  #calcualte the standard deviations and averages
  avg1 = colSums(rich1_total)/100
  avg2 = colSums(rich2_total)/100
  sd1 = sqrt(apply(rich1_total,2,var))
  sd2 = sqrt(apply(rich2_total,2,var))
  
  # 97.2% CI = z of 2.2
  CI1_upper = avg1 + 2.2*sd1
  CI1_lower = avg1 - 2.2*sd1
  
  CI2_upper = avg2 + 2.2*sd2
  CI2_lower = avg2 - 2.2*sd2
  
  pdf(file = "../Result/challengeA.pdf") 
  plot(avg1, xlab = "Generation time", ylab = "Average Species richness", main = "Species richness over time in neutral model",
       col = "red", type = "l", ylim = range(0,100))
  segments(c(1:201),CI1_upper,c(1:201),CI1_lower,col="red",lwd = 0.75)  
  
  lines(avg2, col = "blue", type = "l")
  segments(c(1:201),CI2_upper,c(1:201),CI2_lower,col="blue",lwd = 0.75)  
  legend('topright',c('initialise_max','initialise_min'),
         col=c('red','blue'),lty = 1)
  dev.off()
}


###Q17 and Q18 on a separate R code file
###Q19 on a spearate bash script
#The zip file containing all the output file and scripts used to produced it can be found in Result folder

###Q20
#extract the output file to get a set of average abundence octaves for 100 iteration
aver_oct_set = c()
for (i in (1:100)){
  file = paste("../Result/HPC/sl518_cluster_",i,".rda",sep = "")
  load(file)
  sum_oct = c(0)
  for (n in (1:length(oct))){
    sum_oct = sum_vect(sum_oct,oct[[n]])
  }
  aver_oct = sum_oct/length(oct)
  aver_oct_set = c(aver_oct_set,list(aver_oct))
}

#group them by size
size500 = c(0)
size1000 = c(0)
size2500 = c(0)
size5000 = c(0)
for (i in (1:length(aver_oct_set))){
    if(i%%4==1){
      size500 = sum_vect(size500,aver_oct_set[[i]])
    }
    else if(i%%4==2){
      size1000 = sum_vect(size1000,aver_oct_set[[i]])
    }
    else if(i%%4==3){
      size2500 = sum_vect(size2500,aver_oct_set[[i]])
    }
    else if(i%%4==0){
      size5000 = sum_vect(size5000,aver_oct_set[[i]])
    }
}

#get the average value for 25 iterations in 4 groups with different size
size500_aver = size500/(length(aver_oct_set)/4)
size1000_aver = size1000/(length(aver_oct_set)/4)
size2500_aver = size2500/(length(aver_oct_set)/4)
size5000_aver = size5000/(length(aver_oct_set)/4)
  
pdf(file="../Result/Q20Plot.pdf")
#omo adjust the boundary of the image, c(bottom, left, top, right)
par(mfrow = c(2,2), oma=c(0,0,2,0))
#names.arg in barplot
barplot(size500_aver,
        main = "Community size is 500",
        xlab = "Species population", ylab = "Number of Species", col = "yellow")
barplot(size1000_aver,
        main = "Community size is 1000",
        xlab = "Species population", ylab = "Number of Species", col = "green")
barplot(size2500_aver,
        main = "Community size is 2500",
        xlab = "Species population", ylab = "Number of Species", col = "red")
barplot(size5000_aver, 
        main = "Community size is 5000",
        xlab = "Species population", ylab = "Number of Species", col = "blue")
title("Distribution of average species abundance",outer=TRUE)
dev.off()

###challenge C
challenge_C <- function(){
  time_series_500 = c(0)
  time_series_1000 = c(0)
  time_series_2500 = c(0)
  time_series_5000 = c(0)
  
  for (i in (1:100)){
    file = paste("../Result/HPC/sl518_cluster_",i,".rda",sep = "")
    load(file)
    if(i%%4==1){
      time_series_500 = sum_vect(time_series_500, richness)
    }
    else if(i%%4==2){
      time_series_1000 = sum_vect(time_series_1000, richness)
    }
    else if(i%%4==3){
      time_series_2500 = sum_vect(time_series_2500, richness)
    }
    else if(i%%4==0){
      time_series_5000 = sum_vect(time_series_5000, richness)
    }
  }
  aver_time_series_500 = time_series_500/(iter/4)
  aver_time_series_1000 = time_series_1000/(iter/4)
  aver_time_series_2500 = time_series_2500/(iter/4)
  aver_time_series_5000 = time_series_5000/(iter/4)
  
  pdf(file = "../Result/challengeC.pdf") 
  plot(c(0,(8*5000)), c(0,100), type = "n",
       xlab = "Generation", ylab = "Species Richness",
       main = "Average species richness over time")
  lines(seq(0,(8*500)), aver_time_series_500[1:(8*500+1)], col = "red")
  lines(seq(0,(8*1000)), aver_time_series_1000[1:(8*1000+1)], col = "blue")
  lines(seq(0,(8*2500)), aver_time_series_2500[1:(8*2500+1)], col = "orange")
  lines(seq(0,(8*5000)), aver_time_series_5000[1:(8*5000+1)], col = "green")
  legend("topright", title = "Community Size", c("500", "1000", "2500", "5000"),
         lty=1, col = c("red", "blue", "orange", "green"))
  dev.off()
}
  


###Q21
#Fractal dimension D can be calculated by log(N)/log(r), whereas N is the dividing factor and r is the scaling factor.
#For the first object, N is 8 (area is 8 times bigger), r is 3 (length is 3 times larger), therefore D = log(8)/log(3) = 1.89
#For the second one, N is 20 (volume is 20 times bigger), r is 3 (length is 3 times larger), therefore D = log(20)/log(3) = 2.73

###Q22
chaos_game = function(){
  graphics.off()
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  P <- list(A,B,C)
  x = A[1]
  y = A[2]
  pdf(file = "../Result/Q22Plot.pdf") 
  plot(NA, xlim = c(0,5), ylim = c(0,5), xlab="X", ylab="Y")
  points(x,y, cex = 0.2)
  #points(2,0.5, cex = 0.2)
  for (i in 1:1000){
    coor = unlist(sample(P,1))
    x1 = coor[1]
    y1 = coor[2]
    x = (0.5*(x+x1))
    y = (0.5*(y+y1))
    points(x, y, cex = 0.2)
  }
  dev.off()
}

#Challenge question E

#try with different start point and color different steps
graphics.off()
A = c(0,0)
B = c(3,4)
C = c(4,1)
P <- list(A,B,C)
x = 1
y = 5
pdf(file = "../Result/challengeE1.pdf") 
plot(NA, xlim = c(0,5), ylim = c(0,5), xlab="X", ylab="Y")
points(x,y, cex = 0.3)
for (i in 1:100){
  coor = unlist(sample(P,1))
  x1 = coor[1]
  y1 = coor[2]
  x = (0.5*(x+x1))
  y = (0.5*(y+y1))
  points(x, y, cex = 0.3, col = "red")
}
for (i in 101:300){
  coor = unlist(sample(P,1))
  x1 = coor[1]
  y1 = coor[2]
  x = (0.5*(x+x1))
  y = (0.5*(y+y1))
  points(x, y, cex = 0.3, col = "limegreen")
}
for (i in 301:1000){
  coor = unlist(sample(P,1))
  x1 = coor[1]
  y1 = coor[2]
  x = (0.5*(x+x1))
  y = (0.5*(y+y1))
  points(x, y, cex = 0.3, col = "dodgerblue2")
}
dev.off()
#The start point seems not to influence the pattern generated eventually.

#classic Sierpinski Gasket
graphics.off()
A = c(0,0)
B = c(2,sqrt(12))
C = c(4,0)
P <- list(A,B,C)
x = A[1]
y = A[2]
pdf(file = "../Result/challengeE2.pdf") 
plot(NA, xlim = c(0,5), ylim = c(0,5), xlab="X", ylab="Y")
points(x,y, cex = 0.1)
for (i in 1:10000){
  coor = unlist(sample(P,1))
  x1 = coor[1]
  y1 = coor[2]
  x = (0.5*(x+x1))
  y = (0.5*(y+y1))
  points(x, y, cex = 0.2)
}
dev.off()

###Q23
#draw a line of given length from a given point and in a given direction
turtle = function(start,direction,distance){
  x = start[1]
  y = start[2]
  x1 = x + distance*cos(direction)
  y1 = y + distance*sin(direction)
  segments(x,y,x1,y1)
  end = c(x1,y1)
  return(end)
}
plot(NA, xlim=c(0,10), ylim=c(0,10), xlab="X", ylab="Y")
turtle(c(1,1),0,2)
graphics.off()

###Q24
#call turtle twice to draw a pair of lines that join together
elbow = function(start, direction, distance){
  end = turtle(start, direction, distance)
  direction = (direction - pi/4)
  distance = 0.95*distance
  end = turtle(end, direction, distance)
}
plot(NA, xlim=c(0,10), ylim=c(0,10),xlab="X", ylab="Y")
elbow(c(1,1),pi/2,2)
graphics.off()


###Q25
#an iterative function that draws a spiral
spiral = function(start, direction, distance){
  end = turtle(start, direction, distance)
  direction = (direction - pi/4)
  distance = 0.95*distance
  spiral(end, direction, distance)
}
plot(NA, xlim=c(0,10), ylim=c(0,10),xlab="X", ylab="Y")
spiral(c(4,6),pi/4,2)
graphics.off()
#Error message (evaluation nested too deeply: infinite recursion) occurs because this is an endless iteration.
#The distance and direction can always get smaller and the computer have not idea when to stop, therefore runs into error.

###Q26
#amend spiral function so it won't crash down
spiral_2 = function(start, direction, distance){
  end = turtle(start, direction, distance)
  direction = (direction - pi/4)
  distance = 0.95*distance
  if (distance > 0.01){
    spiral_2(end, direction, distance)
  }
}
pdf(file = "../Result/Q26Plot.pdf") 
plot(NA, xlim=c(0,10), ylim=c(0,10), xlab="X", ylab="Y")
spiral_2(c(1,6),pi/4,3.5)
dev.off()
#For the certain size e I have tried from 0.01 to 1*e-13, and they all worked. I suppose computer can accept quite small value.
#By human eyes we can't tell the differences on this pattern, when e gets smaller than 0.1, so I would use 0.01 as a stop point for convenience.

###Q27
#get a tree shape as output
tree = function(start, direction, distance){
  end = turtle(start, direction, distance)
  direction1 = (direction - pi/4)
  direction2 = (direction + pi/4)
  distance = 0.65*distance
  if (distance > 0.01){
    tree(end, direction1, distance)
    tree(end, direction2, distance)
  }
}
graphics.off()
pdf(file = "../Result/Q27Plot.pdf") 
plot(NA, xlim=c(0,10), ylim=c(0,10), xlab="X", ylab="Y")
tree(c(5,0),pi/2,3.5)
dev.off()

###Q28
#get a fern shape as output
fern = function(start, direction, distance){
  end = turtle(start, direction, distance)
  direction1 = direction + pi/4
  direction2 = pi/2
  if (distance > 0.01){
    fern(end, direction1, 0.87*distance)
    fern(end, direction2, 0.38*distance)
  }
}
plot(NA, xlim=c(0,10), ylim=c(0,10), xlab="X", ylab="Y")
fern(c(6,0),pi/4,3.5)
graphics.off()


###Q29
#get a fern shape but with adjusted side branches
fern_2 = function(start, direction, distance, dir){
  end = turtle(start, direction, distance)
  direction1 = direction - (pi/4)*dir
  dir = dir*-1
  if (distance > 0.01){
    fern_2(end,direction1, 0.38*distance, dir)
    fern_2(end,direction, 0.87*distance, dir)
  }
}
pdf(file = "../Result/Q29Plot.pdf") 
plot(NA, xlim=c(0,20), ylim=c(0,20), xlab="X", ylab="Y")
fern_2(c(10,0),pi/2,2.8,-1)
dev.off()

#Challenge F
challenge_F <- function(){
 turtle_1 = function(start,direction,distance){
   x = start[1]
   y = start[2]
   x1 = x + distance*cos(direction)
   y1 = y + distance*sin(direction)
   if (distance > 1){
     col = "saddlebrown"
     lwd = 3
     lty = 1
   }else {
     col = "forestgreen"
     lwd = 1
     lty = 6
   }
   segments(x,y,x1,y1, col = col, lwd = lwd, lty = lty)
   end = c(x1,y1)
   return(end)
 }
   tree = function(start, direction, distance){
     end = turtle_1(start, direction, distance)
     direction1 = (direction - pi/4)
     direction2 = (direction + pi/4)
     distance = 0.65*distance
     if (distance > 0.01){
       tree(end, direction1, distance)
       tree(end, direction2, distance)
     }
   }
   pdf(file = "../Result/challengeF1.pdf") 
   plot(NA, xlim=c(0,10), ylim=c(0,10), xlab="X", ylab="Y")
   tree(c(5,0),pi/2,3.5)
   dev.off()
}

challenge_F2 <- function(){
  turtle_2 = function(start,direction,distance){
    x = start[1]
    y = start[2]
    x1 = x + distance*cos(direction)
    y1 = y + distance*sin(direction)
    if (distance > 0.8){
      col = "orange4"
      lwd = 2
      lty = 1
    }else {
      col = "chartreuse4"
      lwd = 1
      lty = 3
    }
    segments(x,y,x1,y1, col = col, lwd = lwd, lty = lty)
    end = c(x1,y1)
    return(end)
  }
 fern_2 = function(start, direction, distance, dir){
   end = turtle_2(start, direction, distance)
   direction1 = direction - (pi/3)*dir
   dir = dir*-1
   if (distance > 0.01){
    fern_2(end,direction1, 0.38*distance, dir)
    fern_2(end,direction, 0.87*distance, dir)
   }
 }
 pdf(file = "../Result/challengeF2.pdf") 
 plot(NA, xlim=c(0,20), ylim=c(0,22), xlab="X", ylab="Y")
 fern_2(c(10,0),pi/2,2.8,-1)
 dev.off()
}
#As the value of e get smaller, the time required to produce the image becomes longer but a more detailed image produced.

