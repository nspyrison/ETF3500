library(magrittr)
library(dplyr)
library(ggplot2)
rm(list=ls())
load('../Data/Beer.RData')

#Use only Beers rated fair
BeerFair<-filter(Beer,rating=="Fair")

#Obtain Distances
BeerFair%>%
  select(.,price,cost,calories,sodium,alcohol)%>% #Only use metric variables
  scale%>% #Since they are measured in different units, scale them
  dist->d #Store Euclidean distance in a variable called "d"

mdsout<-cmdscale(d,k=2,eig=TRUE) #This does MDS

#Doing the plot (with pipes)
BeerFair%>%
  data.frame(.,mdsout$points)%>%  #Put coordinates from MDS into data.frame with original data
  mutate(.,Brand=abbreviate(beer,6))%>% #Abbreviate the Beer names (better for plotting)
  ggplot(.,aes(x=X1,y=X2,label=Brand))+ #X1 and X2 are the Principal coordinates
  geom_text()

mdsout$eig
mdsout$GOF


#Doing the plot (without pipes)
BeerFairMDS<-data.frame(BeerFair,mdsout$points)  #Put coordinates from MDS into data.frame with original data
BeerFairMDSAbb<-mutate(BeerFairMDS,Brand=abbreviate(beer,6)) #Abbreviate the Beer names (better for plotting)
ggplot(BeerFairMDSAbb,aes(x=X1,y=X2,label=Brand))+ #X1 and X2 are the Principal coordinates
  geom_text() #PLot text rather than points



##In pure base R (no packages)
BeerFairMetric<-Beer[(Beer$rating=="Fair"),
                         c("price","cost","calories","sodium","alcohol")]
BeerFairMetricScale<-scale(BeerFairMetric)
d<-dist(BeerFairMetricScale)
Brand<-abbreviate(Beer$beer[Beer$rating=="Fair"],6)
mdsout<-cmdscale(d,k=2,eig=TRUE)
plot(mdsout$points,col='white')
text(mdsout$points,Brand)
