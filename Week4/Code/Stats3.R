#pdf5
rm(list = ls())

d<-read.table("../Data/SparrowSize.txt", header=TRUE) 
boxplot(d$Mass~d$Sex.1, col = c("red", "blue"), ylab="Body mass (g)")
t.test1 <- t.test(d$Mass~d$Sex.1)
t.test1
d1<-as.data.frame(head(d, 50))
length(d1$Mass)
t.test2 <- t.test(d1$Mass~d1$Sex) 
t.test2

d2 <- subset(d, d$Year==2001)
t.test(d$Tarsus ~d$Sex.1, na.rm = TRUE)

t.test(d2$Wing, mu = mean(d$Wing, na.rm = TRUE), na.rm = TRUE)

t.test(d2$Wing ~ d2$Sex.1, na.rm = TRUE)

t.test(d$Wing~ d$Sex.1, na.rm = TRUE)
