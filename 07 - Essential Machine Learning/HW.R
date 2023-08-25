## House price India
## predict house price with 3 - 5 features

train_test_split <- function(data, ratio = 0.7){
  set.seed(75)
  n <- nrow(data)
  id <- sample(1:n, size = ratio*n)
  
  train_data <- data[id,]
  test_data <- data[-id,]
  
  return( list(train = train_data, test = test_data) )
}

mae_matice <- function(actual, prediction){
  abs <- abs(actual - prediction)
  mean(abs)
}

mse_matice <- function(actual, prediction){
  se <- (actual - prediction)**2
  mean(se)
}

rmse_matice <- function(actual, prediction){
  se <- (actual - prediction)**2
  sqrt(mean(se))
}


## Import Data
library(readxl)
df <- data.frame(read_excel('House Price India.xlsx', sheet = 2))


## Split Data
split_data <- train_test_split(df, 0.7)
train_data <- split_data[[1]]
test_data <- split_data[[2]]

## Train Model
model <- lm(Price ~ number.of.bedrooms + number.of.bathrooms + living.area + number.of.floors + grade.of.the.house,
            data = train_data)

## Score
(Price_pred <- predict(model, newdata = test_data))

## Evaluate
mae_matice(test_data$Price, Price_pred)
mse_matice(test_data$Price, Price_pred)
rmse_matice(test_data$Price, Price_pred)
