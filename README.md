# Predicting the Quantified Self
Bastiaan Quast  
Monday, July 21, 2014  

## Abstract
We use the random forest method to estimate features for the Human Activity Recognition data set from Groupware. We that this method produces relevant results.


## Data
The data is taken from the [Human Activity Recognition](http://groupware.les.inf.puc-rio.br/har) programme at [Groupware](http://groupware.les.inf.puc-rio.br/).

We start the data loading procedure by specifying the data sources and destinations.

```r
training.file <- 'pml-training.csv'
test.file     <- 'pml-test.csv'
training.url  <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv'
test.url      <- 'https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv'
```
We then execute the downloads.

```r
download.file(training.url, training.file, method='wget')
download.file(test.url,     test.file,     method='wget')
```
In order to ensure all transformations are applied to both the trainig and test data sets equally, we employ the OOP method and create functions for every step. First we create a function to read data and set NAs and apply this to both datasets.

```r
read.pml       <- function(x) { read.csv(x, na.strings = c("", "NA", "#DIV/0!") ) }
training       <- read.pml(training.file)
test           <- read.pml(test.file)
training       <- training[,-c(1,5,6)]
test           <- test[,-c(1,5,6)]
```


```r
library(caret)
trainingIndex  <- createDataPartition(training$classe, p=.50, list=FALSE)
training.train <- training[ trainingIndex,]
training.test  <- training[-trainingIndex,]
```

Next we create a function to remove entire NA columns, and apply it to both data frames. Lastly we create a function that removes any variables with missing NAs and apply this to the training set.

```r
rm.na.cols     <- function(x) { x[ , colSums( is.na(x) ) < nrow(x) ] }
training.train <- rm.na.cols(training.train)
training.test  <- rm.na.cols(training.test)
complete       <- function(x) {x[,sapply(x, function(y) !any(is.na(y)))] }
incompl        <- function(x) {names( x[,sapply(x, function(y) any(is.na(y)))] ) }
trtr.na.var    <- incompl(training.train)
trts.na.var    <- incompl(training.test)
training.train <- complete(training.train)
training.test  <- complete(training.test)
```

## Method
We use the **Random Forests** method [@breiman2001random], which applies **bagging** to **tree learners**. The **B**ootstap **Agg**regat**ing** (bagging) method is described in Technical Report No. 421: Bagging Predictors [@breiman1996bagging].

```r
library(randomForest)
random.forest <- train(training.train[,-57],
                       training.train$classe,
                       tuneGrid=data.frame(mtry=3),
                       trControl=trainControl(method="none")
                       )
```


## Results
Some statistics on the results

```r
summary(random.forest)
```

```
##                 Length Class      Mode     
## call                4  -none-     call     
## type                1  -none-     character
## predicted        9812  factor     numeric  
## err.rate         3000  -none-     numeric  
## confusion          30  -none-     numeric  
## votes           49060  matrix     numeric  
## oob.times        9812  -none-     numeric  
## classes             5  -none-     character
## importance         56  -none-     numeric  
## importanceSD        0  -none-     NULL     
## localImportance     0  -none-     NULL     
## proximity           0  -none-     NULL     
## ntree               1  -none-     numeric  
## mtry                1  -none-     numeric  
## forest             14  -none-     list     
## y                9812  factor     numeric  
## test                0  -none-     NULL     
## inbag               0  -none-     NULL     
## xNames             56  -none-     character
## problemType         1  -none-     character
## tuneValue           1  data.frame list     
## obsLevels           5  -none-     character
```
We now compare the results from the predition with the actual data.

```r
confusionMatrix(predict(random.forest,
                        newdata=training.test[,-57]),
                training.test$classe
                )
```

```
## Loading required package: randomForest
## randomForest 4.6-7
## Type rfNews() to see new features/changes/bug fixes.
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 2790    5    0    0    0
##          B    0 1893    7    0    0
##          C    0    0 1703    5    0
##          D    0    0    1 1602    2
##          E    0    0    0    1 1801
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9979          
##                  95% CI : (0.9967, 0.9987)
##     No Information Rate : 0.2844          
##     P-Value [Acc > NIR] : < 2.2e-16       
##                                           
##                   Kappa : 0.9973          
##  Mcnemar's Test P-Value : NA              
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            1.0000   0.9974   0.9953   0.9963   0.9989
## Specificity            0.9993   0.9991   0.9994   0.9996   0.9999
## Pos Pred Value         0.9982   0.9963   0.9971   0.9981   0.9994
## Neg Pred Value         1.0000   0.9994   0.9990   0.9993   0.9998
## Prevalence             0.2844   0.1935   0.1744   0.1639   0.1838
## Detection Rate         0.2844   0.1930   0.1736   0.1633   0.1836
## Detection Prevalence   0.2849   0.1937   0.1741   0.1636   0.1837
## Balanced Accuracy      0.9996   0.9982   0.9974   0.9980   0.9994
```
The Kappa statistic of 0.994 reflects the out-of-sample error.


```r
plot( varImp(random.forest) )
```

![plot of chunk plot](./README_files/figure-html/plot.png) 

## References
