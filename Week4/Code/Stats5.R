#pdf16
rm(list=ls()) 	

daphnia  <-  read.delim("../Data/daphnia.txt") 	
summary(daphnia) 	

par(mfrow  =  c(1,  2)) 	
plot(Growth.rate  ~  Detergent,  data  =  daphnia) 	
plot(Growth.rate  ~  Daphnia,  data  =  daphnia) 

require(dplyr)

daphnia  %>%   	
  group_by(Detergent)  %>% 	
  summarise  (variance=var(Growth.rate)) 	
daphnia  %>%   	
  group_by(Daphnia)  %>% 	
  summarise  (variance=var(Growth.rate)) 	


seFun  <- function(x)  { 	
  sqrt(var(x)/length(x)) 	
} 	

detergentMean  <-  with(daphnia,  tapply(Growth.rate,  INDEX  =  Detergent, FUN  =  mean)) 	

detergentSEM  <-  with(daphnia,  tapply(Growth.rate,  INDEX  =  Detergent, FUN  =  seFun)) 	

cloneMean  <- with(daphnia,  tapply(Growth.rate,  INDEX  =  Daphnia,  FUN  =  mean)) 	

cloneSEM  <- with(daphnia,  tapply(Growth.rate,  INDEX  =  Daphnia,  FUN  =  seFun)) 	


par(mfrow=c(2,1),mar=c(4,4,1,1)) 	

barMids  <-  barplot(detergentMean,  xlab  =  "Detergent  type",  ylab  =  "Population  
                     growth  rate", ylim  =  c(0,  5)) 	

arrows(barMids,  detergentMean - detergentSEM,  barMids,  detergentMean  +  detergentSEM,  code  =  3,  angle  =  90) 	

barMids  <-  barplot(cloneMean,  xlab  =  "Daphnia  clone",  ylab  =  "Population  
                     growth  rate",  ylim  =  c(0,  5)) 	

arrows(barMids,  cloneMean - cloneSEM,  barMids,  cloneMean  +  cloneSEM, code  =  3,  angle  =  90) 	
daphniaMod  <-  lm(Growth.rate  ~  Detergent  +  Daphnia,  data  =  daphnia) 	

anova(daphniaMod) 

#pdf17
rm(list=ls())
hairEyes <- matrix(c(34, 59, 3, 10, 42, 47), ncol = 2, dimnames = list(Hair =
                    c("Black", "Brown", "Blond"), Eyes = c("Brown", "Blue")))
rowTot <- rowSums(hairEyes)  
colTot <- colSums(hairEyes)  
tabTot <- sum(hairEyes)  
Expected <- outer(rowTot, colTot)/tabTot  
Expected 
cellChi <- (hairEyes - Expected)^2/Expected
tabChi <- sum(cellChi)  
tabChi 
hairChi <- chisq.test(hairEyes)
print(hairChi) 



