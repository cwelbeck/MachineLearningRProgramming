

# # # Linear Regression: Start to Finish
install.packages("caret", dependencies=c("Depends", "Suggests")
seed = 7 / set.seed(7)
Library(caret)
library(dataset)
data(mtcars)
str(mtcars)
names(mtcars)
summary(mtcars)
head(mtcars)
tail(mtcars)

# Check for missing data
anyNA(mtcars)
sum(is.na(mtcars))

# Fix missing data

# Add Visualization

# Split dataset
inTrain <- createDataPartition(mtcars$wt, p=.8, list=FALSE)
training <- mtcars[inTrain, ]
verification <- mtcars[-inTrain, ]

# Linear Regression mpg to wt Single Variable Comparison
# prepare resampling method
control <- trainControl(method="cv", number=5)
set.seed(7)
mtcars_model <- train(mpg ~ wt, data=trianing, method="lm", metric="Accuracy", trControl=control)
results <- predict(mtcars_model, newdata=verification)
results

# Linear Regression All Variable Comparison
# prepare resampling method
control <- trainControl(method="cv", number=5)
set.seed(7)
mtcars_model <- training(mpg ~., data=trianing, method="lm", metric="Accuracy", trControl=control)
results <- predict(mtcars_model, newdata=verification)
results

# Model Evaluation