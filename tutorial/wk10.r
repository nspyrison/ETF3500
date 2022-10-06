# Overview ----

# - Last week we covered Matrix Geometry (theory)
# - This week's focus: Dimension reduction (in PCA)

# This week ----

# 1) Discuss the Concepts section.
# 2) Work through Application as groups 15 min),
#    please ask questions & seek help.
# 3) Discuss and compare against solutions.


# Content ----

# Data: socioeconomic data on U.S. States
## 1. Get numeric and scale the data -----
library(tidyverse)
States <- readRDS('./data/StateSE.rds')
States_Scaled <- States %>%
  select_if(is.numeric) %>%
  scale()

## 2. Carry out the singular value decomposition -----
States_SVD <- svd(States_Scaled)

## 3. Construct a correlations biplot using ggplot. ----

#Set scale and find sample size
scale=1
n <- nrow(States)
#Singular values can be put into a diagonal matrix using diag
#Use %*% for matrix multiplication
#Note that the observations are multiplied by root n
PC_obs <- States_SVD$u %*% diag((States_SVD$d)^(1-scale))*sqrt(n)
#Note that the variables are divided by root n
PC_var <- States_SVD$v %*% diag((States_SVD$d)^scale)/sqrt(n)
#Create dataframe for observations with PCs
df_Obs <- tibble(Label=pull(States,StateAbb), #Extract State Abbreviation
                 PC1=PC_obs[,1], #Extract first PC
                 PC2=PC_obs[,2]) #Extract second PC
#Create dataframe for variables
df_Vars <- tibble(Label=colnames(States_Scaled), #Extract State Abbreviation
                  PC1=PC_var[,1], #Extract first loading vector
                  PC2=PC_var[,2]) #Extract second loading vector
ggplot(data = df_Vars, aes(x=PC1,y=PC2,label=Label))+
  geom_text(data=df_Obs)+ #Observations
  geom_text(color='red',nudge_y = -0.2)+ #Variables (offset using nudge_y)
  geom_segment(xend=0,yend=0,color='red', #Add arrow
               arrow = arrow(ends="first",
                             length=unit(0.1, "inches"))) #Make tip smaller

states_pca <- prcomp(States_Scaled)
names(states_pca)
states_pca$x ## ~= df_Obs
states_pca$rotation ## ~=df_Vars


## 4. Using the spectral theorem ----
# , prove that Principal Components are uncorrelated by construction.

## see solution pdf; https://lms.monash.edu/mod/resource/view.php?id=10591597

## Bonus, spinifex ----
library(spinifex)
?spinifex::ggtour
dat <- States_Scaled
rownames(dat) <- pull(States,StateAbb)
bas <- basis_pca(dat)

ggtour(basis_array = bas, data = dat) +
  proto_text() +
  proto_basis()
