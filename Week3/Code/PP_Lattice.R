#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# Plot lattice graph and calculate mean and median for subsets of dataset

#Clear the workspace and read the dataset
rm(list=ls())
MyDF <- read.csv("../Data/EcolArchives-E089-51-D1.csv")

#Load package and attach the dataframe 
library(lattice)
attach(MyDF)

# To unite the unit for prey mass
for (i in 1:length(Prey.mass)){
  if (Prey.mass.unit[i] == "mg") {
    Prey.mass[i] = MyDF$Prey.mass[i] / 1000
    Prey.mass.unit[i] = "g"
  }
}

#Plot lattive graph for predator mass by feeding interaction type
pdf("../Result/Pred_Lattice.pdf", 11.7, 8.3) 
densityplot(~log(Predator.mass) | Type.of.feeding.interaction,
            main = "Predator mass by feeding interaction type",
            data = MyDF)
dev.off()

#Plot lattive graph for prey mass by feeding interaction type
pdf("../Result/Prey_Lattice.pdf", 11.7, 8.3) 
densityplot(~log(Prey.mass) | Type.of.feeding.interaction,
            main = "Prey mass by feeding interaction type",
            data = MyDF)
dev.off()

#Plot lattive graph for predator-prey mass ratio by feeding interaction type
pdf("../Result/SizeRatio_Lattice.pdf", 11.7, 8.3) 
densityplot(~log(Predator.mass/Prey.mass) | Type.of.feeding.interaction,
            main = "Predator-prey mass ratio by feeding interaction type",
            data = MyDF)
dev.off()

#Calculate the mean and median for log predator and prey mass and also their log ratio.
mean_pred_mass <- tapply(log(Predator.mass), Type.of.feeding.interaction, mean) #use tapply to avoid loopy
median_pred_mass <- tapply(log(Predator.mass), Type.of.feeding.interaction, median)

mean_prey_mass <- tapply(log(Prey.mass), Type.of.feeding.interaction, mean)
median_prey_mass <- tapply(log(Prey.mass), Type.of.feeding.interaction, median)

mean_ratio <- tapply(log(Predator.mass/Prey.mass), Type.of.feeding.interaction, mean)
median_ratio <- tapply(log(Prey.mass/Predator.mass), Type.of.feeding.interaction, median)

#Store the result to a dataframe
result <- data.frame(mean_pred_mass, median_pred_mass, mean_prey_mass, median_prey_mass, mean_ratio, median_ratio) 
feeding_interaction_type <- rownames(result)
result <- cbind(feeding_interaction_type, result) #Turn the rownames column to a proper column

#Save the result to a csv file output
write.csv(result, "../Result/PP_Results.csv", row.names = F) #ignore the rowname

#Detach the dataframe
detach(MyDF)





