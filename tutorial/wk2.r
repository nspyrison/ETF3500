# Overview ----

# - Last week we covered moodle, and course content.
# - Initialized an R project with ./data folder.
# - Questions/topics from last time? -- GROUP ASSIGNMENT
# - Lecture: covered intro to R, naming, workspace, packages, etc.
# - Tutorial: start with same Beer data, introducing new R content 

# This week ----

# 1) Introduce PDF.
# 2) 20-30 min to work through it and regroup to discuss.
# 3) Discuss.
# 4) Compare against template.


# Content ----

## Setup ----
library(dplyr)
library(ggplot2)
## Assuming you have R project with ./data/
Beer     <- readRDS('./data/Beer.rds')
comScore <- readRDS('./data/comScore.rds')


## Beer Data -----
#1. Produce a histogram of the cost per 12 fl. oz. variable.
ggplot(Beer, aes(x=cost)) +
  geom_histogram() +
  labs(x="Cost per fluid oz.", y="Count of Beers")
# Observations & implications?

#2. Produce boxplots of alcohol content by Beer type[light/heavy].
ggplot(Beer, aes(x=light, y=alcohol, fill=light)) +
  geom_boxplot()
# Observations & implications?

#3. Produce a frequency table of beer rating
## Base
table(Beer$rating)
## dplyr
Beer %>% count(rating)

#4. Produce a cross tab of beer rating against light/nonlight
## Base (table format/ pivoted wider)
table(Beer$rating, Beer$light)
## dplyr (tidy format)
Beer %>% count(rating, light)
# Observations & implications?


## comScore Data -----
# An interesting marketing question is whether browsing behaviour
# (duration and page views) are associated with purchase behaviour (buy and sales).

# 1. Without using the qplot function, produce histograms of
# • Sales
ggplot(comScore, aes(x=Sales)) +
  geom_histogram()
## really is quite close to 0
comScore %>% filter(Sales < 100) %>%
  ggplot(aes(x=Sales)) +
  geom_histogram()
# • Duration
ggplot(comScore, aes(x=Duration)) +
  geom_histogram()
# • Page Views
ggplot(comScore, aes(x=PageViews)) +
  geom_histogram()

# 2. Produce summary statistics for the comScore data
summary(comScore)

# 3. Without using the qplot function, produce a scatter plot of duration against page views
ggplot(comScore, aes(x=Duration,y=PageViews)) +
  geom_point()

## More Advanced -----
# 1. Create a new data frame that removes the two outliers using the filter function in dplyr.
comScore_no <- filter(comScore,
                      PageViews < 900,
                      Duration < 1000)

# 2. Do the scatterplot again with the outliers removed.
ggplot(comScore_no, aes(x=Duration,y=PageViews)) +
  geom_point()

# 3. Do the scatterplot where the points have a different colour if the observation corresponds to a buy and
# a different colour if it corresponds to no buy.
ggplot(comScore_no, aes(x=Duration, y=PageViews, color=Buy)) +
  geom_point()

## Bonus: Point occlusion & geom_density2d
ggplot(comScore_no, aes(x=Duration, y=PageViews)) +
  geom_point(aes(color=Buy)) +
  geom_density2d(color="black")
# Observations & implications?


## Bonus: other packages
skimr::skim(comScore) ## Windows 10 needs R v4.2 or higher for UTF-8 support :(.
GGally::ggpairs(comScore_no, mapping = aes(color=Buy)) ## poor results with outliers

