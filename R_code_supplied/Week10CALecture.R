rm(list=ls())
library(ca)
load('../Data/coats.RData') #Load coats data

tab_coats<-table(coats) #Cross tab for coats
print(tab_coats)

cst<-chisq.test(tab_coats) #Carries out chi square test

cst$statistic #Test Statistics
cst$p.value  #P Value
cst$observed #Observed Frequencies
cst$expected #Expected Frequencies

load('../Data/breakfast.RData') #Load Breakfast data

ca_output<-ca(tab_breakfast) #Output from CA
plot(ca_output) #Plot

summary(ca_output,rows=FALSE,columns = FALSE) #Summary
