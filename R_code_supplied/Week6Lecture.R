#Clear Workspace
rm(list=ls())

library(magrittr) #Packages used in this script
library(dplyr) #Packages used in this script
library(ggplot2)#Packages used in this script

#Load Data.  This is the full data but you will
#get similar results using BostonHousing_sub
load('./BostonHousing.RData')
#Estimate factor model
fa2<-factanal(BostonHousing,
              factors = 2, #2 factors
              rotation = "none", #No rotation
              scores="none") #No Scores

#Plot factors
plot(loadings(fa2))
plot(loadings(fa2),col="white") #If you do not want the circles make them white

#Add text
text(loadings(fa2),colnames(BostonHousing))

#You can do exactly the same thing with Pipes
fa2%>%loadings%>%plot
#Add text (Note the output from loadings gets 
#"piped" through to the .)
fa2%>%loadings%>%text(.,colnames(BostonHousing))

##Varimax
fa2v<-factanal(BostonHousing,
               factors = 2,
               rotation = "varimax", #Varimax rotation
               scores="none")

#Plot varimax rotation using pipes
fa2v%>%loadings%>%plot
fa2v%>%loadings%>%text(.,colnames(BostonHousing))

#Promax rotation
fa2p<-factanal(BostonHousing,
               factors = 2, #Two factors
               rotation = "promax", #promax rotation
               scores="none") #no scores

#Get plot
fa2p%>%loadings%>%plot
fa2p%>%loadings%>%text(.,colnames(BostonHousing))

#Promax rotation with factor scores
fa2pb<-factanal(BostonHousing,
               factors = 2,
               rotation = "promax",
               scores="Bartlett") #Bartlett's Method


##A more complicated function to 
#get the plots in my lecture notes
#It uses GGPlot.  This is not compulsory learning
#but for those of you with some background in 
#R you may find this useful

ggloadings<-function(fao){
  #The input to this function is the output from factanal
    fao%>% #a factanal object
    loadings%>% #extract loadings from fao
    unclass%>% #It is difficult to apply functions to a loadings "class" this makes loadings like any other matrix 
    as.data.frame%>% #This converts the loadings to a dataframe which is what ggplot uses
    add_rownames%>% #The rownames become a variable
    ggplot(.,aes(x=Factor1,y=Factor2,label=rowname))+ #Plot Factor 1 and Factor 2
    geom_text()+ #Adds text (i.e the variable names)
    theme_classic()+ #White background
    geom_vline(xintercept = 0 ,colour = "red")+ #Red x axis line
    geom_hline(yintercept = 0 ,colour = "red")-> #Red y axis line
    g #
  return(g) #Output of function
}

#These use my function to do plots.  They will 
#not work without the predceeding code 
ggloadings(fa2)
ggloadings(fa2v)
ggloadings(fa2p)
