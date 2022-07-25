#Identify the working directory

getwd()

#load the Beer data - use file open if unsure of location
#command below is copied from console

load("~/lachlan/ETF3500/2016/Tutorials/Beer.RData")

#load the comScore data

load("~/lachlan/ETF3500/2016/Tutorials/comScore.RData")

#Beer Dataset

library(ggplot2)

#Q1 Produce histogram of cost

ggplot(Beer,aes(x=cost))+geom_histogram()

#Save plots!!!

#Q2 Produce boxplots of alcohol by beer strength

ggplot(Beer,aes(x=light,y=alcohol))+geom_boxplot()

#Q3 Produce a frequency table of beer rating

table(Beer$rating)

#Q4 Produce a X-tab of beer rating vs strength

table(Beer$rating,Beer$light)

#comScore Dataset

#Q1 Get histograms for Sales, Duration and Page views

ggplot(comScore,aes(x=Sales))+geom_histogram()

ggplot(comScore,aes(x=Duration))+geom_histogram()

ggplot(comScore,aes(x=PageViews))+geom_histogram()

#Q2 Get summary stats for the dataset

summary(comScore)

#Q3 Get a scatterplot of duration against Page Views

ggplot(comScore,aes(x=PageViews,y=Duration))+geom_point()

#If you feel sad, try this....

ggplot(comScore,aes(x=PageViews,y=Duration))+geom_point()+geom_smooth()

#More advanced - Data Cleaning

#Q1 Use the filter function from the library dplyr to remove outliers

#Initialise dplyr

library(dplyr)

# == includes while != means exclude (or not equal)
#we want to exclude Duration = 1428 and PageViews = 1071 (look at the conditions from the lecture notes)
#we also need to create a new dataframe with a different name to comScore

comScore_noout<-filter(comScore,(Duration!=1428)&(PageViews!=1071))

#Q2 Redo the scatterplot without the outliers

ggplot(comScore_noout,aes(x=PageViews,y=Duration))+geom_point()

#Q3 Change the dots according to sale

ggplot(comScore_noout,aes(x=PageViews,y=Duration,col=Sales))+geom_point()

