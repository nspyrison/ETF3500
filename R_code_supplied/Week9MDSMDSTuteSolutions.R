library(magrittr)
library(MASS)
library(dplyr)
library(ggplot2)
data(UScereal)
##Clean data
UScereal%>%
  select(.,-vitamins,-mfr,-shelf)->UScerealnum #Only keep numeric data

#Obtain Euclidean distance 

UScerealnum%>%  
  scale%>% #Scale since data are measures in different units
  dist(.,method="euclidean") -> d

##NOTE: For Q4 just change "euclidean" to "manhattan" and rerun the entrire script

#Carry out MDS
mdsout<-cmdscale(d,k=2,eig=TRUE)

#Draw plot

UScereal%>%
  add_rownames(.,var="BrandFull")%>% #This creates a new variable which is the brandnames in full
  mutate(.,Brand=abbreviate(BrandFull,8), #This creates a new variable which is the abbreviation of brandnames
         PC1=mdsout$points[,1], #This adds the first Principal coordinate to the data frame
         PC2=mdsout$points[,2])%>% #This adds the second Principal coordinate to the data frame
  ggplot(.,aes(x=PC1,y=PC2,label=Brand,col=mfr))+geom_text()

#Check GoF
mdsout$GOF
#Check Eigenvalues
mdsout$eig

#To compare MDS and PCA we look at the first few principal coordinates and components
#First few Principal Coorodinates
head(mdsout$points[,1:2])
#First few Principal Components
UScerealnum%>%
  prcomp(.,scale=TRUE)%>%
  use_series(.,x)%>%
  extract(,1:2)%>%
  head


