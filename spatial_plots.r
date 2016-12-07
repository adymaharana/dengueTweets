##Tuesday December 6th, 2016
##Code used to construct Figure 1 in the Plos Currents paper: Social media as a sentinel for disease surveillance: what does sociodemographic status have to do with it? 
##Contact Elaine Nsoesie at en22@uw.edu with questions


library("ggplot2")
library("mapproj")

source('~/Documents/Dengue-Twitter/Scripts/multiplot.r') #source: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/

jpeg("figure1.jpeg", width = 16, height = 15, units='in', res = 400)

lowcol = "aliceblue"
highcol = "blue4"

plot1 <- ggplot() + geom_polygon(data = final.sp, aes(x = long, y = lat, group = group, fill = numcases), color = "black", size = 0.25) + coord_map() +
  scale_fill_gradient(name = "Dengue Cases ", breaks = spcasebrk[2:length(spcasebrk)], labels = spcasebrk[2:length(spcasebrk)], low = lowcol, high = highcol) +
  labs(title = "S\u{E3}o Paulo")  +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=18), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=18)) + theme(plot.title = element_text(size=20)) 
      
  
plot2 <- ggplot() + geom_polygon(data = final.sp, aes(x = long, y = lat, group = group, fill = numtweets), color = "black", size = 0.25) + coord_map() +
  scale_fill_gradient(name = "Dengue Tweets ", breaks = sptwtbrk[2:length(sptwtbrk)], labels = sptwtbrk[2:length(sptwtbrk)], low = lowcol, high = highcol) +
  labs(title = "S\u{E3}o Paulo")  +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=18), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=18)) + theme(plot.title = element_text(size=20)) 
   
   

plot3 <- ggplot() + geom_polygon(data = final.mg, aes(x = long, y = lat, group = group, fill = numcases), color = "black", size = 0.25) + coord_map() + 
  scale_fill_gradient(name = "Dengue Cases ", breaks = mgcasebrk[2:length(mgcasebrk)], labels = mgcasebrk[2:length(mgcasebrk)], low = lowcol, high = highcol) +
  labs(title = "Minas Gerais")  +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=18), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=18)) + theme(plot.title = element_text(size=20))  
     
   
plot4 <- ggplot() + geom_polygon(data = final.mg, aes(x = long, y = lat, group = group, fill = numtweets), color = "black", size = 0.25) + coord_map() +
  scale_fill_gradient(name = "Dengue Tweets ", breaks = mgtwtbrk[2:length(mgtwtbrk)], labels = mgtwtbrk[2:length(mgtwtbrk)], low = lowcol, high = highcol) +
  labs(title = "Minas Gerais")  +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=18), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=18)) + theme(plot.title = element_text(size=20))    
   

plot5 <- ggplot() + geom_polygon(data = final.rj, aes(x = long, y = lat, group = group, fill = numcases), color = "black", size = 0.25) + coord_map() +
  scale_fill_gradient(name = "Dengue Cases ", breaks = rjcasebrk[2:length(rjcasebrk)], labels = rjcasebrk[2:length(rjcasebrk)], low = lowcol, high = highcol) +
  labs(title = "Rio Janeiro")  +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=18), axis.title=element_text(size=18), legend.text=element_text(size=19), legend.title=element_text(size=18)) + theme(plot.title = element_text(size=20)) 
   
      
   
plot6 <- ggplot() + geom_polygon(data = final.rj, aes(x = long, y = lat, group = group, fill = numtweets), color = "black", size = 0.25) + coord_map() +
  scale_fill_gradient(name = "Dengue Tweets ", breaks = rjtwtbrk[2:length(rjtwtbrk)], labels = rjtwtbrk[2:length(rjtwtbrk)], low = lowcol, high = highcol) +
  labs(title = "Rio Janeiro") +
 theme(axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()) + 
   theme(strip.text.y = element_text(size = 18, face = "bold")) +
   theme(strip.text.x = element_text(size = 18, face = "bold")) +
   theme(axis.text=element_text(size=19), axis.title=element_text(size=20), legend.text=element_text(size=19), legend.title=element_text(size=20)) + theme(plot.title = element_text(size=20)) 

multiplot(plot1, plot3, plot5, plot2, plot4, plot6, cols = 2)
dev.off()