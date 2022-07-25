#Clear Workspace (This is not necessary but is always a good idea)
rm(list=ls())

#Load MT Cars dataset.  This dataset comes with R so you do not need to download from elsewhere
data(mtcars)

#Standardise Data with scale function.  Note that I store the output into a new
#variable called "CarsScaled".  This is the input to my next step
CarsScaled<-scale(mtcars)

#Find the distances between the standardised observations using the dist function.  Again
#the output is stored into a new variable since this is used as an input to the next step
CarsDistance<-dist(CarsScaled,method = "euclidean")

#Apply clustering to the distance matrix using the hclust function with Complete Linkage Method
#The output is stored into a hclust object
CarsCluster<-hclust(CarsDistance,method = "complete")
#Plot a Dendrogram
plot(CarsCluster)

#Place red boxes around the two cluster solution of the Dendrogram
rect.hclust(CarsCluster,k=2)

#Extract Cluster Membership and store into a vector
MemberCluster<-cutree(CarsCluster,k=2)

