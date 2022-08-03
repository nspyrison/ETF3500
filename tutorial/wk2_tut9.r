## Setup -----
library(dplyr)
library(ggplot2)
Beer <- readRDS("./data/Beer.rds")
comScore <- readRDS("./data/comScroe.rds")

dim(Beer)
dim(comScore)


## Beer -----
#Without using the qplot function, produce a histogram of the cost per 12 fl. oz. variable.
Beer %>% ggplot(aes(x=cost, fill=light)) +
  geom_histogram()
# Observations and implications?


#Without using the qplot function, produce boxplots of alcohol content. On the same plot there should
#be a separate boxplot for light beers and a separate boxplot for nonlight beers.
Beer %>% ggplot(aes(y=alcohol, x=light, fill=light)) +
  geom_boxplot()
# Observations and implications?

# Produce a frequency table of beer rating
table(Beer$rating)
#Produce a cross tab of beer rating against light/nonlight
table(Beer$rating, Beer$light)
# Observations and implications?

## dplyr/tidyverse route:
Beer %>% count(rating)
Beer %>% count(rating, light)


## comScore -----
# Without using the qplot function, produce histograms of
# • Sales
# • Duration
# • Page Views

comScore %>% ggplot(aes(x=Sales)) + geom_histogram()
comScore %>% filter(Sales <100) %>%
  ggplot(aes(x=Sales)) + geom_histogram()

comScore %>% ggplot(aes(x=Duration)) + geom_histogram()
comScore %>% ggplot(aes(x=PageViews)) + geom_histogram()
# Observations and implications?


# 2. Produce summary statistics for the comScore data
summary(comScore)

# 3. Without using the qplot function, produce a scatter plot of duration against page views
comScore %>% ggplot(aes(x=Duration, y=PageViews)) + geom_point()


## More Advanced -----
#1. Create a new data frame that removes the two outliers using the filter function in dplyr.
comScore2 <- comScore %>% filter(Duration < 1000, PageViews < 600)

#2. Do the scatterplot again with the outliers removed.
comScore2 %>% ggplot(aes(x=Duration, y=PageViews)) + geom_point()

#3. Do the scatterplot where the points have a different colour if the observation corresponds to a buy and
#a different colour if it corresponds to no buy
comScore2 %>% ggplot(aes(x=Duration, y=PageViews, color=Buy)) + geom_point()
# Observations and implications?


## Bonus -----
# Occlusion issue
comScore2 %>% ggplot(aes(x=Duration, y=PageViews,)) +
  geom_point(aes(color=Buy)) +
  geom_density2d(color="black")

# looking at many histograms can be tedious is there another way?
GGally::ggpairs(comScore2, aes(color=Buy))

# Numeric summary could be better
skimr::skim(Beer)
