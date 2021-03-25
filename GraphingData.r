#### Graphing data

library(caret)
library(mlbench)
library(AppliedPredictiveModeling)

## Setwd forward / 
setwd("C:/Users/ch373676/Downloads/Data Science Datasets")
setwd(choose.dir())
setwd(choose.files())
list.files()

## Load data
weather_orig <- read.table("weather data_original.csv", header=T, sep=",")
weather_orig2 <- read.csv(file="weather data_original.csv", header=T, sep=",")

# Look at dataset
names(weather_orig)
dim(weather_orig)
str(weather_orig)
head(weather_orig)
tail(weather_orig)
summary(weather_orig)

## Visualize data
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="pairs", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="ellipse", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="box", auto.key=list(columns=3))
featurePlot(x=weather_orig[,1:4], y=weather_orig$Events, plot="density", scales=list(x=list(relation="free"), y=list(relation="free")), auto.key=list(columns=3))

