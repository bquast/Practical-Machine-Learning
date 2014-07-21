# quiz 2
# Bastiaan Quast

# question 1
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)

adData = data.frame(predictors)
trainIndex = createDataPartition(diagnosis,p=0.5,list=FALSE)
training = adData[trainIndex,]
testing = adData[-trainIndex,]

# question 2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength,
                              p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
featurePlot(x = training[,c('Cement',
                            'BlastFurnaceSlag',
                            'FlyAsh',
                            'Water',
                            'Superplasticizer',
                            'CoarseAggregate',
                            'FineAggregate', 'Age')],
            y = training$CompressiveStrength )

# question 3
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength,
                              p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
qplot(Superplasticizer, data=training)


# question 4
library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)
set.seed(3433)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis,
                              p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

ss <- training[,grep('^IL', x = names(training) )]
preProc <- preProcess(ss, method='pca', thresh = 0.8, outcome = training$diagnosis)


# question 5
library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
ss <- testing[,grep('^IL', x = names(testing) )]
model1 <- train(ss, testing$diagnosis, method='glm')
model2 <- preProcess(ss, method='pca', thresh = 0.8, outcome = testing$diagnosis)
