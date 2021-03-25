

#### https://rstudio-pubs-static.s3.amazonaws.com/274015_89b386c285e94627969c309cd6d1a36e.html
#https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/
### https://www.r-bloggers.com/missing-value-treatment/

.libPaths("C:/Users/user/Desktop/WorkingDIR/MyLibrary")
.libPaths()
list.files()
list.dirs()


# Read original data table
list.files()
weather_orig=read.table("weather data_original.csv", header = T, sep = ",")
weather_orig=as.data.frame(weather_orig)
head(weather_orig)
View(weather_orig)


# Read missing data table

list.files()
weather=read.table("weather data_missing.csv", header = T, sep = ",")
weather=as.data.frame(weather)
weather[ weather == " " ] = NA
head(weather)
View(weather)
summary(weather)


#seed 10% missing values
> iris.mis <- prodNA(iris, noNA = 0.1)
> summary(iris.mis)

#############Method 1 using MICE##########

#MICE package helps you to impute missing values by using multiple 
#techniques,depending on the kind of data you are working with.
#the methods used by this package are:
  
#  PMM (Predictive Mean Matching)  â For numeric variables
#  logreg(Logistic Regression) â For Binary Variables( with 2 levels)
#  polyreg(Bayesian polytomous regression) â For Factor Variables (>= 2 levels)
#  Proportional odds model (ordered, >= 2 levels)

install.packages("VIM")
install.packages("SparseM")
library(VIM)
library(SparseM)

install.packages("mice")
library(mice)

md.pattern(weather)
mice_plot <- aggr(weather, col=c('navyblue','yellow'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(weather), cex.axis=.7,
                  gap=1, ylab=c("Missing data","Pattern"))

imputed_Data <- mice(weather, m=9, maxit = 50, method = 'pmm', seed = 500)
summary(imputed_Data)


#check imputed values

imputed_Data$imp$Prec
imputed_Data$imp$Hum.h

#get complete data ( 3rd out of 9)
completeData_4 <- complete(imputed_Data,4)
head(completeData_4,n=15)

# Quick optimization for the best dataset
head(weather_orig, n=15 )
a=(abs(weather_orig[,-9]-completeData_4[,-9]))
sum(a$Dew.l)/sum(weather_orig$Dew.l)
sum(a$Temp.h)/sum(weather_orig$Temp.h)


#save file on disk
write.csv(x = completeData_4,file="MICE.csv")



############# Method 2 using "Hmisc"##########

#Hmisc is a multiple purpose package useful for data analysis, 
#high â level graphics, imputing missing values, advanced table 
#making, model fitting & diagnostics (linear regression, logistic 
#regression & cox regression) etc.

install.packages("Hmisc")
install.packages("survival")
library(Hmisc)
library(survival)

# impute with mean value
head(weather, n=15) # * indicate the imputed value
weather$imputed_Dew_h <- with(weather, impute(Dew.h, mean))
head(weather)
# impute with random value
weather$imputed_Temp.h <- with(weather, impute(Temp.h, 'random'))
head(weather,n=10)



#save file on disk
write.csv(x =weather ,file="Hmisc.csv")

############# Method 3 using "missForest"##########

install.packages("missForest")
library(missForest)

#impute missing values, using all parameters as default values

weather.imp <- missForest(weather)

#check imputed values
weather.imp$ximp
head(weather.imp)
#check imputation error
#NRMSE is normalized mean squared error. It is used to represent error -
#derived from imputing continuous values. 
#PFC (proportion of falsely classified) is used to represent error derived 
# from imputing categorical values.
weather.imp$OOBerror

#comparing actual data accuracy

# mixError(ximp, xmis, xtrue)

#  ximp	
#      imputed data matrix with variables in the columns and observations in the rows. Note there should not be any missing values.
#  xmis	
#     data matrix with missing values.
#  xtrue	
#      complete data matrix. Note there should not be any missing values.


View(weather.imp$ximp)
View(weather)
View(weather_orig)
weather.err <- mixError(weather.imp$ximp, weather, weather_orig)
weather.err

#to save the output

write.csv(weather.imp$ximp, "missforest.csv")

#This suggests that categorical variables are imputed with 70% error 
#and continuous variables are imputed with 26% error. 

