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
#define one single neutral step
neutral_step <- function(community){ 
  indexes <- choose_two(length(community)) 
  community[indexes[1]] <- community[indexes[2]]  
  return(community)
}

###Q6
#simulate several neutral steps
neutral_generation <- function(community){ 
  #ceiling can be used to round up uneven abundances
  for (i in 1:ceiling((length(community)/2))){ 
    community <- neutral_step(community) 
  }
  return(community)
}

###Q7
#initial is the initial condition community vector
neutral_time_series <- function(initial, duration){ 
  time_series <- c(species_richness(initial)) 
  for (i in 1:duration){ 
    initial <- neutral_generation(initial) 
    time_series[i+1] <- species_richness(initial) 
  }
  return(time_series) 
}

###Q8
#plot a time series graph
question_8 <- function(){ 
  pdf(file = "../Result/Q8Plot.pdf") 
  plot(neutral_time_series(initial=initialise_max(100), duration=200), 
       type = "l", 
       xlab = "Generations", 
       ylab = "Species Richness", 
       main = "Neutral Model Simulation") 
  dev.off() # turns graphics off
}

###Q9
neutral_step_speciation <- function(community, v){ 
  indexes <- choose_two(length(community)) 
  #the speciation occurs when the random number generated is smaller than v 
  if ((runif(1, 0, 1) <= v)){ 
    #replace the speciated individual with a new one(number)
    nextstep <- replace(community, indexes[1], (max(community)+1)) 
  }
  #when speciation does not happen
  else{ 
    #just like the neutral step before
    nextstep <- replace(community, indexes[1], community[indexes[2]]) 
  }
  return(nextstep) 
}  

###Q10
neutral_generation_speciation <- function(community,v){ 
  #ceiling can be used to round up uneven abundances
  for (i in 1:ceiling((length(community)/2))){ 
    community <- neutral_step_speciation(community,v) 
  }
  return(community)
}


###Q11
neutral_time_series_speciation <- function(community,v,duration){ 
  time_series <- c(species_richness(community)) 
  for (i in 1:duration){ 
    community <- neutral_generation_speciation(community,v) 
    time_series[i+1] <- species_richness(community) 
  }
  return(time_series) 
}

###Q12
#plot a time series graph
question_12 <- function(){ 
  pdf(file = "../Result/Q12Plot.pdf") 
  plot(neutral_time_series_speciation(community = initialise_max(100), v = 0.1, duration = 200), 
       type = "l", 
       col = "red",
       xlab = "Generations", 
       ylab = "Species Richness", 
       main = "Neutral Model Simulation") 
  lines(neutral_time_series_speciation(community = initialise_min(100), v = 0.1, duration = 200),
        col = "green")
  dev.off() # turns graphics off
}

###Q13
species_abundance <- function(community){
  as.vector(sort(table(community), decreasing = T)) 
}
#species_abundance(c(1,5,3,6,5,6,1,1))

###Q14
#first value: abundance of 1; 2nd value: abundance of 2 and 3; 3rd value: abundance of 4, 5, 6, 7;
octaves <- function(community){ 
  #the boundary is less than 2^n, so use ?floor
  #tabulate only takes integers into account, so no zero
  tabulate(floor(log2(community)) + 1)
}
#octaves(c(100,64,63,5,4,3,2,2,1,1,1,1))

###Q15
sum_vect <- function(x,y){
  if (length(x)<length(y)){ 
    x <- append(x, rep(0, (length(y)-length(x)))) 
  }
  if (length(y)<length(x)){ 
    y <- append(y, rep(0, (length(x)-length(y)))) 
  }
  x + y 
}

###Q16
question_16 <- function(){
  for (i in 1:200){ 
    community_200 <- neutral_generation_speciation(initialise_max(100), v = 0.1) 
  }
  abundance <- octaves(species_abundance(community_200))
  #and another 2000 rounds
  for (i in 1:2000){ 
    community_2000 <- neutral_generation_speciation(community_200, v = 0.1) 
    if (i %% 20 == 0){ 
      abundance <- sum_vect(abundance, octaves(species_abundance(community_2000))) 
    }
  }
  abundance <- abundance/101 
  pdf(file = "../Result/Q16Plot.pdf") 
  barplot(abundance, 
          main = "Species abundance for neutral model with speciation",
          xlab = "Species abundance",
          ylab = "Frequency") 
  dev.off() 
}
#try again for initialise_min(100)

challenge_A <- function(){
  #build dataframes to store max and min 
  com_initial_with_max <- data.frame(c(1:2201))
  com_initial_with_min <- data.frame(c(1:2201))
  #do multiple(try 100 here) simulations
  for (simulation in 1:100){ 
    community_max <- c(species_richness(initialise_max(100))) 
    #in each simulation, do 2200 generations
    for (generation in 1:2200){ 
      community_max <- neutral_generation_speciation(community_max, v = 0.1) 
    }
  }
}



###Q17







