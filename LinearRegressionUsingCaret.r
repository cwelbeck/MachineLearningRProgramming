# Linear Regression using Caret

# Finish the model by replacing the blank with the `train` object
> mtcars_model <- train(mpg ~ wt, data = train, method = "lm")
> 
> # Predict the mpg of each car by replacing the blank with the `test` object
> results <- predict(mtcars_model, newdata = test)
>        
> # Print the `results` object
> results
 Porsche 914-2   Lotus Europa Ford Pantera L   Ferrari Dino  Maserati Bora 
      26.23480       29.58286       20.73479       22.87071       18.59886 
    Volvo 142E 
      22.81731 
	  
	  