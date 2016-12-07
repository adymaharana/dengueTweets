#Set Working Directory
setwd("~/Documents/dengueTweets")

# For Windows - in each session
# Adjust the path to match your installation of Ghostscript
Sys.setenv(R_GSCMD = "C:/Program Files/gs/gs9.19/bin/gswin64c.exe")

#Install required packages if not available
# install.packages("tmap",dependencies = TRUE)
# install.packages("leaflet",dependencies = TRUE)
# install.packages("stringdist",dependencies = TRUE)
# install.packages("extrafont", dependencies = TRUE)


#Import libraries
library("tmap")
library("leaflet")
library("stringdist")
library("extrafont")
# font_import()
# loadfonts(device = "win")

#Shape File names for 3 states of Brazil
mgshapefile <- "MinasGerais/31MUE250GC_SIR.shp"
rjshapefile <- "RioJaneiro/33MUE250GC_SIR.shp"
spshapefile <- "SaoPaulo/35MUE250GC_SIR.shp"

#Read shape files
mggeo <- read_shape(file = mgshapefile)
rjgeo <- read_shape(file = rjshapefile)
spgeo <- read_shape(file = spshapefile)

#Try Thematic Map Commands to double check
# qtm(mggeo)
# str(mggeo@data)
# newgeo <- mggeo[mggeo@data$CD_GEOCMU=="3100104",]
# qtm(newgeo)

#List of county names
mginfo <- mggeo@data$NM_MUNICIP
rjinfo <- rjgeo@data$NM_MUNICIP
spinfo <- spgeo@data$NM_MUNICIP

#Filenames
fname1 <- "brazil_sickness_tweets_NB_all.csv"

#Read Data
data <- read.csv(fname1)
temp <- data[,c("Time.Stamp","State","County")]

#Year
year = "2013"

# Count the number of tweets available for each county in the 3 states with data from the .csv file
mg = c()
rj = c()
sp = c()
rows = nrow(temp)
tempmat = as.matrix(temp) # Convert data frame to matrix for easier access to elements
for (i in 1:rows)
{
  yeardist2dat = stringdist(substr(tempmat[i],1,4),year)
  # if ((stringdist(substr(tempmat[i],1,4),"2013") != 0) & (stringdist(substr(tempmat[i],1,4),"2014")!= 0))
  if(yeardist2dat != 0)
  {
    next
  }
  state = tempmat[i,2]
  if (stringdist(state,"MG")==0)
  {
    county = toupper(tempmat[i,3])
    if (county %in% names(mg))
    {
      mg[county] = mg[county] + 1 # Increment the count of tweets 
    }
    else
    {
      mg[county] = 1 # Create an entry for the county if not already present
    }
  }
  if (stringdist(state,"RJ")==0)
  {
    county = toupper(tempmat[i,3])
    if (county %in% names(rj))
    {
      rj[county] = rj[county] + 1 # Increment the count of tweets
    }
    else
    {
      rj[county] = 1 # Create an entry for the county if not already present
    }
  }
  if (stringdist(state,"SP")==0)
  {
    county = toupper(tempmat[i,3])
    if (county %in% names(sp))
    {
      sp[county] = sp[county] + 1 # Increment the count of tweets
    }
    else
    {
      sp[county] = 1 # Create an entry for the county if not aleady present
    }
  }
}
print("Counting Tweets - DOne")

# Match File
matchfname = "Mapping Data/Municipality_code.txt"
data <- read.csv(matchfname)
match = as.matrix(data)
matchvec = c()
for (i in 1:length(match))
{
  matchvec[substr(match[i],1,6)] = substr(match[i],8,nchar(match[i]))
}

# Minas Gerais

#Filenames
mgfname13 <- "Mapping Data/DENGN2013_MG_County_Monthly.txt"
mgfname14 <- "Mapping Data/DENGN2014_MG_County_Monthly.txt"

# County names in shape file and tweet files are not the same. String similarity is used to
# map the names from one file to another and create unique keys for integration of 2 vectors
len = length(mginfo)
numtweets = c(1:len)*0 # Initialize with zero entries
numcases = c(1:len)*0
county <- as.character(mginfo)
mcode <- c(1:len)*0
mgdata <- data.frame(county, numtweets, numcases, mcode)
len = length(mg)
for (i in 1:len)
{
  county_temp = names(mg)[i]
  if(stringdist(county_temp,"BH")==0)
  {
    county_temp = "BELO HORIZONTE"
  }
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  if(stringdist(county_temp,"BELO HORIZONTE")==0)
  {
    county_temp = "BH"
  }
  mgdata[ind,2] = mg[county_temp]
  print(paste(county_temp, "=", county[ind], sep = " "))
}
# mggeo@data$NM_MUNICIP <- as.character(mggeo@data$NM_MUNICIP) # Use if data structure of county names is plain text
print("MG-1")


#Read Data

#2013
data <- read.csv(mgfname13)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  mgdata[ind,3] = mgdata[ind,3] + strtoi(trimws(dmat[i,2]))
  mgdata[ind,4] = as.numeric(code_temp)
  # print(paste(code_temp, "=", county_temp, "=", county[ind], sep = " "))# Checking
}
print("MG-2")


#2014
data <- read.csv(mgfname14)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  mgdata[ind,3] = mgdata[ind,3] + strtoi(trimws(dmat[i,2]))
  mgdata[ind,4] = as.numeric(code_temp)
  # print(paste(county_temp, "=", county[ind], sep = " "))# Checking
}
print("MG-3")


mggeo <- mggeo[order(mggeo@data$NM_MUNICIP),]
mgdata <- mgdata[order(mgdata$county),]
bval = identical(mggeo@data$NM_MUNICIP,mgdata$county) # Check f
mgmap <- append_data(mggeo, mgdata, key.shp = "NM_MUNICIP", key.data = "county")

casemax = max(mgdata[,3])
twtmax = max(mgdata[,2])
brkvec = c(0.05, 0.1, 0.15, 0.25, 0.5, 0.75, 1.05)
casebrk = round(brkvec*casemax)
casebrk = c(-Inf, 1, casebrk, Inf)
twtbrk = round(brkvec*twtmax)
twtbrk = c(-Inf, 1, twtbrk, Inf)
# qtm(mgmap, fill = c("numtweets","numcases"), fill.title = c("Number of Tweets","Number of Cases"), fill.style ="fixed", fill.breaks = c(-Inf, 1,10,50,100,150,200,250,300, Inf), title = "Minas Gerais")
# tm_shape(mgmap) + tm_fill(c("numcases","numtweets"), title = c("Number of cases","Number of tweets"), style = "fixed", breaks = c(-Inf, 1, 10, 50, 100, 150, 200, 250, 300, Inf)) + tm_borders(alpha = 1, lwd = 0.2)
# tm_shape(mgmap) + tm_fill(c("numcases"), title = c("Number of cases"), style = "fixed", breaks = c(-Inf, 1, 1000, 10000, 50000, 100000, 150000, 200000, Inf)) + tm_borders(alpha = 1, lwd = 0.2)
# tm_shape(mgmap) + tm_fill(c("numtweets"), title = c("Number of tweets"), style = "fixed", breaks = c(-Inf, 1, 10, 50, 100, 150, 200, 250, 300, Inf)) + tm_borders(alpha = 1, lwd = 0.2)
current_style <- tmap_style("white")
# bitmap("MinasGerais_cases_scaled_2013_14.tiff", height = 12, width = 17, 
#        units = 'cm', type="tiff24nc", res=300, family = "Arial Black")
# tiff("MinasGerais_cases_scaled_2014.tiff", height = 3.4, width = 4, 
#        units = 'in', res=300, family = "Arial")
# par(mar = c(1,1,1,1))
# tm_shape(mgmap) + tm_fill(col = "numcases", title = c("Case Count 2014"), style = "fixed", breaks = casebrk) + tm_borders(alpha = 1, lwd = 0.1) + tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","top"),bg.color = "white", bg.alpha = .2)
# dev.off()
tiff("MinasGerais_tweets_scaled_2013_14.tiff", height = 3.4, width = 4, 
     units = 'in', res=300, family = "Arial")
par(mar = c(1,1,1,1))
tm_shape(mgmap) + tm_fill(c("numtweets"), title = c("Tweet Count 2013-14"), style = "fixed", breaks = twtbrk) + tm_borders(alpha = 1, lwd = 0.1)+ tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","top"),bg.color = "white", bg.alpha = .2)
dev.off()



# Rio Janeiro

#Filenames
rjfname13 <- "Mapping Data/DENGN2013_RJ_County_Monthly.txt"
rjfname14 <- "Mapping Data/DENGN2014_RJ_County_Monthly.txt"

# County names in shape file and tweet files are not the same. String similarity is used to
# map the names from one file to another and create unique keys for integration of 2 vectors
len = length(rjinfo)
numtweets = c(1:len)*0 # Initialize with zero entries
numcases = c(1:len)*0
mcode = c(1:len)*0
county <- as.character(rjinfo)
rjdata <- data.frame(county, numtweets, numcases, mcode)
len = length(rj)
for (i in 1:len)
{
  county_temp = names(rj)[i]
  if ((abs(stringdist(county_temp,"ILHA DE PAQUET"))<=3)|(abs(stringdist(county_temp,"ILHA DO FUNDO"))<=3))
  {
    next
  }
  distarray = stringdist(county_temp,county)
  ind = which.min(distarray)
  rjdata[ind,2] = rj[county_temp]
  print(paste(county_temp, "=", county[ind], rjdata[ind,2], rj[county_temp], sep = " "))
}
# rjgeo@data$NM_MUNICIP <- as.character(rjgeo@data$NM_MUNICIP)
print("RJ-1")


#2013
#Read Data
data <- read.csv(rjfname13)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  rjdata[ind,3] = rjdata[ind,3] + strtoi(trimws(dmat[i,2]))
  rjdata[ind,4] = as.numeric(code_temp)
  # print(paste(county_temp, "=", county[ind], sep = " "))# Checking
}
print("RJ-2")


#2014
data <- read.csv(rjfname14)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  rjdata[ind,3] = rjdata[ind,3] + strtoi(trimws(dmat[i,2]))
  rjdata[ind,4] = code_temp
  # print(paste(county_temp, "=", county[ind], sep = " "))# Checking
}
print("RJ-3")


rjgeo <- rjgeo[order(rjgeo@data$NM_MUNICIP),]
rjdata <- rjdata[order(rjdata$county),]
bval = identical(rjgeo@data$NM_MUNICIP,rjdata$county)
rjmap <- append_data(rjgeo, rjdata, key.shp = "NM_MUNICIP", key.data = "county")

casemax = max(rjdata[,3])
twtmax = max(rjdata[,2])
brkvec = c(0.05, 0.1, 0.15, 0.25, 0.5, 0.75, 1.05)
casebrk = round(brkvec*casemax)
casebrk = c(-Inf, 1, casebrk, Inf)
twtbrk = round(brkvec*twtmax)
twtbrk = c(-Inf, 1, twtbrk, Inf)
# tm_shape(rjmap) + tm_fill(c("numcases","numtweets"), title = c("Number of cases","Number of tweets"), style = "fixed", breaks = c(-Inf, 1, 10, 50, 100, 150, 200, 250, 300, Inf)) + tm_borders(alpha = 1, lwd = 0.2)
# tiff("RioJaneiro_cases_scaled_2014.tiff", height = 3.4, width = 4, 
#      units = 'in', res=300, family = "Arial")
# par(mar = c(1,1,1,1))
# tm_shape(rjmap) + tm_fill(col = "numcases", title = c("Case Count 2014"), style = "fixed", breaks = casebrk) + tm_borders(alpha = 1, lwd = 0.1) + tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","top"),bg.color = "white", bg.alpha = .2)
# dev.off()
tiff("RioJaneiro_tweets_scaled_2013_14.tiff", height = 3.4, width = 4, 
     units = 'in', res=300, family = "Arial")
par(mar = c(1,1,1,1))
tm_shape(rjmap) + tm_fill(c("numtweets"), title = c("Tweet Count 2013-14"), style = "fixed", breaks = twtbrk) + tm_borders(alpha = 1, lwd = 0.1)+ tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","top"),bg.color = "white", bg.alpha = .2)
dev.off()

#Sao Paulo

#Filenames
spfname13 <- "Mapping Data/DENGN2013_SP_County_Monthly.txt"
spfname14 <- "Mapping Data/DENGN2014_SP_County_Monthly.txt"

# County names in shape file and tweet files are not the same. String similarity is used to
# map the names from one file to another and create unique keys for integration of 2 vectors
len = length(spinfo)
numtweets = c(1:len)*0 # Initialize with zero entries
numcases = c(1:len)*0
mcode = c(1:len)*0
county <- as.character(spinfo)
spdata <- data.frame(county, numtweets, numcases, mcode)
len = length(sp)
for (i in 1:len)
{
  county_temp = names(sp)[i]
  if(stringdist(county_temp, "SP")==0)
  {
    county_temp = "SAO PAULO"
  }
  distarray = stringdist(county_temp,county)
  ind = which.min(distarray)
  if(stringdist(county_temp,"SAO PAULO")==0)
  {
    county_temp = "SP"
  }
  spdata[ind,2] = sp[county_temp]
  print(paste(county_temp, "=", county[ind], spdata[ind,2], sp[county_temp], sep = " "))
}
# spgeo@data$NM_MUNICIP <- as.character(spgeo@data$NM_MUNICIP)
print("SP-1")


#2013
#Read Data
data <- read.csv(spfname13)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  spdata[ind,3] = spdata[ind,3] + strtoi(trimws(dmat[i,2]))
  spdata[ind,4] = as.numeric(code_temp)
  # print(paste(county_temp, "=", county[ind], sep = " "))# Checking
}
print("SP-2")


#2014
data <- read.csv(spfname14)
dmat = as.matrix(data)
# dmat[,3] = toupper(dmat[,3])
len = nrow(dmat)
for (i in 1:len)
{
  county_temp = ""
  code_temp = dmat[i,3]
  county_temp = toupper(matchvec[as.character(code_temp)])
  distarray = stringdist(county_temp,county) # Compute the edit distance for all entries in shape file
  ind = which.min(distarray) # Find the minimum and map the tweet count to the same
  spdata[ind,3] = spdata[ind,3] + strtoi(trimws(dmat[i,2]))
  spdata[ind,4] = as.numeric(code_temp)
  # print(paste(county_temp, "=", county[ind], sep = " "))# Checking
}
print("SP-3")


spgeo <- spgeo[order(spgeo@data$NM_MUNICIP),]
spdata <- spdata[order(spdata$county),]
bval = identical(spgeo@data$NM_MUNICIP,spdata$county)
spmap <- append_data(spgeo, spdata, key.shp = "NM_MUNICIP", key.data = "county")


casemax = max(spdata[,3])
twtmax = max(spdata[,2])
brkvec = c(0.05, 0.1, 0.15, 0.25, 0.5, 0.75, 1.05)
casebrk = round(brkvec*casemax)
casebrk = c(-Inf, 1, casebrk, Inf)
twtbrk = round(brkvec*twtmax)
twtbrk = c(-Inf, 1, twtbrk, Inf)
# tm_shape(spmap) + tm_fill(c("numcases","numtweets"), title = c("Number of cases","Number of tweets"), style = "fixed", breaks = c(-Inf, 1, 10, 50, 100, 150, 200, 250, 300, Inf)) + tm_borders(alpha = 1, lwd = 0.2)
# tiff("SaoPaulo_cases_scaled_2014.tiff", height = 3.4, width = 4, 
#      units = 'in', res=300, family = "Arial")
# par(mar = c(1,1,1,1))
# tm_shape(spmap) + tm_fill(col = "numcases", title = c("Case Count 2014"), style = "fixed", breaks = casebrk) + tm_borders(alpha = 1, lwd = 0.1) + tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","bottom"),bg.color = "white", bg.alpha = .2)
# dev.off()
tiff("SaoPaulo_tweets_scaled_2013.tiff", height = 3.4, width = 4, 
     units = 'in', res=300, family = "Arial")
par(mar = c(1,1,1,1))
tm_shape(spmap) + tm_fill(c("numtweets"), title = c("Tweet Count 2013"), style = "fixed", breaks = twtbrk) + tm_borders(alpha = 1, lwd = 0.1)+ tm_legend(text.size = 0.5, title.size = 0.7, position = c("left","bottom"),bg.color = "white", bg.alpha = .2)
dev.off()
