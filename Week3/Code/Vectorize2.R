#! /usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .


# always clear the workspace
rm(list=ls())


#avoid one loop by apply
stochrickvect<-function(p1=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  
  M<-matrix(NA,numyears,length(p1))
  M[1,]<-p1
  
  #vectorize
  ex<-function(x){
    for(i in 2:numyears){
    x[i]<-x[i-1]*exp(r*(1-x[i-1]/K)+rnorm(1,0,sigma))
    }
    return(x)
    }
  M<- apply(M,2,ex)   #pass the columns one by one to function ex
  
  return(M)
  
}



# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))

