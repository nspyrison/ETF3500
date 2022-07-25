# Ideally in an R project (organization and work directories)

#install.packages("ggplot2") ## Download and install once per machine/version
library(ggplot2) ## once per session

## Sensitive to work directory, project preferred otherwise Session > Set WD.
Beer <- readRDS('./data/Beer.rds')

## EDA, broad functions missing
summary(Beer)



qplot(Beer$price)
table(Beer$rating, Beer$origin)
