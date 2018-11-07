#pdf4
rm(list=ls()) 	
d<-read.table("../Data/SparrowSize.txt", header=TRUE) 
d1<-subset(d, d$Tarsus!="NA") 
seTarsus<-sqrt(var(d1$Tarsus)/length(d1$Tarsus))

d12001<-subset(d1, d1$Year==2001)
seTarsus2001<-sqrt(var(d12001$Tarsus)/length(d12001$Tarsus))

bill_mean = mean(d$Bill, na.rm = TRUE)
bill_var = var(d$Bill, na.rm = TRUE) 
bill_sd = sd(d$Bill, na.rm = TRUE)
mass_mean = mean(d$Mass, na.rm = TRUE)
mass_var = var(d$Mass, na.rm = TRUE)
mass_sd = sd(d$Mass, na.rm = TRUE)
wing_mean = mean(d$Wing, na.rm = TRUE)
wing_var = var(d$Wing, na.rm = TRUE) 
wing_sd = sd(d$Wing, na.rm = TRUE)

d2 = subset(d, d!= "NA")

bill_se = bill_sd/sqrt(length(d2$Bill))
mass_se = mass_sd/sqrt(length(d2$Mass))
wing_se = wing_sd/sqrt(length(d2$Wing))

d3 <- subset(d2, d2$Year==2001)

Bill_se_2001 = Bill_sd/sqrt(length(d3$Bill))
Mass_se_2001 = mass_sd/sqrt(length(d3$Mass))
Wing_se_2001 = wing_sd/sqrt(length(d3$Wing))

CI_Bill = c((Bill_mean -(Bill_se*1.96)), (Bill_mean + (Bill_se*1.96)))
CI_Mass = c((mass_mean -(Mass_se*1.96)), (mass_mean + (Mass_se*1.96)))
CI_Wing = c((wing_mean -(Wing_se*1.96)), (wing_mean + (Wing_se*1.96)))