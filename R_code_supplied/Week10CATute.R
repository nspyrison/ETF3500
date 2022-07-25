rm(list=ls()) #Clear Workspace
library(dplyr)
library(magrittr)
library(ca)

#Load Data
#load('../Data/Laundry.RData') 

load("~/lachlan/ETF3500/2016/Tutorials/Laundry.RData")

Laundry %>% select(.,OCCUPTN,MANUFCT)%>% #Select variables
  table->crosstab #create crosstab

print(crosstab) #View Crosstab

#Note that there are not many observations for
#RM Gow, Bushland or Cussons


cst<-chisq.test(crosstab) #Chi square test
#Note that we get an error message
#Our expected counts are not all > 5
#We need to be careful with our test below...


#View the test results
cst

#The p-value is small so we reject the null that
#there is no assoiation
#So occupation does effect which laundry detergent is used
#That is, manufacturer is not independent of occupation

#Correspondence analysis

cao<-ca(crosstab) 

#Summary

summary(cao) 
#We really only care about the eigenvalues here
#We can get all of the information from the plot

plot(cao) #Plot
