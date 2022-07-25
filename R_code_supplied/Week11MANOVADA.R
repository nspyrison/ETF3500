rm(list=ls())
library(dplyr)
library(MASS)
library(biotools)
library(MVN)
load('comScore.RData')

#Filter out outliers
comScore<-filter(comScore,((PageViews<1071)&(Duration<1428)))

y<-comScore[,"Buy"] #Pick out dependent variable
x<-comScore[,c("PageViews","Duration")] #Pick out independent variables

#Box M tests homogeneity of variance covariance data
boxM(x,y)
#Mardia's test for normality
mardiaTest(x)

#LDA
l1<-lda(x,y,CV=TRUE)  
tl1<-table(l1$class,comScore$Buy)

#QDA
q1<-qda(x,y,CV=TRUE)  
tq1<-table(q1$class,comScore$Buy)
