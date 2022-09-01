# Overview ----

# - Last week we covered MDS and Sammon mapping (non-linear DR)
# - This week focusing PCA (linear DR)

# This week ----

# 1) Introduce PDF, Boston housing data.
# 2) Discuss the Concepts section.
# 3) Work through Application as groups (25 min),
#    please ask questions & seek help.
# 4) Discuss and compare against template.


# Content ----

## 1. Scaling? ----
# 100 obs x 15 var (one kept out as row names); 
#• CRIM: per capita crime rate by town
#• ZN: proportion of residential land zoned for lots over 25,000 sq.ft.
#• INDUS: proportion of non-retail business acres per town
#• CHAS: Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
#• NOX: nitric oxides concentration (parts per 10 million)
#• RM: average number of rooms per dwelling
#• AGE: proportion of owner-occupied units built prior to 1940
#• DIS: weighted distances to five Boston employment centres
#• RAD: index of accessibility to radial highways
#• TAX: full-value property-tax rate per $10,000
#• PTRATIO: pupil-teacher ratio by town
#• B: 1000(Bk 0.63) 2 where Bk is the proportion of African Americans by town
#• LSTAT: % lower status of the population
#• MEDV: Median value of owner-occupied homes in $1000s

## 2. PCA ----
#First load required packages
library(tidyverse)
Boston <- readRDS('./data/Boston.rds')
pcaout <- Boston %>%
  column_to_rownames('Town') %>% #see comment below
  prcomp(scale.=TRUE)
#This sets the column Town to be the row name. There is a
#debate around whether dataframes should have rownames but the
#existing prcomp function works better when observation IDs are
#rownames rather than a separate column

## 3. cumulative var for PC1:4 ----
summary(pcaout)

## Manually
names(pcaout)
pcaout$sdev^2
sum(pcaout$sdev[1:4]^2)
100*sum(pcaout$sdev[1:4]^2)/sum(pcaout$sdev^2) ## as % of total


## 4. var of pca2 ----
sum(pcaout$sdev[2]^2)
100*sum(pcaout$sdev[2]^2)/sum(pcaout$sdev^2) ## as % of total


## 5. Kasier's Rule ----
# The “eigenvalues greater than one” rule
#Questions 4-5 can be answered using the summary function
summary(pcaout)
## 4 PCs, alternatively IDE estimation with `Rdimtools`

#Proportion of variance explained by the first four PCs together is 75.23%
#Proportion of variance explained by the second PC alone is 12.18%
#By Kaisers rule select 4 PCs (variance and standard deviation greater than 1.)



## 6. Scree plot ----
screeplot(pcaout, type = 'l')
# The elbow appears at the second PC, therefore 2 PCs should be used.
# Note that this is different to Kaiser's rule.


## 7:9. Correlation biplot ----
#Correlation biplot used to answer Q7, Q8 and Q9
biplot(pcaout, scale=0, cex = .7) ## Correlation
# 7. Name two variables that have a strong positive association with one another.
# 8. Name two variables that have a strong negative association with one another.
# 9. Name two variables that are only weakly associated with another.

## 10:11. Distance biplot ----
biplot(pcaout, cex=.7)
# 10. Name two towns that are similar to one another.
# 11. Name two towns that are different to one another.

## 12:13. Using either biplot ----
# 12. Describe the characteristics of town 354.
# 13. Name a town that has a high level of crime and a high pupil-teacher ratio.


## Extra: Tours & spinifex ----
?spinifex::ggtour
