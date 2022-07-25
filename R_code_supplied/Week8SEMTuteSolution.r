###Lecture solution.  
rm(list=ls())
library(lavaan)
library(xtable)
library(semPlot)
library(dplyr)
HSmodel <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9
              visual~~textual
              visual~~speed
              textual~~speed
'

HSfit <- cfa(HSmodel, data=HolzingerSwineford1939)
summary(HSfit, fit.measures=TRUE)
semPaths(HSmodel,style = 'lisrel',nCharNodes = 7)

###Tutorial solution.  Only one line changes but work through 
#the whole example
rm(list=ls())
library(lavaan)
library(xtable)
library(semPlot)
library(dplyr)
HSmodel <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9
              visual~~textual
              visual~~speed
              textual~~speed
              x7~~x8   #This is the only line that changes
'

HSfit <- cfa(HSmodel, data=HolzingerSwineford1939)
summary(HSfit, fit.measures=TRUE)
semPaths(HSmodel,style = 'lisrel',nCharNodes = 7)
