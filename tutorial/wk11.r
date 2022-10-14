# Overview ----

# - Last week we covered Dimension reduction (in PCA)
# - This week's focus: Correspondence Analysis

# This week ----

# 1) Discuss the Concepts section.
# 2) Work through Application as groups 15 min),
#    please ask questions & seek help.
# 3) Discuss and compare against solutions.


# Concepts ----

#1. What is the idea behind Correspondence Analysis?
## In summary PCA for nominal/categorical data.

#  When there are several categories it is difficult to identify patterns and/or associations. Correspondence
#Analysis tries to reduce the dimension to create a visualisation that can be readily analysed by a researcher. It
#is somwhat analogous to Principal Components analysis on categorical data. The aim is to find two latent
#factors that summarise most of the information in the cross tab without much loss of accuracy. Correspondence
#analysis also allows for a symmetric normalization. This allows comparison of row categories with column
#categories on the same plot. The distances between the points are on a common scale the closer the points,
#the higher the association. We cannot test if the individual associations are statistically significant. CA is an
#exploratory approach.


#2. What does inertia measure?
## strength of the relationship of variables, esentially the eigenvectors of PCA.

#  If the observed probabilities were equal to the expected probabilities, inertia would be zero. Inertia therefore,
#measures the strength of the relationship between the variables in the cross tab. One way to think about
#it is that inertia measures the amount of information contained in the crosstab. Correspondence Analysis
#approximates a large dimensional crosstab in (typically) 2 dimensions. In Correspondence Analysis we find
#a small number of factor scores that explain a large proportion of total inertia. The calculated χ
#2 value is inertia times the sample size. So inertia can also be thought of as a measure of dependence within the data.

#3. Identify the advantages and disadvantages of correspondence analysis.
# Advantages: Simple, can handle nominal data and requires no assumptions.
# Disadvantages: Difficult with 3 or more variables; can lose information; cannot look at the effect continuous
# variables may have on nonmetric variables


# Application ----

# Data: Laundry purchases

#Load package
library(dplyr)
library(ca)
#Read Data
Laundry <- readRDS('./data/Laundry.rds')
# Correspondence Analysis comparing occupation with (soap?) brand
table(Laundry$OCCUPTN, Laundry$BRAND) %>%
  ca %>%
  plot()

table(Laundry$OCCUPTN, Laundry$BRAND) %>%
  ca %>%
  summary()


# 2. Name two brands that are similar to one another.
# Surf and Omo are similar in the sense that they they have a similar profile of customer occupations.

# 3. Name a manufacturer associated with skilled occupations.
# Bushland is associated with skilled occupations.

# 4. Name an occupation associated with the manufacturer Unilever.
# Unskilled occupations are most closely associated with Unilever.

# 5. How much inertia is explained by the second dimension on its own.
# 33.3% of the inertia is explained by the second dimension (this is given in the plot and the summary table in
# R).

