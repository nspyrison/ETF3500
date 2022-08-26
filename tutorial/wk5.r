# Overview ----

# - Last week we covered Clustering
# - Quiz was Monday; how'd it go?
# - This week focusing on Multi-Dimensional Scaling (MDS) and Sammon maps

# This week ----

# 1) Introduce PDF.
# 2) Discuss the Concepts section.
# 3) Work through Application as groups (25-30 min), please ask questions & seek help.
# 4) Discuss and compare against template.


# Content ----

## Setup ----
#1. Remove the non-metric variables vitamins, shelf and mfr
library(MASS) #MASS used for data
library(tidyverse)
cereal_metric <- UScereal %>%
  select(-vitamins, -shelf, -mfr) # Note use of minus
str(cereal_metric) # Confirm non-metric removed
?cereal_metric


## Scaling needed? ----
#2. The intention is to use 8-dimensional Euclidean distance between the observations as an input to MDS.
# Should the data be scaled before computing the distance measure?
#   The data are measured in different units. Most variables are measured in grams but sodium is measured in
# micrograms, and, more importantly, calories is measured in calories. Without standardization, if calories
# were converted to kilo Joules or the other variables converted to ounces then results would change.


## Classic MDS ----
# 3. Find the 2-dimensional classical MDS solution and plot it.
dd <- cereal_metric %>%
  scale() %>% #standardise
  dist() #Compute distance

#Assign cereal names to dist object
rownames(UScereal) -> attributes(dd)$Labels


#Compute classical MDS
cmds <- cmdscale(dd, eig = T) # Set eig=T for later questions
#Store representation in data frame
df <- cmds$points %>%
  as.data.frame() %>%
  rownames_to_column(var = 'Cereal Name')

ggplot(df, aes(x=V1, y=V2, label=`Cereal Name`)) +
  geom_text(size=4) + geom_point()



## Discuss the plot ----
# 4. Does the plot indicate that one or more cereal brands could be outliers?
#   All Bran, All Bran with extra Fibre, 100% Bran, Grape Nuts and Great Grains Pecan are all potentially
# outliers. On closer inspection the first three of these are very high in fibre and protein. Also Grape Nuts and
# Grape Grain pecan are high in calories and carbohydrates.

## Goodness of fit ----
# 5. What are the goodness of fit measures for this solution? Are they same or different?
cmds$GOF
## [1] 0.6982353 0.6982353
# The GOF measures are the same


## Negative eigen values? ----
# 6. Are there (non-negligible) negative eigenvalues? Why or why not?
#Check the minimum eigenvalue
min(cmds$eig)
## [1] -5.859887e-14
# This looks negative but the e-14 is the reciprocal of 1 with 14
#trailing zeros. This number is indistinguishable from zero. So
#all eigenvalues are non-negative. This is to be expected since
#input distance is Euclidean.

## Changing distance? -----
# 7. How would you expect your answer to questions 5 and 6 to change if Manhattan distances are used.
# For Manhattan distances some eigenvalues can be negative and in this case the GoF measures may differ.


## Color on Manufacturer ----
# 8. Re do the plot but with different coloured labels for each manufacturer. What conclusions do you draw
# from this analysis?
df <- add_column(df, Manufacturer=UScereal$mfr)
ggplot(df, aes(x=V1,y=V2,col=Manufacturer,label=`Cereal Name`)) +
  geom_text(size=4) + facet_wrap(~Manufacturer)
table(UScereal$mfr)

#The two big manufacturers are General Mills and Kelloggs. Kelloggs
#brands are a bit more spread out (this is easier to see if we
#simply use points rather than the cereal names). General Mills may
#have too many similar brands competing with one another. General
#Mills may benefit from diversifying into a product similar to
#all-Bran or 100% bran. There are obvious limitations to this
#analysis for example the bran market may be too small to be
#profitable.


## Sammon mapping -----
# 9. Re-do the analysis using the Sammon mapping. Do your conclusions change?
smds <- sammon(dd)
#For Sammon the coordinates are in points and are in matrix form
#Using [,1] and [,2] allows us to use the first and second columns
#respectively.
df <- add_column(df, Sammon1=smds$points[,1],
                 Sammon2=smds$points[,2])
ggplot(df, aes(x=Sammon1,y=Sammon2,col=Manufacturer,label=`Cereal Name`)) +
  geom_text(size=4) + facet_wrap(~Manufacturer)



## How does Manhattan dist change the results? ----
dd2 <- cereal_metric %>%
  scale() %>% #standardise
  dist(method="manhattan") #Compute distance

#Compute classical MDS
cmds2 <- cmdscale(dd2, eig = T) # Set eig=T for later questions

cmds2$GOF ## differs!
min(cmds2$eig) ## Negative values!

#Store representation in data frame
df2 <- cmds2$points %>%
  as.data.frame() %>%
  rownames_to_column(var = 'Cereal Name') %>%
  add_column(Manufacturer = UScereal$mfr)

ggplot(df2, aes(x=V1, y=V2, col= Manufacturer, label=`Cereal Name`)) +
  geom_text(size=4) + geom_point() + facet_wrap(~Manufacturer)
