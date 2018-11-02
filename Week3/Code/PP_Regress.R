#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
#Use ggplot to plot a graph of predator-prey mass relationship and do analysis of regression

rm(list=ls())
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv") 

#Load package and attach the dataframe
library(ggplot2)
library(plyr)

# To unite the unit for prey mass
for (i in 1:length(MyDF$Prey.mass)){
  if (MyDF$Prey.mass.unit[i] == "mg") {
    MyDF$Prey.mass[i] = MyDF$Prey.mass[i] / 1000
    MyDF$Prey.mass.unit[i] = "g"
  }
}

#Plot the graph using ggplot
graph <- ggplot(MyDF, aes(x = Prey.mass, 
                             y = Predator.mass, 
                             col = Predator.lifestage)) + 
  geom_point(shape = 3) + 
  geom_smooth(method = 'lm', fullrange = TRUE) + 
  facet_grid(Type.of.feeding.interaction ~ .) + 
  scale_y_continuous(trans = "log",breaks = c(1e-06, 1e-02, 1e+02, 1e+06)) + scale_x_continuous(trans = "log", breaks = c(1e-07, 1e-03, 1e+01)) + 
  xlab("Prey Mass in grams") + ylab("Predator Mass in grams") + 
  theme_bw() + 
  theme(legend.position="bottom")+ 
  coord_fixed(ratio = 0.3)+ 
  guides(color = guide_legend(nrow=1)) 

#Save the graph using print
pdf("../Result/PP_Regress.pdf", 11.7, 8.3) 
print(graph)
dev.off()

#Analysis of Linear regression on subsets of the data


#split the dataframe and apply function to subsets of the data based on TOFI and PL
seta <- dlply(MyDF, .(Type.of.feeding.interaction,Predator.lifestage), function(x) lm(log(Predator.mass)~log(Prey.mass), data=x)) 

#calculate the coefficients
coef <- ldply(seta, function(x) {   
  intercept = summary(x)$coefficients[1]
  slope = summary(x)$coefficients[2] 
  r_sq = summary(x)$r.squared
  p.value = summary(x)$coefficients[8]
  data.frame(intercept, slope, r_sq, p.value)}
)

#calculate the f stats
fstat = ldply(seta, function(x) { 
f.statistic = summary(x)$fstatistic[1] 
data.frame(f.statistic)}) 

#combine them together
total = merge(coef, fstat,  all=T) 

#write the output to csv file
write.csv(total, file = "../Result/PP_Regress_Results.csv", row.names = F) 

