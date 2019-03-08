#!/usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# Prepare the dataset to be analysed

#clear workspace
rm(list=ls())
graphics.off()

library(dplyr)

#load the data
MyData <- read.csv("../Data/BioTraits.csv")
head(MyData)

#extra the useful data columns (FinalID, StandardisedTraitName, OriginalTraitValue and ConTemp)
MyData <- MyData[,c(3,6,8,67)]
head(MyData)

#deal with negative or zero value or NA
summary(MyData$OriginalTraitValue)
summary(MyData$ConTemp)
#negative and 0 values
MyData <- MyData[MyData$OriginalTraitValue>0,]
#NA values
MyData <- MyData[complete.cases(MyData),]

#group the data by ID and remove those have less than 5 entries(use pip,group_by,filter from dplyr )
MyData <- MyData %>% 
  group_by(FinalID) %>% 
  filter(n() >= 5)

#group the IDs and add unique IDs for index (use pip,group_indices,select from dplyr )
MyData$GroupID <- MyData %>% group_indices(FinalID) 
#move the GroupID to the left column
MyData <- MyData %>% select(GroupID, everything())
#sort by the GroupIDs
MyData <- MyData[order(MyData$GroupID),]

#remove the groups where ConTemp are same values (otherwise is a vertical line on graph, not informative for model fitting)
o = length(unique(MyData$GroupID))

for(i in 1:o){
  group <- subset(MyData, MyData$GroupID == i)
  u <- length(unique(group$ConTemp))
  if(u==1){
    print(i)
  }
}

MyData <- MyData[!(MyData$GroupID=="1345"),]
MyData <- MyData[!(MyData$GroupID=="1346"),]
MyData <- MyData[!(MyData$GroupID=="1347"),]
MyData <- MyData[!(MyData$GroupID=="1348"),]

MyData$GroupID <-NULL

MyData$GroupID <- MyData %>% group_indices(FinalID) 

MyData <- MyData %>% select(GroupID, everything())

MyData <- MyData[order(MyData$GroupID),]


#add kelvin temperature column
MyData$KTemp <- MyData$ConTemp + 273.15

#add log origianl trait value column for Schoolfield model
MyData$LogTraitValue <- log(MyData$OriginalTraitValue)

#add 1/kT column for Schoolfield model
MyData$TransT <- 1/(8.617e-5*MyData$KTemp)

#add parameter column
#MyData <- data.frame(append(MyData, list(T0 = "", Tm = "",B0 = "",E = "",Eh = "",El = "",Th = "",Tl = "")))
MyData$T0 <- NA
MyData$Tm <- NA
MyData$B0 <- NA
MyData$E <- NA
MyData$Eh <- NA
MyData$El <- NA
MyData$Th <- NA
MyData$Tl <- NA

#MyData$T0 <- NULL
#MyData$Tm <- NULL
#MyData$B0 <- NULL
#MyData$E <- NULL
#MyData$Eh <- NULL
#MyData$El <- NULL
#MyData$Th <- NULL
#MyData$Tl <- NULL

#calculate start parameters for NLLS fitting
n = length(unique(MyData$GroupID))

#Briere model parameters
for (i in 1:n){
  #get the group subset
  group <- subset(MyData, GroupID == i)
  T0 <- min(group$KTemp)
  Tm <- max(group$KTemp)
  MyData$T0[MyData$GroupID == i] <- rep(T0, nrow(group))
  MyData$Tm[MyData$GroupID == i] <- rep(Tm, nrow(group))
}  

#Schoolfield model parameters
for (i in 1:n){
  #get the group subset and ordered by KTemp in an ascending order
  group <- subset(MyData, GroupID == i)
  group <- group[order(group$TransT),]
  
  #B0 
  index = which.min(abs(group$KTemp-283.15)) 
  B0 = group$OriginalTraitValue[index]
  MyData$B0[MyData$GroupID == i] <- rep(B0, nrow(group))
  
  #Eh(the left hand slope on log curve)
  #The slope of the regression line can be accessed by summary lm and get coefficients
  x <- group$TransT
  y <- group$LogTraitValue
  z <- group$KTemp
  
  point1 = which.max(y)
  if(point1 > 1){
    x1 <- x[1:point1]
    y1 <- y[1:point1]
    #Eh <- summary(lm(y1~x1))$coefficients[2,1]
    Eh <- tryCatch(summary(lm(y1~x1))$coefficients[2,1], error=function(err) NA)
    
  }else{
    #Eh <- summary(lm(y~x))$coefficients[2,1]
    Eh <- tryCatch(summary(lm(y~x))$coefficients[2,1], error=function(err) NA)
  }
  MyData$Eh[MyData$GroupID == i] <- rep(Eh, nrow(group))
  
  #E(the right hand slope on log curve however the x value is 1/kT, therefore counting from small x
  #to x when corresponding y is max)
  point2 <- which(y == max(y))
  if (length(point2) >1) {
    point2 = tail(point2, n=1)
  }
  if(point2<length(y)){
    x2 <- x[point2:length(y)]
    y2 <- y[point2:length(y)]
    E <- tryCatch(summary(lm(y2~x2))$coefficients[2,1], error=function(err) NA)
  }else{
    E <- tryCatch(summary(lm(y~x))$coefficients[2,1], error=function(err) NA)
  }
  MyData$E[MyData$GroupID == i] <- rep(E, nrow(group))
  
  #El
  El <- E/2
  MyData$El[MyData$GroupID == i] <- rep(El, nrow(group))
  
  #Th
  Th <- z[point1]
  MyData$Th[MyData$GroupID == i] <- rep(Th, nrow(group))
  
  #Tl
  Tl <- min(z)
  MyData$Tl[MyData$GroupID == i] <- rep(Tl, nrow(group))
}

#fill the NAs generated during lm by median value
summary(MyData$E)
summary(MyData$Eh)
summary(MyData$El)

MyData1 <- MyData
MyData1$FinalID <- NULL
g1 <- subset(MyData1, is.na(MyData1$E))
length(unique(g1$GroupID))
#3
g2 <- subset(MyData1, is.na(MyData1$Eh))
length(unique(g2$GroupID))
#161

MyData$E[is.na(MyData$E)] <- -0.5663
MyData$Eh[is.na(MyData$Eh)] <- 0.5520
MyData$El[is.na(MyData$El)] <- -0.2832

#MyData$E[is.na(MyData$E)] <- -0.5712
#MyData$Eh[is.na(MyData$Eh)] <- 0.6939
#MyData$El[is.na(MyData$El)] <- -0.2856




#change the name of 1/kT for further script
#colnames(MyData)[8] <- 'TransT'

#save
write.csv(MyData, file = "../Result/Data.csv")
  
