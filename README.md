# Predicting the Quantified Self
Bastiaan Quast  
Monday, July 21, 2014  

## Abstract
A two line summary


## Introduction
quantified self, etc.


## Data
The data is taken from the [Human Activity Recognition](http://groupware.les.inf.puc-rio.br/har) programme at [Groupware](http://groupware.les.inf.puc-rio.br/).

We start the data loading procedure by specifying the data sources and destinations.

```r
training.file <- 'pml-training.csv'
test.file     <- 'pml-test.csv'
training.url  <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
test.url      <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
```
We then execute the download.

```r
download.file(training.url, training.file)
download.file(test.url,     test.file)
```

In order to ensure all transformations are applied to both the trainig and test data sets equally, we employ the OOP method and create functions for every step. First we create function to read data and set NAs and apply this to both datasets.

```r
read.pml <- function(x) { read.csv(x, na.strings = c("", "NA", "#DIV/0!") ) }
training <- read.pml(training.file)
test     <- read.pml(test.file)
```
Next we create a function to remove entire NA columns, and apply it to both data frames.

```r
na.cols  <- function(x) { x [ , colSums( is.na(x) ) < nrow(x) ] }
training <- na.cols(training)
test     <- na.cols(test)
```

## Method
features


## Results
plots, nice ones! with ggvis
