# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

tree <- read.csv("../data/trees.csv", header = TRUE)

TreeHeight <- function(degrees, distance)
  {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  return (height)
}

distance <- data.frame()

for (i in 1:nrow(tree)){
  distance[i,1]<-TreeHeight(tree[i,3],tree[i,2])
}

names(distance) <- c("Tree.Height.m")

result<-cbind(tree, distance)

write.csv(result, file='../Result/TreeHts.csv')





