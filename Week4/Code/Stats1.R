#pdf1&2
d<-read.table("../Data/SparrowSize.txt", header=TRUE) 	
str(d) 	
names(d)
head(d)
length(d$Tarsus)

mean(d$Tarsus)
mean(d$Tarsus, na.rm=TRUE) #handle NA values
median(d$Tarsus)
median(d$Tarsus, na.rm=TRUE)
mode(d$Tarsus)

hist(d$Tarsus)

par(mfrow = c(2,2))
hist(d$Tarsus, breaks = 3, col = "grey")
hist(d$Tarsus, breaks = 10, col = "grey")
hist(d$Tarsus, breaks = 30, col = "grey")
hist(d$Tarsus, breaks = 100, col = "grey")

d2 <- subset(d, d$Tarsus!= "NA")
length(d$Tarsus)

install.packages("modeest")
require(modeest)
mlv(d$Tarsus)
mlv(d2$Tarsus)

mlv.default(x=d2$Tarsus)

sd(d2$Tarsus)

range(d$Tarsus)
range(d$Tarsus, na.rm = TRUE)

var(d$Tarsus, na.rm = TRUE)

sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) - 1) 	

sqrt(var(d2$Tarsus)) 	

zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)

var(zTarsus)

graphics.off() #shuts down all open graphics devices
hist(zTarsus)

pnorm(zTarsus)

set.seed(123) 	
znormal <- rnorm(1e+06) 	
hist(znormal, breaks = 100) 	

summary(znormal)

qnorm(c(0.025, 0.975))
pnorm(.Last.value)

par(mfrow = c(1, 2))
hist(znormal, breaks = 100)
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed") plot(density(znormal))
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black") abline(h = 0, lwd = 3, col = "blue")
text(2, 0.3, "1.96", col = "red", adj = 0)
text(-2, 0.3, "-1.96", col = "red", adj = 1)

boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")
