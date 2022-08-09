# Overview ----

# - Last week the lecture covered R naming conventions etc.
# - In the tutorial we started with beer data and then looked at comScore
# - Questions/topics from last time:
#    - GROUP ASSIGNMENT undergrad &masters? Yes (assignment 3 differs thoguh) 
# - Lecture: covered distances; numeric and binary
# - Tutorial: start with same Beer data, introducing new R content 

# This week ----

# 1) Introduce PDF.
# 2) 30 min to work through it and regroup to discuss.
# 3) Discuss.
# 4) Compare against template.


# Content ----

## Setup ----
library(tidyverse)
## Assuming you have R project with ./data/
Beer <- readRDS('./data/Beer.rds')


## 1-3 distance of numeric----
df <- data.frame(age_yr = c(20, 25), height_cm = c(155, 163))
eucl_dist <- sqrt((df[1,1]-df[2,1])^2 + (df[1,2]-df[2,2])^2)
manh_dist <- abs(df[1,1]-df[2,1]) + abs(df[1,2]-df[2,2])

## in meters
manh_dist <- abs(df[1,1]-df[2,1]) + (abs(df[1,2]-df[2,2]))/100
## Not that distance is sensitive to units, if not normalized/standardized!


## 4 & 5 distance of binary-----
set.seed(123)
a <- sample(c(0,1), size = 8, replace = T)
b <- sample(c(0,1), size = 8, replace = T)
jac_sim <- sum(a&b)/length(a) # 1 in 8
jac_dist <- 1 - jac_sim

# 6 How to define distances across numeric and categorical?

## 7 Distance between two beers ----
Beer <- readRDS('./data/Beer.rds')

PabstEL <- Beer %>%
  mutate(beer=trimws(beer)) %>% #The beers have many trailing spaces, trimws removes them
  filter(beer == c('Pabst Extra Light')) %>%
  select_if(is.numeric)
PabstEL

Augs <- Beer%>%
  mutate(beer=trimws(beer))%>%
  filter(beer == c('Augsberger'))%>%
  select_if(is.numeric)
Augs

dif<-PabstEL-Augs
dif
dif^2

sqrt(sum(dif^2)) ## unscale eclidian distance.

## 8 standardise the data first ----

## Full sample means
means <- Beer %>%
  select_if(is.numeric) %>%
  summarise_all(mean)
means

## Full sample sds
sds <- Beer %>%
  select_if(is.numeric) %>%
  summarise_all(sd)
sds

## stdized 2 beers
PabstEL_std <- (PabstEL-means)/sds
Augs_std <- (Augs-means)/sds
dif <- PabstEL_std - Augs_std
  
sqrt(sum(dif^2))


## Alternatively
Beer%>%
  select_if(is.numeric)%>%
  scale%>%
  as_tibble%>%
  add_column(beer = as.character(Beer$beer))%>%
  mutate(beer=trimws(beer))%>%
  filter(beer == 'Augsberger' | beer == 'Pabst Extra Light')%>%
  select_if(is.numeric)%>%
  dist
