#!/usr/bin/env Rscript

#clear workspace and turn off graphics
rm(list = ls())
graphics.off()

#copy and paste some of the functions written before
#and also cluster_run function

species_richness <- function(community){
  a <- unique(community)
  length(a)
}

initialise_min <- function(size){
  rep(1,size)
}

choose_two <- function(x){
  sample(seq(x),2,replace = FALSE)
}

neutral_step_speciation <- function(community, v){ 
  indexes <- choose_two(length(community)) 
  #speciation occurs when the random number generated is smaller than v 
  #speciated individual will be replaced with a new one
  if ((runif(1, 0, 1) <= v)){ 
    nextstep <- replace(community, indexes[1], (max(community)+1)) 
  }
  #if speciation doesn't happen, do it with ordinary neutral step 
  else{ 
    nextstep <- replace(community, indexes[1], community[indexes[2]]) 
  }
  return(nextstep) 
}  

neutral_generation_speciation <- function(community,v){ 
  #ceiling can be used to round up uneven abundances
  for (i in 1:ceiling((length(community)/2))){ 
    community <- neutral_step_speciation(community,v) 
  }
  return(community)
}

species_abundance <- function(community){
  as.vector(sort(table(community), decreasing = T)) 
}

octaves <- function(community){ 
  #the boundary is less than 2^n, so use ?floor
  #tabulate only takes integers into account, so no zero
  tabulate(floor(log2(community)) + 1)
}

sum_vect <- function(x,y){
  if (length(x)<length(y)){ 
    x <- append(x, rep(0, (length(y)-length(x)))) 
  }
  if (length(y)<length(x)){ 
    y <- append(y, rep(0, (length(x)-length(y)))) 
  }
  x + y 
}

cluster_run = function(speciation_rate, size, wall_time, interval_rich, 
                       interval_oct, burn_in_generations, output_file_name) {
  #set a start time
  start = as.numeric(proc.time()[3])
  
  #run stimulation
  community = initialise_min(size)
  n = 1
  i = 1
  richness = vector()
  oct = list()
  while (as.numeric(proc.time()[3]) - start < wall_time*60) {
    community = neutral_generation_speciation(community, speciation_rate)
    if (n %% interval_oct == 0) {
      abundance = species_abundance(community)
      oct[[i]] = octaves(abundance)
      i = i + 1
    }
    # burn-in period
    if (n <= burn_in_generations) {
      if (n %% interval_rich == 0) {
        richness = c(richness, species_richness(community))
      }
    }
    n = n + 1
  }
  
  run_time = (as.numeric(proc.time()[3]) - start)/60
  
  save(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, run_time, 
       richness, oct, community, file = output_file_name)
  
}

#local test
#cluster_run(speciation_rate = 0.1, size = 100, wall_time = 10, 
             #interval_rich = 1, interval_oct = 10, burn_in_generations = 200, output_file_name = "../Result/my_test_file_1.rda")

#read in the job number from the cluster
iter = as.numeric(Sys.getenv(("PBS_ARRAY_INDEX")))
#iter = 1
output = paste("sl518_cluster_", iter, ".rda", sep = "")
#output = paste("../Sandbox/sl518_cluster_", iter, ".rda", sep = "")


# if (iter%%4==1) {
#   cluster_run(
#     speciation_rate = 0.003443,
#     size = 100,
#     wall_time = 5*2,
#     interval_rich = 1,
#     interval_oct = 10,
#     burn_in_generations = 200,
#     output_file_name = output
#   )
# }

if (iter%%4==1) {
    cluster_run(
    speciation_rate = 0.003443,
    size = 500,
    wall_time = 10,
    interval_rich = 1,
    interval_oct = 50,
    burn_in_generations = 4000,
    output_file_name = output
  )
}

if (iter%%4==2) {
  cluster_run(
    speciation_rate = 0.003443,
    size = 1000,
    wall_time = 10,
    interval_rich = 1,
    interval_oct = 100,
    burn_in_generations = 8000,
    output_file_name = output
  )
}

if (iter%%4==3) {
  cluster_run(
    speciation_rate = 0.003443,
    size = 2500,
    wall_time = 10,
    interval_rich = 1,
    interval_oct = 250,
    burn_in_generations = 20000,
    output_file_name = output
  )
}

if (iter%%4==0) {
  cluster_run(
    speciation_rate = 0.003443,
    size = 5000,
    wall_time = 10,
    interval_rich = 1,
    interval_oct = 500,
    burn_in_generations = 40000,
    output_file_name = output
  )
}
 