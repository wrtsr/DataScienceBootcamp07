library(titanic)

head(titanic_train)


acc <- function(confusion_matrix) {
  (confusion_matrix[1,1] + confusion_matrix[2,2]) / sum(confusion_matrix)
} 

precision <- function(confusion_matrix) {
  confusion_matrix[2,2]/(confusion_matrix[2,1] + confusion_matrix[2,2])
} 

recall <- function(confusion_matrix) {
  confusion_matrix[2,2]/(confusion_matrix[1,2] + confusion_matrix[2,2])
} 

f1 <- function(precision, recall) {
  2 * (precision * recall / (precision + recall))
} 


## drop NA 
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)
glimpse(titanic_test)
titanic_train$Sex <- factor(titanic_train$Sex,
                            levels = c("male", "female"),
                            labels = c(0, 1))



## Split Data

set.seed(75)
n <- nrow(titanic_train)
id <- sample(1:n, size = 0.7*n)
train_data <- titanic_train[id,]
train_data <- titanic_train[id,]
test_data <- titanic_train[-id,]


## Train Model

model <- glm(Survived ~ Pclass + Sex + Age, 
             data = train_data, 
             family = "binomial")


train_data$prob_Survived <- predict(model, type = "response")
train_data$pred_Survived <- ifelse(train_data$prob_Survived >= 0.44, 1, 0)

conf_Matrix_train <- table(train_data$pred_Survived, train_data$Survived, 
                          dnn = c("Prediction", "Actual"))


## Evaluation(Train data)

acc_train <- acc(conf_Matrix_train)
precision_train <- precision(conf_Matrix_train)
recall_train <- recall(conf_Matrix_train)
f1_train <- f1(precision_train, recall_train)


## Test Model

test_data$prob_Survived <- predict(model, newdata = test_data, type = "response")
test_data$pred_Survived <- ifelse(test_data$prob_Survived >= 0.44, 1, 0)

conf_Matrix_test <- table(test_data$pred_Survived, test_data$Survived, 
                           dnn = c("Prediction", "Actual"))


## Evaluation(Test data)

acc_test <- acc(conf_Matrix_test)
precision_test <- precision(conf_Matrix_test)
recall_test <- recall(conf_Matrix_test)
f1_test <- f1(precision_test, recall_test)


## Print Result
cat("Train Score",
    "\n Accuracy:", acc_train,
    "\n Precision:", precision_train,
    "\n Recall:", recall_train,
    "\n F1 score:", f1_train,
    "\n \n Test Dataset Evaluation",
    "\n Accuracy:", acc_test,
    "\n Precision:", precision_test,
    "\n Recall:", recall_test,
    "\n F1 score:", f1_test)



