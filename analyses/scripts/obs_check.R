## Started 11 April 2018 - by Cat ##
## Work on cleaning the data and figuring out if stratified design is possible...

# Clear workspace
rm(list=ls()) # remove everything currently held in the R memory
options(stringsAsFactors=FALSE)
graphics.off()

# Load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(stringr)

# Set Working directory
setwd("~/Documents/git/fieldfreezing/analyses")
d<-read.csv("input/seed_observations.csv", header=TRUE)

## Clean up a bit..

numextract <- function(string){ 
  str_extract(string, "\\-*\\d+\\.*\\d*")
}

d$X4.3.18<-numextract(d$X4.3.18)
d$X4.7.18<-numextract(d$X4.7.18)
d$X4.10.18<-numextract(d$X4.10.18)

bb<-c(7,8)
df<-d%>%dplyr::select(ind)
d[is.na(d)] <- 0
df$buds<-ifelse(d$X4.3.18 %in% bb| d$X4.7.18 %in% bb | d$X4.10.18 %in% bb, 1, 0)
df$species<-substr(df$ind, 3, 8)

df$burst<-ifelse(d$X4.3.18 == 9 | d$X4.7.18 == 9 | d$X4.10.18 == 9, 1, 0)

tb<-as.data.frame(table(df$buds, df$species))
tb<-tb%>%rename(buds=Var1)%>%rename(species=Var2)

tx<-as.data.frame(table(df$burst, df$species))
tx<-tx%>%rename(bb=Var1)%>%rename(species=Var2)

write.csv(tx, file="~/Desktop/bb_obs.csv", row.names=FALSE)
write.csv(tb, file="~/Desktop/buds_obs.csv", row.names=FALSE)
