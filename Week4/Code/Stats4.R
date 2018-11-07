#pdf10
rm(list = ls())
d<-read.table("../Data/SparrowSize.txt", header=TRUE) 

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)
plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4,
     ylim=c(-5,38), xlim=c(0,22))

d1<-subset(d, d$Mass!="NA")
d2<-subset(d1, d1$Tarsus!="NA") 
length(d2$Tarsus)

model1<-lm(Mass~Tarsus, data=d2)
summary(model1)

hist(model1$residuals)

d2$z.Tarsus<-scale(d2$Tarsus)
model3<-lm(Mass~z.Tarsus, data=d2) 
summary(model3)

plot(d2$Mass~d2$z.Tarsus, pch=19, cex=0.4)
abline(v = 0, lty = "dotted")

d$Sex<-as.numeric(d$Sex)
par(mfrow = c(1, 2))
plot(d$Wing ~ d$Sex.1, ylab="Wing(mm)")
plot(d$Wing ~ d$Sex, xlab="Sex", xlim=c(-0.1,1.1), ylab="") abline(lm(d$Wing ~ d$Sex), lwd = 2)
text(0.15, 76, "intercept")
text(0.9, 77.5, "slope", col = "red")

d4<-subset(d, d$Wing!="NA")
m4<-lm(Wing~Sex, data=d4) t4<-t.test(d4$Wing~d4$Sex, var.equal=TRUE) summary(m4)
t4

par(mfrow=c(2,2))
plot(model3)

par(mfrow=c(2,2))
plot(m4)

#pdf13
rm(list = ls())
d<-read.table("SparrowSize.txt", header=TRUE)
d1<-subset(d, d$Wing!="NA")
summary(d1$Wing)

hist(d1$Wing)

model1<-lm(Wing~Sex.1,data=d1)
summary(model1)

boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")

anova(model1)

t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)

boxplot(d1$Wing~d1$BirdID, ylab="Wing length (mm)")

install.packages("dplyr")
require(dplyr)

tbl_df(d1)

d$Mass %>% cor.test(d$Tarsus, na.rm=TRUE)

d1 %>%
  group_by(BirdID) %>%
  summarise (count=length(BirdID))

model3<-lm(Wing~as.factor(BirdID), data=d1)
anova(model3)

boxplot(d$Mass~d$Year)

m2<-lm(d$Mass~as.factor(d$Year))
anova(m2)
summary(m2)





