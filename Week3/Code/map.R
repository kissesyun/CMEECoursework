#! /usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# map the Global Population Dynamics Database


#clear workspace
rm(list=ls())

# install the package maps and load it
install.packages("maps")
library(maps)

# load the data
load('../Data/GPDDFiltered.RData')

# Map a world map using maps package
map("world", boundary = TRUE, interior = TRUE, fill=TRUE, col="white", bg="deepskyblue")
points(gpdd$long, gpdd$lat, col="red", pch=16, cex = 0.5)

# Although this is supposed to be a global population database, 
# the majority of data was collected from North America and Europe. 
# Only a single or two from Asia and Africa and none from the rest of the world. 
# This is defiantly not a good representative of global population and can cause huge bias based on the regions where data collected from. 
