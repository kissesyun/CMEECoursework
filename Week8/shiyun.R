#clear the space
rm(list=ls())
graphics.off()

#store the simulated system
community <- c(1,4,4,5,1,6,1)

#define function to know the species richness
species_richness <- function(x){
  a <- unique(x)
  length(a)
}

