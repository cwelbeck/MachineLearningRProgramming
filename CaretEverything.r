
##### Working directory
setwd()
getwd()
list.files()

# Install & Load Caret
install.packages("caret", dependcies = c("Depends", "Suggests"))
library(caret)

# Install & Load R datasets
install.packages("datasets.load")
library(caret)
library(datasets)
library(AppliedPredictiveModeling)
library(VIM)
library(SparseM)
library(mlbench)
library(mice)
library(missForest)
set.seed = 134
seed = 134



# Optional
library(mlbench)

# Load Iris dataset
data(iris)


# Import dataset
FakeGraph <- read.csv(file="FakeGraph.csv", header=T, sep=",")
weather_orig <- read.table("weather data_original.csv", header=T, sep=",")
weather_orig2 <- read.csv(file="weather data_original.csv", header=T, sep=",")

# Look at dataset
dim(iris), dim(iris)
head(iris), head(iris, n=5)
tail(iris), tail(iris, n=5)
# Only column names
names(iris)
str(iris)
summary(iris)
summary(iris$Sepal.Length)
summary(iris$Species)
View(missing_data)
weather_orig=as.data.frame(weather_orig)

##### Missing values https://www.r-bloggers.com/missing-value-treatment/

# # Read missing data table

list.files()
weather=read.table("weather data_missing.csv", header = T, sep = ",")
weather=as.data.frame(weather)
weather[ weather == " " ] = NA
head(weather)
View(weather)
summary(weather)

# # Missing values
weather[ weather == " " ] = NA
weather=as.data.frame(weather)
md.patttern(weather)
anyNA(iris)
sum(is.na(iris))
is.na(iris)
mean(is.na(iris))
which(is.na(x))
na.omit(iris)

# excluding NA values
mean(x, na.rm = TRUE)

#seed 10% missing values
> iris.mis <- prodNA(iris, noNA = 0.1)
> summary(iris.mis)

## Graph missing vlaues
mice_plot <- aggr(weather, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(weather), cex.axis=.7,
                  gap=1, ylab=c("Missing data","Pattern"))

# Summary on One Variable
summary(iris$Sepal.Length)
summary(iris$Species)

# filter() the data for species setosa
setosa <- filter(iris, iris$Species == "setosa")

# filter() for length
sepalLength6 <- filter(iris, species == "virginica", sepal.length > 6)

# select() the specified columns
selected <- select(iris, sepal.length, sepal.width, petal.length)
# select all columns from sepal.length to petal.length
selected2 <- select(iris, sepal.length:petal.length)
head(selected, 3)


# Upper & LowerCase
toupper(iris)
tolower(iris)

# Visualize data
plot(iris)
plot(iris$Sepal.Length, iris$Sepal.Width)
hist(iris$Sepal.Length)
featurePlot(x=iris[,1:4], y=iris[,5], plot="pairs", auto.key=list(columns=3))
featurePlot(x=iris[,1:4], y=iris[,5], plot="ellipse", auto.key=list(columns=3))
featurePlot(x=iris[,1:4], y=iris[,5], plot="box", auto.key=list(columns=3))
featurePlot(x=iris[,1:4], y=iris[,5], plot="density", scales=list(x=list(relation="free), y=list(relation="free)), auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="pairs", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="ellipse", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="box", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="density", scales=list(x=list(relation="free"), y=list(relation="free")), auto.key=list(columns=3))

# Visualize data scatter plot
xyplot(tempData,Ozone ~ Wind+Temp+Solar.R,pch=18,cex=1)
densityplot(tempData)
stripplot(tempData, pch = 20, cex = 1.2)

# Split dataset
inTrain <- createDataPartition(iris$Species, p=0.8, list=FALSE)
training <- iris[inTrain, ]
verification <- iris[-inTrain, ]

# # Missing values https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/
## ## Missing values https://rstudio-pubs-static.s3.amazonaws.com/274015_89b386c285e94627969c309cd6d1a36e.html

## Missing values example 1
## S3 method for class 'train':
    predict((object, newdata = NULL, type = "raw", na.action = na.omit, ...)
	
## Missing values example 2
 ## S3 method for class 'default':
    preProcess(x, 
       method = "knnImpute",   # or *bagImpute* / *medianImpute*
       pcaComp = 10,
       na.remove = TRUE,
       k = 5,
       knnSummary = mean,
       outcome = NULL,
       fudge = .2,
       numUnique = 3,
       verbose = TRUE,
       )

# # Make some data (incl. verification) missing on purpose.
fillInNa <- function(d) {
  naCount <- NROW(d) * 0.1
  for (i in sample(NROW(d), naCount)) {
     d[i, sample(4, 1)] <- NA
  }
  return(d)
}
 
training <- fillInNa(training)
verification <- fillInNa(verification)


# Because we have missing values across all columns, we need to
# use bagged trees. If just one column had NAs, we can use
# knnImpute which is faster. Also, note that preProcess is done
# only for training. For verification, we use the
# preProc generated from training.
preProc <- preProcess(method="bagImpute", training[, 1:4])
training[, 1:4] <- predict(preProc, training[, 1:4])
verification[, 1:4] <- predict(preProc, verification[, 1:4])



# SVM
# I have a quadcore processor, and train builds three different models
# with different parameters for parameter optimization purpose.
# registerDoMC() makes it parallel, i.e., three model building
# at the same time.
registerDoMC(cores=4) 
model <- train(training[, 1:4], training[, 5], method="svmRadial")
confusionMatrix(predict(model, verification[, 1:4]), verification[, 5])




