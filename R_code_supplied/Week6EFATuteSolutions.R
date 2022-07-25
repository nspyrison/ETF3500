rm(list=ls())
library(dplyr)
library(magrittr)
library(ggplot2)
library(tidyr)
#load('Returns.RData')

load("~/lachlan/ETF3500/2016/Tutorials/Returns.RData")

# magritter lets us use %>% to continue commands
# We are doing PCA (with screeplot) in one line

Returns%>%prcomp(.,scale. =TRUE)%>%summary%>%screeplot(.,type = "l")

# EFA is based off the PC's
# EFA with no ratation 
fau<-factanal(Returns,factors=2,rotation="none",scores="Bartlett")

# Find the unique variances of the variables
# 1-uniquenesses = communality
#so the communality is
1-fau$uniquenesses

# Look at the factor loadings
fau$loadings

# Use orthogonal rotation (varimax)
fav<-factanal(Returns,factors=2,rotation="varimax",scores="Bartlett")

fav$loadings

# Use oblique rotations (promax)
fap<-factanal(Returns,factors=2,rotation="promax",scores="Bartlett")

fap$loadings

# look at the factor scores
#These are the fi's from the lecture notes
fap$scores

#To see the correlation of the factors use the following code
coru<-cor(fau$scores) #Correlation of unrotated factors
coru

corv<-cor(fav$scores) #Correlation of rotated factors (Varimax)
corv

corp<-cor(fap$scores) #Correlation of rotated factors (Promax)
corp

# Use simple plot from our preferred rotation method  to plot the factors
plot(loadings(fap),col="white")
text(loadings(fap),colnames(Returns))

#If you want to practice R, you could try converting the ggplot
#coding from the lecture to make the plot easier to read

#THIS NEXT BIT IS "FANCY" R

#You are not expected to know how or even understand the code
##The code below uses a lot of functions we haven't learnt yet.  
#However it does create a plot that helps us see how the second factor
# (the Asia-Pacific factor) is not as volatile during the Euro crisis

# If you want to delve more into R, feel free to analyse the code

# This is just a color pallette for colour-blind people (like me)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#The code uses magrittr, dplyr tidyr and ggplot
fap%>%
  `$`(scores)%>%## Pick out the scores from the promax rotation
  as.data.frame%>%  ## Convert to a data frame
  add_rownames()%>% ## Make the dates another variable called rowname
  mutate(.,Date=as.Date(rowname))%>% #Convert to a "Date" object (makes plot prettier)
  #gather all factor scores into a single variable (makes plotting easier)
  gather(.,key=Factor,value=Score,-Date,-rowname)%>% 
  ggplot(.,aes(x=Date,y=Score,col=Factor))+
  geom_line()+
  scale_colour_manual(values=cbbPalette) #ggplot both Factors

