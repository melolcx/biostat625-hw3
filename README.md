# Linear_Regression_Summary
  <!-- badges: start -->
  [![R-CMD-check](https://github.com/melolcx/biostat625-hw3/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/melolcx/biostat625-hw3/actions/workflows/R-CMD-check.yaml)
  [![Codecov test coverage](https://codecov.io/gh/melolcx/biostat625-hw3/branch/main/graph/badge.svg)](https://app.codecov.io/gh/melolcx/biostat625-hw3?branch=main)
  <!-- badges: end -->
  
# R package for the summary of linear regression
Linear_Regression_Summary is a package built for the summary of linear regression and it is friendly to rookies. 

## Description
This package only contains one function "LR", which can be used to produce summary statistics of the model input. It contains more common used output and less output that is not that useful for basic analysis.

## Model
The model for linear regression is:
Y = Beta_0 + Beta_1 * X_1 + Beta_2 * X_2 + ... + Beta_n * X_n + r

## Installation
The package can be installed to R environment with devtools::install.github()
```r
# install using devtools from GitHub:
devtools::install_github("melolcx/biostat625-hw3")

# browse vignitte, install with:
devtools::install_github("melolcx/biostat624-hw3", build_vignettes = T)
```

## Functions
The function LR() need 3 inputs: "data, "x" and "y". "data" is the aimed data that you want to fit a linear regression model, "x" is the independent variables that you are interested in and y is for dependent variable. The number of x is not limited while the number of y is limited to 1.

Using this function, there will be a general output for a sheet of statistics with formula, residuals, coefficient, 95% confidence intervals, R-squared and F-ststistic with its p-value. 

At the same time, each type of output will be divided with a list so that it will be easier to directly use them with "[]".

## Usage
```
library(LR)
library(datasets)
data(swiss)
data <- swiss
x <- c("Fertility", "Agriculture", "Examination", "Education")
y <- "Infant.Mortality"
LR(data, x, y)
```

## Contribution
melolcx

## Contact
melolcx@umich.edu
