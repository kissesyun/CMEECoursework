#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk

# This function calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula 
# height = distance * tan(radians)
# degrees: The angle of elevation of tree
# distance: The distance from base of tree (e.g., meters)
# OUTPUT: The heights of the tree, same units as "distance"

# readin the data file
tree <- read.csv("../Data/trees.csv", header = TRUE)

# define the function to calculate treeheight
TreeHeight <- function(degrees, distance)
  {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  return (height)
}

# create a new dataframe to store the tree heights calculated from input data
distance <- data.frame()

for (i in 1:nrow(tree)){
  distance[i,1]<-TreeHeight(tree[i,3],tree[i,2])
}

names(distance) <- c("Tree.Height.m")

# combine the two dataframes
result<-cbind(tree, distance)

# write to the output file
write.csv(result, file='../Result/TreeHts.csv', row.names=F)





