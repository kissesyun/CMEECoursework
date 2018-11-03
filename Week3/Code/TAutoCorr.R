#! /usr/bin/env Rscript
# Autor: Shiyun Liu s.liu18@imperial.ac.uk
# Analyse the temperature data obtained from 100 years 

#clear workspace
rm(list=ls())

#load, examine and plot the data
load('../Data/KeyWestAnnualMeanTemperature.Rdata')

pdf('../Result/TAutoCorrP.pdf', 11.7, 8.3)
plot(ats,type='l')
dev.off()

summary.data.frame(ats)

# Calculate the correlation coefficient by cor(x,y) function
cor1 <- cor(ats[1:99,2], ats[2:100,2])

# Define a function to calculate cor between ramdom sets of years
sam <- function(){ 
                    x <- cor(sample(ats[1:99,2],99), sample(ats[2:100, 2],99))
                    return (x)
}

cor2 <- rep(NA, 10000) #create an empty vector to save time when write values in

# repeat the defined function 10000 times and store the values
for (i in 1:10000) { cor2[i] <- sam()
}

# Calculate the approximate P-value, fraction
frac = length(cor2[cor2>cor1])/length(cor2)


print(paste0("correlation coefficient between successive years is ", cor1))
print(paste0("P-value = ", frac))






