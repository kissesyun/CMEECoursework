#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# Plot the graphs

#clear workspace
rm(list=ls())
graphics.off()

library(ggplot2)
library(dplyr)

df <- read.csv("../Result/Data.csv")
cubic <- read.csv("../Result/cubic_model.csv")
briere <- read.csv("../Result/briere_model.csv")
sc1 <- read.csv("../Result/schoolfield_model1.csv")
sc2 <- read.csv("../Result/schoolfield_model2.csv")
sc3 <- read.csv("../Result/schoolfield_model3.csv")
df <- df[,c(2,4,5,7)]

#how many converge
length(which(cubic$Converge == 'Y'))
length(which(briere$Converge == 'Y'))
length(which(sc1$Converge == 'Y'))
length(which(sc1$Converge == 'F'))
length(which(sc2$Converge == 'Y'))
length(which(sc3$Converge == 'Y'))

#define functions to plot the corresponding graph 
#define k constant
k = 8.6173303e-05

#cubic
cubic_plot <- function(i){
  
  #get the i group
  group_x = subset(df, GroupID == i)
  group_p = subset(cubic, GroupID == i)
  
  #get data for plotting
  x <- group_x$KTemp
  a <- group_p$a
  b <- group_p$b
  c <- group_p$c
  d <- group_p$d
    
  #the x axis dataset for plotting
  x_cubic <- as.numeric(seq(min(x),max(x),0.1))
  
    
  #get the corresponding y_values from the sampled x_points using the model equation
  y_cubic <- a + b*x_cubic + c*(x_cubic)^2 + d*(x_cubic)^3
  
  xy <- data.frame(x_cubic, y_cubic)
  return(xy)
}

#briere
briere_plot <- function(i){
  
  #get the i group
  group_x = subset(df, GroupID == i)
  group_p = subset(briere, GroupID == i)
  
  #get data for plotting
  x <- group_x$KTemp
  B0 <- group_p$B0
  Tm <- group_p$Tm
  T0 <- group_p$T0
  
  #the x axis dataset for plotting
  
  x_briere <- as.numeric(seq(min(x),max(x),0.1))
  
  
  #get the corresponding y_values from the sampled x_points using the model equation
  y_briere <- B0*x_briere*((x_briere)-T0)*((Tm-(x_briere))^0.5)
  
  xy <- data.frame(x_briere, y_briere)
  return(xy)
}

#sc1
sc1_plot <- function(i){
  
  #get the i group
  group_x = subset(df, GroupID == i)
  group_p = subset(sc1, GroupID == i)
  
  #get data for plotting
  x <- group_x$KTemp
  B0 <- group_p$B0
  E <- group_p$E
  Eh <- group_p$Eh
  El <- group_p$El
  Th <- group_p$Th
  Tl <- group_p$Tl
  
  #the x axis dataset for plotting
  x_sc1 <- as.numeric(seq(min(x),max(x),0.1))
  
  
  #get the corresponding y_values from the sampled x_points using the model equation
  y_sc1 <- (B0*exp((-E/k)*((1/(x_sc1))-(1/283.15)))) / (1 + (exp((El/k)*((1/Tl)-(1/(x_sc1))))) + (exp((Eh/k)*((1/Th)-(1/(x_sc1))))))
  
  xy <- data.frame(x_sc1, y_sc1)
  return(xy)
}

#sc2
sc2_plot <- function(i){
  
  #get the i group
  group_x = subset(df, GroupID == i)
  group_p = subset(sc2, GroupID == i)
  
  #get data for plotting
  x <- group_x$KTemp
  B0 <- group_p$B0
  E <- group_p$E
  Eh <- group_p$Eh
  Th <- group_p$Th
  
  #the x axis dataset for plotting
  x_sc2 <- as.numeric(seq(min(x),max(x),0.1))
  
  
  #get the corresponding y_values from the sampled x_points using the model equation
  y_sc2 <- (B0*exp((-E/k)*((1/(x_sc2))-(1/283.15)))) / (1 + (exp((Eh/k)*((1/Th)-(1/(x_sc2))))))
  
  xy <- data.frame(x_sc2, y_sc2)
  return(xy)
}

#sc3
sc3_plot <- function(i){
  
  #get the i group
  group_x = subset(df, GroupID == i)
  group_p = subset(sc3, GroupID == i)
  
  #get data for plotting
  x <- group_x$KTemp
  B0 <- group_p$B0
  E <- group_p$E
  El <- group_p$El
  Tl <- group_p$Tl
  
  #the x axis dataset for plotting
  x_sc3 <- as.numeric(seq(min(x),max(x),0.1))
  
  
  #get the corresponding y_values from the sampled x_points using the model equation
  y_sc3 <- (B0*exp((-E/k)*((1/(x_sc3))-(1/283.15)))) / (1 + (exp((El/k)*((1/Tl)-(1/(x_sc3))))))
 
  xy <- data.frame(x_sc3, y_sc3)
  return(xy) 
}

#plotting graphs for fitted models
n = length(unique(df$GroupID))

#plot the groups which converge at all models
pdf("../Result/model_plot.pdf")  
for (i in 1:n) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  #set conditions
  if(cubic_g$Converge == 'Y' & briere_g$Converge == 'Y' &
     sc1_g$Converge == 'Y' & sc2_g$Converge == 'Y' & sc3_g$Converge == 'Y'){
    
    #plot
    plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
      geom_point(color="red") +
      geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
      geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
      geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
      geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
      geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
      scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                    'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
      labs(color = 'Models') + 
      xlab("Temperature") +
      ylab("Original Trait Value") +
      ggtitle(paste("GroupID:",i)) 
  
    print(plot)
  }
}
dev.off()

#plot all the groups
pdf("../Result/model_plot_all.pdf")  
for (i in 1:n) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    labs(color = "Models") 
    
    if (briere_g$Converge == 'Y'){
      plot <- plot + geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere"))
    }
    
    if (sc1_g$Converge == 'Y'){
      plot <- plot +geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" ))
    }
  
    
    if (sc2_g$Converge == 'Y'){
      plot <- plot + geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)"))
    }
    
    if (sc3_g$Converge == 'Y'){
      plot <- plot + geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)"))
    }
    
    print(plot)
  
}
dev.off()

#scatter plot for AIC
aic_b <- c()
id_b <- c()
for (i in 1:n){
  briere_g <- subset(briere, GroupID ==i)
  if (briere_g$Converge == 'Y'){
    aic <- briere_g$AIC
    id <- i
    aic_b <- c(aic_b,aic)
    id_b <- c(id_b, id)
  }
}
AIC_b <- data.frame(id_b, aic_b)

aic_sc1 <- c()
id_sc1 <- c()
for (i in 1:n){
  sc1_g <- subset(sc1, GroupID ==i)
  if (sc1_g$Converge == 'Y'){
    aic <- sc1_g$AIC
    id <- i
    aic_sc1 <- c(aic_sc1,aic)
    id_sc1 <- c(id_sc1, id)
  }
}
AIC_sc1 <- data.frame(id_sc1, aic_sc1)

aic_sc2 <- c()
id_sc2 <- c()
for (i in 1:n){
  sc2_g <- subset(sc2, GroupID ==i)
  if (sc2_g$Converge == 'Y'){
    aic <- sc2_g$AIC
    id <- i
    aic_sc2 <- c(aic_sc2,aic)
    id_sc2 <- c(id_sc2, id)
  }
}
AIC_sc2 <- data.frame(id_sc2, aic_sc2)

aic_sc3 <- c()
id_sc3 <- c()
for (i in 1:n){
  sc3_g <- subset(sc3, GroupID ==i)
  if (sc3_g$Converge == 'Y'){
    aic <- sc3_g$AIC
    id <- i
    aic_sc3 <- c(aic_sc3,aic)
    id_sc3 <- c(id_sc3, id)
  }
}
AIC_sc3 <- data.frame(id_sc3, aic_sc3)

id_c <- cubic$GroupID
aic_c <- cubic$AIC
AIC_c <- data.frame(id_c, aic_c)

pdf("../Result/scatter_AIC.pdf")
p <- ggplot()+
  geom_point(data = AIC_c, aes(id_c, aic_c,color = "Cubic"), size = 0.5) +
  geom_point(data = AIC_b, aes(id_b, aic_b, color = "Briere"), size = 0.5) +
  geom_point(data = AIC_sc1, aes(id_sc1, aic_sc1, color = "Schoolfield"), size = 0.5) +
  geom_point(data = AIC_sc2, aes(id_sc2, aic_sc2, color = "Schoolfield (s_high)"), size = 0.5) +
  geom_point(data = AIC_sc2, aes(id_sc2, aic_sc2, color = "Schoolfield (s_low)"), size = 0.5) +
  scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
  labs(color = 'Models') + 
  xlab("Group") +
  ylab("AIC") +
  ggtitle("AIC distribution for different models among all groups") 
print(p)
dev.off()

#find the smallest AIC among a group
df_AIC <- data.frame(cubic$AIC, briere$AIC, sc1$AIC, sc2$AIC, sc3$AIC)
colnames(df_AIC) <- c("cubic", "briere", "sc1", "sc2", "sc3")
df_AIC$minAIC <- NA
df_AIC$best <- NA

#define a function to put in min 
get_min_aic <- function(x){
  index <- which.min(x)
  x[6] <- x[index]
  if(index == 1){
    x[7] <- "cubic"
  }
  if(index == 2){
    x[7] <- "briere"
  }
  if(index == 3){
    x[7] <- "sc1"
  }
  if(index == 4){
    x[7] <- "sc2"
  }
  if(index == 5){
    x[7] <- "sc3"
  }
  return(x)
}

#generate a dataframe to store AIC info
df_final <- apply(df_AIC, 1, get_min_aic)
df_final <- t(df_final)
df_final <- as.data.frame(df_final)
df_final$GroupID <- c(1:1935)
df_final <- df_final %>% select(GroupID, everything())

#group the IDs and add index (use pip,group_indices,select from dplyr )
df_final$Model <- df_final %>% group_indices(best) 
#move the GroupID to the left column
df_final <- df_final %>% select(Model, everything())
#sort by the GroupIDs
df_final <- df_final[order(df_final$Model),]
#model1 = briere, model2 = cubic, model3 = sc1, model4 = sc2, model5 = sc3
df_s <- df_final[, c(1,2,8)]
df_s$minAIC <- as.numeric(levels(df_s$minAIC))[df_s$minAIC]
summary(df_s$minAIC)

model1 <- subset(df_s, Model == 1)
model2 <- subset(df_s, Model == 2)
model3 <- subset(df_s, Model == 3)
model4 <- subset(df_s, Model == 4)
model5 <- subset(df_s, Model == 5)

pdf("../Result/model_AIC.pdf")
p <- ggplot()+
  geom_point(data = model1, aes(GroupID, minAIC, color = "Briere"), size = 0.5) +
  geom_point(data = model2, aes(GroupID, minAIC, color = "Cubic"), size = 0.5) +
  geom_point(data = model3, aes(GroupID, minAIC, color = "Schoolfield"), size = 0.5) +
  geom_point(data = model4, aes(GroupID, minAIC, color = "Schoolfield (s_high)"), size = 0.5) +
  geom_point(data = model5, aes(GroupID, minAIC, color = "Schoolfield (s_low)"), size = 0.5) +
  scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
  labs(color = 'Models') + 
  xlab("Group") +
  ylab("minAIC") +
  ggtitle("Minimal AIC distribution for all groups") 
print(p)
dev.off()

#plot the example graphs for the report
pdf("../Result/example1.pdf")  
for (i in 23) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
    #geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
    geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
    #geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
    scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 
                                  'Schoolfield (s_high)' = 'dodgerblue')) +
    labs(color = 'Models') + 
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) 
  
  print(plot)
  
}
dev.off()

pdf("../Result/example2.pdf")  
for (i in 99) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
    geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
    geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
    #geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
    scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                  'Schoolfield (s_high)' = 'dodgerblue')) +
    labs(color = 'Models') + 
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) 
  
  print(plot)
  
}
dev.off()

pdf("../Result/example3.pdf")  
for (i in 153) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
    #geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
    geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
    geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
    scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 
                                  'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
    labs(color = 'Models') + 
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) 
  
  print(plot)
  
}
dev.off()

pdf("../Result/example4.pdf")  
for (i in 731) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
    geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
    geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
    geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
    scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                  'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
    labs(color = 'Models') + 
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) 
  
  print(plot)
  
}
dev.off()

pdf("../Result/example5.pdf")  
for (i in 1543) {
  print(i)
  
  #get the group
  cubic_g <- subset(cubic, GroupID == i)
  briere_g <- subset(briere, GroupID ==i)
  sc1_g <- subset(sc1, GroupID ==i)
  sc2_g <- subset(sc2, GroupID ==i)
  sc3_g <- subset(sc3, GroupID ==i)
  df_g <- subset(df, GroupID ==i)
  x_point <- df_g$KTemp
  y_point <- df_g$OriginalTraitValue
  
  
  
  #plot
  plot <- ggplot(data=df_g, aes(x=x_point, y=y_point)) + 
    geom_point(color="red") +
    geom_line(data=cubic_plot(i), aes(x_cubic, y_cubic, color = "Cubic")) + 
    geom_line(data=briere_plot(i), aes(x_briere, y_briere, color = "Briere")) +
    geom_line(data=sc1_plot(i), aes(x_sc1, y_sc1, color = "Schoolfield" )) +
    geom_line(data=sc2_plot(i), aes(x_sc2, y_sc2, color = "Schoolfield (s_high)")) +
    geom_line(data=sc3_plot(i), aes(x_sc3, y_sc3, color = "Schoolfield (s_low)")) +
    scale_color_manual(values = c('Cubic' = 'orange', 'Briere' = 'hotpink', 'Schoolfield' = 'purple', 
                                  'Schoolfield (s_high)' = 'dodgerblue', 'Schoolfield (s_low)' = 'forestgreen')) +
    labs(color = 'Models') + 
    xlab("Temperature") +
    ylab("Original Trait Value") +
    ggtitle(paste("GroupID:",i)) 
  
  print(plot)
  
}
dev.off()