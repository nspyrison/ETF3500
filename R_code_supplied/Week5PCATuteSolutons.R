rm(list=ls())

#load the data

#load('BostonHousing_sub.RData')
#load("~/lachlan/ETF3500/2016/Tutorials/BostonHousing_sub.RData")

#Scale the data and perfom PCA
pca_bh<-prcomp(BostonHousing_sub,scale.=TRUE)

#Get summary statistics of the PC's
summary(pca_bh)

#Get scree plot to identify the number of PC's extracted

screeplot(pca_bh,type = "l")

#Get bi-plot

biplot(pca_bh)

