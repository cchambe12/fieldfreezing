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

d$species<-substr(d$ind, 3,8)
d$number<-substr(d$ind, 12, 13)
d$stage<-substr(d$ind, 0,1)
d$sp_stage<-substr(d$ind, 0,8)

count<-as.data.frame(table(d$sp_stage))
count<-count%>%
  rename(ind=Var1)%>%
  rename(number=Freq)
d<-d[!duplicated(d$ind), ]
