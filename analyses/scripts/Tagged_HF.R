## 09 October 2017 - Cat
# Duration of Vegetative Risk: field data
# Aim: To track which species to include in experiment

# Clear workspace
rm(list=ls()) # remove everything currently held in the R memory
options(stringsAsFactors=FALSE)
graphics.off()

# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)

# Set Working directory
setwd("~/Documents/git/fieldfreezing/analyses")
d<-read.csv("input/Exp_taggedHF.csv", header=TRUE)
g<-read.csv("input/gpspoints.csv", header=TRUE)

d$species<-substr(d$ind, 3,8)
d$number<-substr(d$ind, 12, 13)
d$stage<-substr(d$ind, 0,1)
d$sp_stage<-substr(d$ind, 0,8)

count<-as.data.frame(table(d$sp_stage))
count<-count%>%
  rename(ind=Var1)%>%
  rename(number=Freq)
d<-d[!duplicated(d$ind), ]
d<-dplyr::select(d, -long, -number, -stage, -sp_stage, -lat)

### Merge gps coords
# clean gps .csv first...
g$stage<-substr(g$name, 0, 1)
g$species<-substr(g$name, 6, 11)
g$species<-ifelse(g$species=="COROVA", "CAROVA", g$species)
g$code<-substr(g$name, 13, 15)
g$ind<-paste(g$stage, g$sp, g$code, sep="_")
gx<-dplyr::select(g, ind, lat, lon, species)



df<-full_join(gx, d)

removed<-c("QUERUB", "PRUPEN", "POPGRA", "FRAAME", "BETPAP", "ACERUB", "ILEMUC", "BETALL")
d_field<-df%>%filter(!species %in% removed)

#write.csv(d_field, file="~/Documents/git/fieldfreezing/analyses/output/exp_tagged_latlong.csv", row.names=FALSE)

## Planning Hobos
## Furthest points from each other are ~0.3 mi (485m)


