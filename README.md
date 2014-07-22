# Predicting the Quantified Self
Bastiaan Quast  
Monday, July 21, 2014  

## Abstract
A two line summary


## Introduction
quantified self, etc.


## Data
Specify the data sources and destinations.

```r
training.file <- 'pml-training.csv'
test.file     <- 'pml-test.csv'
training.url  <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
test.url      <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
```
Execute the download.

```r
download.file(training.url, training.file)
download.file(training.url, training.file)
```
Read the data

```r
training <- read.csv(training.file)
test     <- read.csv(test.file)
```


## Method
features


## Results
plots, nice ones! with ggvis
