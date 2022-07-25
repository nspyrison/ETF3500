#Clear Worskspace
rm(list=ls())

# Load the State Dataset
data(state)

#This actually loads many different variables.  We are interested
#in state.x77

#We only want to consider SocioEconomic Variables

StateSE<-state.x77[,c("Income","Illiteracy","Life Exp",
                      "Murder","HS Grad")]
StateSE<-state.x77[,2:6]
#Carry out Principal Components
StateSE_PC<-prcomp(StateSE,scale. = TRUE)
#Summary
summary(StateSE_PC)
#Biplot
biplot(StateSE_PC)
#Biplot with state labels
biplot(StateSE_PC,xlabs=state.abb)
#Scree Plot
screeplot(StateSE_PC)
screeplot(StateSE_PC,type="l")


#To replicate my results exactly


#First I create a vector of states I want to keep.
#These are all the states except Alaska and Hawaii
KeepStates<-((state.name!="Alaska")&(state.name!="Hawaii"))

#Now only select the states and variables we want
StateCSE<-state.x77[KeepStates,
                    c("Income","Illiteracy","Life Exp",
                      "Murder","HS Grad")]
#The rest of the code is similar to previously

StateCSE_PC<-prcomp(StateCSE,scale. = TRUE)
summary(StateCSE_PC)
biplot(StateCSE_PC)
biplot(StateCSE_PC,xlabs=state.abb[KeepStates])
screeplot(StateCSE_PC,type="l")

