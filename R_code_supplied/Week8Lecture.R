rm(list=ls())
library(lavaan)
library(semPlot)

##Holzinger Swineford example

#Model Syntax.  This sepcifies the model
HSmodel <- ' visual  =~ x1 + x2 + x3
              textual =~ x4 + x5 + x6
              speed   =~ x7 + x8 + x9
              visual~~textual
              visual~~speed
              textual~~speed
              '

#Does path diagram without any estimates
semPaths(HSmodel,style = 'lisrel',nCharNodes = 7) 

#Fits model
HSfit <- cfa(HSmodel, data=HolzingerSwineford1939)

#Produce output for interpretation
summary(HSfit, fit.measures=TRUE)

#Path diagram where thickness of line depends on standardised 
#estimate, but unstandardised estimate is provided on the edges
semPaths(HSfit,what='std',whatLabels = 'est',style = 'lisrel',nCharNodes = 7) 


##Poltical Democracy example


PDmodel <- ' 
# latent variable definitions
ind60 =~ x1 + x2 + x3
dem60 =~ y1 + y2 + y3 + y4
dem65 =~ y5 + y6 + y7 + y8

# regressions
dem60 ~ ind60
dem65 ~ ind60 + dem60

# residual correlations
y1 ~~ y5
y2 ~~ y4
y2 ~~ y6
y3 ~~ y7
y4 ~~ y8
y6 ~~ y8
'

#Does plot without estimation
semPaths(PDmodel,style = 'lisrel',nCharNodes = 7)

#Estimate model
PDfit <- sem(PDmodel, data=PoliticalDemocracy)

#Produce output for interpretation
summary(PDfit, fit.measures=TRUE)

#Does plot with edge thickness that depends on standardised estimates but 
#unstandardised estimates on edges
semPaths(PDfit,what = 'std',whatLabels = 'est' ,style = 'lisrel',nCharNodes = 7,edge.label.cex = 1)


#Same as above but with inference on indirect and total effects for mediation.
#Model syntax with parameters defined explicitly
PDmodelMed <- ' 
# latent variable definitions
ind60 =~ x1 + x2 + x3
dem60 =~ y1 + y2 + y3 + y4
dem65 =~ y5 + y6 + y7 + y8

# regressions
dem60 ~ gamma*ind60
dem65 ~ beta1*dem60 + beta2*ind60

# residual correlations
y1 ~~ y5
y2 ~~ y4
y2 ~~ y6
y3 ~~ y7
y4 ~~ y8
y6 ~~ y8
# indirect effect 
indirect := beta1*gamma
# total effect
total := beta2 + (beta1*gamma)
'

# Fit model
PDfit <- sem(PDmodelMed, data=PoliticalDemocracy)
#Produce output
summary(PDfit)