# Overview ----

# - Last week the lecture covered distances
# -- esp(Euclidean, Manhattan, Jaccard dist/sim)
# - Quiz next Monday, 22 Aug; covering content from weeks 1-4
# - Lecture: Clustering; hierarchical and non-hierarchical
# - Tutorial: Brief discussion on clustering and then apply to mtcars data.

# This week ----

# 1) Introduce PDF.
# 2) Discuss the Concepts section.
# 3) Work through Application as groups (25-30 min), please ask questions & seek help.
# 4) Discuss and compare against template.


# Content ----

## Setup ----
library(dplyr) #dplyr is loaded for pipe only
str(mtcars)


## Cluster using Ward's D2, Eucl dist----
#1. Cluster the data using Ward’s D2 method and Euclidean distance.
#First load required packages
d <- mtcars %>%
  scale %>% #scale data
  dist(method = 'euclidean') #compute distance matrix
hcl <- hclust(d, method = 'ward.D2')

## Dendrogram ----
#2. Produce a dendrogram for the above analysis
#Simple plot the output of the previous code
plot(hcl)

## Discuss dendrogram ----
# 3. Discuss whether the following choices for the number of clusters are suitable or not
# • One-cluster
# • Two-cluster
# • Three-cluster
# • Four-cluster

## 2-cluster solution ----
# 4. For the 2-cluster solution, store the cluster membership in a new variable.
memb_two_ward <- cutree(hcl, k = 2)

## Repeat for other methods ----
# 5. Repeat part 4 using:
# (a) Average Linkage
# (b) Centroid Method
# (c) Complete Linkage Method
memb_two_al <- hclust(d, method = 'average')%>%
  cutree(k = 2)
memb_two_cm <- hclust(d, method = 'centroid')%>%
  cutree(k = 2)
memb_two_cl <- hclust(d, method = 'complete')%>%
  cutree(k = 2)

## Rand index ----
# 6. Find the adjusted Rand Index between your answer to question 4 and 5

#Must load (don't forget to install first)
library(mclust)
adjustedRandIndex(memb_two_ward, memb_two_al)
## [1] 0.6490338
# Average linkage has a relatively high level of agreement with
#Ward's method.
adjustedRandIndex(memb_two_ward, memb_two_cm)
## [1] -0.006685769
#The centroid method gives results that are even less in agreement
#than would be the case of groups were selected at random.
adjustedRandIndex(memb_two_ward, memb_two_cl)
## [1] 1
#Complete Linkage gives exactly the same solution as Ward's method
# Overall the results are fairly robust with respect to the
#clustering algorithm used.

