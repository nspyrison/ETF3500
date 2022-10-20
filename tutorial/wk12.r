# Overview ----

# - Last week we covered Correspondence Analysis
# - This week's focus: Revision



# Content ----

#DATA: The FRED-QD is a quarterly U.S. database for macroeconomic research. We extracted from this data 152
#quarterly observations for the following five variables:
#  GDP_Growth: Real gross department product growth.
#HOUST: New privately owned housing units started.
#SP500: Financial returns.
#Inflation: Inflation constructed from the DGP deflator index (change in overall prices).
#IndustrialProd: Growth of industrial production.


### SEE THE REVISION FOR THE BLUK OF THE WORK -- INTERPRETING/THEORY


Psi = diag(c(0.0572,0.823,0.005,0.952,0.412))
# Now let's create Lambda
Lambda = matrix(c(0.958,0.158,
                  0.305,0.290,
                  0.159,0.985,
                  0.203,0.0823,
                  0.752,0.151),5,2,byrow = T)
# Finally, we can construct the sample variance covariance matrix as
Sigma = Lambda%*%t(Lambda)+Psi
print(Sigma)
