---
    title: "<center> Principal Components Regression </center>"
output:
    html_document:
    fig_height: 4
highlight: pygments
theme: spacelab
pdf_document: default
---
    <center> <h3> Sunah Park </center>
    
    This markdown file is created by Sunah Park for extended lab exercises in the book _An Introduction to Statistical Learning with Applications in R_ [(ISLR)](https://www-bcf.usc.edu/~gareth/ISL/ISLR%20First%20Printing.pdf). 


* * *
    
    ### Setup for code chunks
    ```{r mychunksetup, echo=TRUE, include=TRUE} 
rm(list=ls())
# default r markdown global options in document
knitr::opts_chunk$set(
    ########## Text results ##########
    echo=TRUE, 
    warning=FALSE, # to preserve warnings in the output 
    error=FALSE, # to preserve errors in the output
    message=FALSE, # to preserve messages
    strip.white=TRUE, # to remove the white lines in the beginning or end of a source chunk in the output 
    
    ########## Cache ##########
    cache=TRUE,
    
    ########## Plots ##########
    fig.path="", # prefix to be used for figure filenames
    fig.width=8,
    fig.height=6,
    dpi=200
)
```



* * * 
    ```{r lib, echo=TRUE, include=TRUE} 
library(ISLR)
library(glmnet) # glmnet() function
library(ggplot2)
```


```{r df, echo=TRUE, include=TRUE} 
head(Hitters,3)
Hitters<-na.omit(Hitters)
x<-model.matrix(Salary~., data=Hitters)[,-1]
y<-Hitters$Salary
```
The model.matrix() function is particularly useful for creating x; not only does it produce a matrix corresponding to the 19 predictors but it also automatically transforms any qualitative variables into dummy variables. The latter property is important because glmnet() can only take numerical, quantitative inputs. 

* * *
    ## __Ridge Regression__
    ```{r Ridge, echo=TRUE, include=TRUE} 
grid<-10^seq(10,-2, length=100)
ridge.mod<-glmnet(x,y,alpha=0, lambda=grid, standardize=TRUE)
dim(coef(ridge.mod))

```
The glmnet() function has an alpha argument that determines what type of model is fit. If alpha=0 then a ridge regression model is fit, and if alpha=1 then a lasso model is fit.
Here we have chosen to implement the function over a grid of values ranging from lambda=10^10 to lambda=10^-2, essentially covering the full range of scenarios from the null model containing only the intercept, to the least squares fit. By default, the glmnet() function standardizes the variables so that they are on the same scale. 
Associated with each value of lambda is a vector of ridge regression coefficients, stored in a matrix that can be accessed by coef(). In this case, it is a 20*100 matrix with 20 rows (one for each predictor, plus an intercept) and 100 columns. 

We expect the coefficient estimates to be much smaller, in terms of l2 norm, when a large value of lambda is used, as compared to when a small value of lambda is used. These are the coefficients when lambda=11498 along with their l2 norm:
    ```{r Ridge2, echo=TRUE, include=TRUE} 
ridge.mod$lambda[50]
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2))
predict(ridge.mod, s=50, type="coefficients")[1:20, ] # Ridge regression coefficient for lambda=50

ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1,60]^2))
predict(ridge.mod, s=60, type="coefficients")[1:20, ] # Ridge regression coefficient for lambda=60

```
In contrast, here are the coefficients when lambda=705, along with their l2 norm. Note the much larger l2 norm of the coefficients associated with this smaller value of lambda.


We now split the samples into a random training set and a test set in order to estimate the test error of ridge regression. 
```{r Ridge-split, echo=TRUE, include=TRUE} 
set.seed(1)
train<-sample(1:nrow(x),size=nrow(x)/2)
test<--train
y.test<-y[test]
```

We fit a ridge regression model on the training set and evaluate its MSE on the test set, using lambda=4. We get predictions for a test set, by replacing type="coefficients" with the __newx__ argument.
```{r RidgeReg, echo=TRUE, include=TRUE} 
ridge.mod<-glmnet(x=x[train,], y=y[train], alpha=0, lambda=grid, thresh=1e-12)
plot(ridge.mod)

ridge.pred<-predict(ridge.mod, s=4, newx=x[test,])
mean((ridge.pred-y.test)^2) # MSE
```

The MSE is 101037. We now fit a ridge regression model with a very large value of lambda. 
```{r RidgeReg2, echo=TRUE, include=TRUE} 
ridge.mod<-glmnet(x=x[train,], y=y[train], alpha=0, lambda=grid, thresh=1e-12)

ridge.pred<-predict(ridge.mod, s=10e10, newx=x[test,])
mean((ridge.pred-y.test)^2) # MSE
```

Fitting a ridge regression model with lambda=4 leads to a much lower test MSE than fitting a model with just an intercept. We now check whether there is any benefit to performing ridge regression with lambda=4 instead of just performing least squares regression. Least squares is simply ridge regression with lambda=0.


```{r RidgeReg3, echo=TRUE, include=TRUE} 
ridge.mod<-glmnet(x=x[train,], y=y[train], alpha=0, lambda=grid, thresh=1e-12)

ridge.pred<-predict(ridge.mod, s=0, newx=x[test,])
mean((ridge.pred-y.test)^2) # MSE
```

* * * 
    ## __Tuning parameter lambda__
    The MSE is now smaller than that with very large lambda, but bigger than lambda=4. In general, instead of arbitrarily choosing lambda=4, it would be better to use cross-validation to choose the tuning parameter lambda. We can do this using the built-in cross-validation function, cv.glmnet(). By default, the function performs ten-fold cross-validation, though this can be changed using the argument folds. Note that we set a random seed first so our results will be reproducible, since the choice of the cross-validation folds is random.


```{r tuning, echo=TRUE, include=TRUE} 
set.seed(1)
cv.out<-cv.glmnet(x[train,], y[train], alpha=0, nfolds=10,lambda=NULL, type.measure="mse") # 10-folds CV - lambda default is null and glmnet chooses its own sequence
plot(cv.out)
bestlambda<-cv.out$lambda.min; bestlambda # lambda that gives minimum cvm (mean cross-validated error: MSE in this case), The value of lambda that results in the smallest cv error is 212. 
selambda<-cv.out$lambda.1se; selambda # largest value of lambda such that error is within 1 standard error of the minimum. In this case 7972.

ridge.pred<-predict(ridge.mod, s=bestlambda, newx=x[test,])
mean((ridge.pred-y.test)^2) # MSE associated with the best lambda value

out<-glmnet(x,y, alpha=0) # fitted "glmnet" model object
ridge.coef<-predict(object=out, type="coefficients", s=bestlambda) [1:20,]  # Type "coefficients" computes the coefficients at the requested values for s. newx(Matrix of new values for x at which predictions are to be made) is not used for "coefficients". 

ridge.coef
length(ridge.coef[ridge.coef!=0])
```

We refit our ridge regression model on the full data set, using the value of lambda chosen by cross-validation and examine the coefficient estimates.

* * *
    ## __Lasso Regression__
    ```{r LassoReg, echo=TRUE, include=TRUE} 
lasso.mod<-glmnet(x=x[train,], y[train], alpha=1, lambda=grid) # For Lasso, set alpha=1
plot(lasso.mod)
```

We now perform cross-validation and compute the associated test error. 
```{r LassoReg2, echo=TRUE, include=TRUE} 
set.seed(1)
cv.out<-cv.glmnet(x[train,], y[train], alpha=1, nfolds=10, lambda=NULL, type.measure="mse")
plot(cv.out)

bestlambda<-cv.out$lambda.min; bestlambda
lasso.pred<-predict(lasso.mod, s=bestlambda, newx=x[test,])
mean((lasso.pred-y.test)^2)
```
The MSE of lasso regression(100743) is substantially lower than the test set MSE of the null model and of least squares(114945), and very similar to the test MSE of ridge regression(96015) with lambda chosen by cross-validation. 

However, the lasso has a substantial advantage over ridge regression in that __the resulting coefficient estimates are sparse__. Here we see that 12 of the 19 coefficient estimates are exactly zero. So the lasso model with lambda chosen by cross-validation contains only seven variables.
```{r LassoReg3, echo=TRUE, include=TRUE} 
out<-glmnet(x,y,alpha=1, lambda=grid)
lasso.coef<-predict(out, type="coefficients", s=bestlambda)[1:20,]
lasso.coef
length(lasso.coef[lasso.coef!=0])-1
length(ridge.coef[ridge.coef!=0])-1
```
