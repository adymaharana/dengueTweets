##Tuesday December 6th, 2016
##Code used to construct Figure 2 in the Plos Currents paper: Social media as a sentinel for disease surveillance: what does sociodemographic status have to do with it? 
##Contact Elaine Nsoesie at en22@uw.edu with questions.

rm(list=ls())

library(aod)
library(ggplot2)
library(Rcpp)
library(ggplot2)

#Read in demographics data
datta <- read.csv("data_demographics.csv")


#Scale proportions to percentages
 datta$aged <- datta$aged*100  
    datta$m <- datta$m*100  #males
    datta$f <- datta$f*100  #females


source('multiplot.r') #Source: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/


jpeg("demo_vars.jpeg", width = 13, height = 8, units='in', res=900)


p1<- ggplot(datta, aes(x=lab, y=income, fill=state)) + geom_boxplot(outlier.colour="black", outlier.shape=16, outlier.size=2, notch=FALSE) + xlab("Label (Tweets = 1, No Tweets = 0)") + ylab("Per capita income") + labs(title="(a)") + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), breaks=c("mg","rj","sp"), labels=c("Minas Gerais","Rio de Janeiro","São Paulo"))  + theme(axis.text=element_text(size=20), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=20)) 

p2<- ggplot(datta, aes(x=lab, y=Uneducated_or_incomplete.elementary.cycle, fill=state)) + geom_boxplot(outlier.colour="black", outlier.shape=16, outlier.size=2, notch=FALSE) + xlab("Label (Tweets = 1, No Tweets = 0)") + ylab("Uneducated or incomplete \n elementary cycle (%)") + labs(title="(c)") + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), breaks=c("mg","rj","sp"), labels=c("Minas Gerais","Rio de Janeiro","São Paulo"))  + theme(axis.text=element_text(size=20), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=20)) 

p3 <- ggplot(datta, aes(x=lab, y=aged, fill=state)) + geom_boxplot(outlier.colour="black", outlier.shape=16, outlier.size=2, notch=FALSE) + xlab("Label (Tweets = 1, No Tweets = 0)") + ylab("60 years and above (%)") + labs(title="(b)") + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), breaks=c("mg","rj","sp"), labels=c("Minas Gerais","Rio de Janeiro","São Paulo"))  + theme(axis.text=element_text(size=20), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=20)) 


p4 <- ggplot(datta, aes(x=lab, y=m, fill=state)) + geom_boxplot(outlier.colour="black", outlier.shape=16, outlier.size=2, notch=FALSE) + xlab("Label (Tweets = 1, No Tweets = 0)") + ylab("Males (%)") + labs(title="(d)") + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"), breaks=c("mg","rj","sp"), labels=c("Minas Gerais","Rio de Janeiro","São Paulo"))  + theme(axis.text=element_text(size=20), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=20)) 


multiplot(p1, p2, p3, p4, cols=2)

dev.off()
