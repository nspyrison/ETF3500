# Overview ----

# - Last week we covered PCA (linear dimension reduction)
# - This week focusing on matrices

# This week ----

# 1) Discuss the Concepts section.
# 2) Work through Application as groups (25 min),
#    please ask questions & seek help.
# 3) Discuss and compare against template.


# Content ----

## Vectors ----
a <- c(2,4)
b <- c(1,0)
c <- c(-2,1)
is.vector(a)
is.matrix(a)
class(a) ## not explicit for vectors
length(a)
NROW(a)
dim(a) ## annoyingly, dim(a) is NULL for vectors
a+b


## Matrices ----
t(a)%*%a
## [,1]
## [1,] 20
t(a)%*%b
## [,1]
## [1,] 2
t(a)%*%c
## [,1]
## [1,] 0
a%*%t(b)
## [,1] [,2]
## [1,] 2 0
## [2,] 4 0
#Matrices
#Make sure you set byrow=T
X <- matrix(c(1,2,
              1,4,
              0,-1),
            nrow = 3, ncol =  2, byrow = T)
X
class(X)
is.matrix(X)
dim(X)
length(X)
## [,1] [,2]
## [1,] 1 2
## [2,] 1 4
## [3,] 0 -1
Y<-matrix(c(2,-1,
            3,0,
            3,-1),
          3, 2, byrow = T)
Y
## [,1] [,2]
## [1,] 2 -1
## [2,] 3 0
## [3,] 3 -1
X+Y
## [,1] [,2]
## [1,] 3 1
## [2,] 4 4
## [3,] 3 -2
# X%*%Y This is non-conformable
t(X)%*%Y
## [,1] [,2]
## [1,] 5 -1
## [2,] 13 -1


## Exploring structure/class -----
?is.vector
?is.matrix
?as.matrix # goes to column matrix by default
?class ## More explicit for matrix
?length ## Vector
?dim ## Matrix


## Extra: Orthonormality (linear projection) ----
# ortho-: All columns at right angle.
# -normal: Norm (length) of each column is 1.
# X'X is arbitrarily close to the (p by p) identity matrix, when X is orthonormal.
# 
# Think rotations and Linear bases
bas <- prcomp(mtcars)$rotation
class(bas)
t(bas) %*% bas
t(bas) %*% bas %>% round(3)

