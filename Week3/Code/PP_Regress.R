#!/usr/bin/env Rscript

#Clear the workspace and read the dataset
rm(list=ls())
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv") 

#Load package and attach the dataframe
library(ggplot2)
library(plyr)
attach(MyDF)

#Some mass values in mg, so looping through prey mass to convert them
l = length(MyDF$Prey.mass)
for (i in 1:l){
  if (MyDF$Prey.mass.unit[i] == "mg") {
    MyDF$Prey.mass[i] = MyDF$Prey.mass[i] / 1000
    MyDF$Prey.mass.unit[i] = "g"
  }
}

graph_pp <- ggplot(MyDF, aes(x = Prey.mass, y = Predator.mass, col = Predator.lifestage)) + geom_point(shape = 3) + geom_smooth(method = 'lm', fullrange = TRUE) + facet_grid(Type.of.feeding.interaction ~ .) + scale_y_continuous(trans = "log10") + scale_x_continuous(trans = "log10") + xlab("Prey Mass in grams") + ylab("Predator Mass in grams") + theme_bw() + theme(legend.position="bottom")+ coord_fixed(ratio = 0.3)+ guides(color = guide_legend(nrow=1)) #Creating the correct graph


pdf("../Results/PP_Regress.pdf", 11.7, 8.3) # Preparing to save the graph
print(graph_pp)

dev.off()

# take logs of the two mass columns for later use

MyDF[["Predator.mass"]] = log(MyDF$Predator.mass)
MyDF[["Prey.mass"]] = log(MyDF$Prey.mass)

li_lm <- dlply(MyDF, .(Type.of.feeding.interaction,Predator.lifestage), function(x) lm(Predator.mass~Prey.mass, data=x)) #splitting df by tofi and pl


df_coef <- ldply(li_lm, function(x) {   #using plyr as nothing else
  intercept = summary(x)$coefficients[1]#cretes a final usable format!
  slope = summary(x)$coefficients[2]  #creating columns for r_sq, p_val etc
  r_sq = summary(x)$r.squared
  p.value = summary(x)$coefficients[8]
  data.frame(intercept, slope, r_sq,p.value)}
)



f.stat = ldply(li_lm, function(x) { f.statistic = summary(x)$fstatistic[1]
data.frame(f.statistic)}) #F-stat was done seperately as it's not known until the model is run? Either way it's appended on at the end


regression = merge(df_coef, f.stat,  all=T) #merging

write.csv(regression, file = "../Results/PP_Regress_Results.csv") # saving