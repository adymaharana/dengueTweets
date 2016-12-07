##Tuesday December 6th, 2016
##Code used to construct Figure 3 in the Plos Currents paper: Social media as a sentinel for disease surveillance: what does sociodemographic status have to do with it? 
##Contact Elaine Nsoesie at en22@uw.edu with questions


rm(list = ls())

##############################################################################################
#Sao Paulo
##############################################################################################

#Tweets
datt1 <- read.table("SaoPaulo2013_County_Weekly.txt", header=TRUE, sep=",")
datt2 <- read.table("SaoPaulo2014_County_Weekly.txt", header=TRUE, sep=",")

#County: SP
newdat1 <- rbind(datt1[datt1$county == as.character(counties[11]),], 
	                datt2[datt2$county == as.character(counties[11]),])
	                

#Dengue cases
case1 <- read.table("DENGN2013_SP_County_Weekly.txt", header=TRUE, sep=",")
case2 <- read.table("DENGN2014_SP_County_Weekly.txt", header=TRUE, sep=",")

newdat2 <- rbind(case1[case1$county == 355030,][1:52,], 
	                case2[case2$county == 355030,])




###Plots in the same window
jpeg("barplots_reg.jpeg", width = 15, height = 9, units='in', res=900)

par(mfrow = c(1,3), mar=c(4,6,4,2) + 0.1)

barplot(newdat1$cases/max(newdat1$cases), col=c("khaki4"),  xlab= "Weeks (Jan 2013 - Dec 2014)", ylab="Suspected Dengue Disease Tweets (scaled by maximum)",  main="(a)", cex.main=2.5, cex.lab = 2.5, cex.axis = 2.5, font.lab=1) 

barplot(newdat2$cases/max(newdat2$cases),  col=c("brown4"), xlab= "Weeks (Jan 2013 - Dec 2014)", ylab="Confirmed Dengue Cases (scaled by maximum)", main="(b)", cex.main=2.5, cex.lab = 2.5, cex.axis = 2.5, font.lab=1) #font=2,

#linear regression output
lm.fit <- lm(newdat2$cases ~ newdat1$cases)
plot(newdat2$cases, type="l", lwd=3, col=c("brown4"), ylab="Confirmed Dengue Cases", xlab="Weeks (Jan 2013 - Dec 2014)", main="(c)", , cex.main=2.5, bty="l", xaxt="n", font.axis=1, cex.lab = 2.5, cex.axis = 2.5, font.lab=1) 
lines(fitted(lm.fit), type="l", lwd=3, col=c("khaki4"), font.axis=2, cex.lab = 2.5, cex.axis=1.5, font.lab=1)
legend("topleft", c("Dengue Cases", "Fitted Model"), col=c("brown4", "khaki4"), lwd=3,bty="n", cex=2.0) 
axis(1, at=c(1, 15, 30, 45, 60, 75, 90, 105), labels=c(1, 15, 30, 45, 8, 23, 38, 53), font.axis=2, cex.axis=1.5)

dev.off()
