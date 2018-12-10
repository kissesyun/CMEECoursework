#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk

# This function calculates heights of trees given distance of each tree from its base and angle to its top, using  the trigonometric formula 
# height = distance * tan(radians)
# degrees: The angle of elevation of tree
# distance: The distance from base of tree (e.g., meters)
# OUTPUT: The heights of the tree, same units as "distance"
# Updated version of TreeHeight.R. It can take external input file as argument. And the output file name varies along with the input filename.


# readin the data file
args <- commandArgs(trailingOnly = TRUE)  #commandArgs to take argument from command line
filename <- args[1]
tree <- read.csv(file = filename, header = TRUE)

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

#split the input filename and take out the bit we want to insert in the output filename
aa <- unlist(strsplit(filename, "/", fixed = TRUE)) #strsplit on "/"
bb <- tail(aa,1) #take the last element
cc <- unlist(strsplit(bb, ".", fixed = TRUE))[1] #strsplit again on "."
dd <- paste(cc, "_treeheights.csv", sep = "") #concatenate the two strings

#write to the output file
write.csv(result, paste0('../Result/', dd), row.names=F) #paste0 to concatenate