# run, tune and evaluate two supervised ML algorithms (each with two types of training data) to identify the most accurate way of classifying malicious events.
# You do not need to concern yourself about the specifics of the SIEM plugin or software integration.

install.packages(c("tidyverse", "caret", "glmnet", "forcats", "rpart", "rpart.plot", "ipred", "e1071", "ggpubr", "pROC"))

library(tidyverse) # data manipulation and visualization
library(caret) # classification and regression training
library(glmnet) # LASSO and Elastic-Net Regularized Generalized Linear Models
library(forcats) # for factor manipulation
library(rpart) # recursive partitioning and regression trees
library(rpart.plot) # plotting trees
library(ipred) # improved predictive models
library(e1071) # support vector machines
library(ggpubr) # ggplot2-based publication ready plots
library(pROC) # For AUC and ROC analysis

# My working directory
setwd("C:/Users/drewc/OneDrive/Documents/J97 - Master of Cyber Security/CYB6009-Data-Analysis-and-Visualisation/Assignment 02")
getwd()

# Import the data
MLData2023 <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)
str(MLData2023)

MLData2023_cleaned <- MLData2023 %>%
  select(-IPV6.Traffic) %>%
  mutate(
    Assembled.Payload.Size = replace(Assembled.Payload.Size, Assembled.Payload.Size == -1, NA),
    Operating.System = factor(replace(Operating.System, Operating.System == "-", NA)),
    Class = factor(replace(Class, Class == "-1" | Class == "99999", NA))
  ) %>%
  mutate(Operating.System = fct_collapse(Operating.System,
                                         Windows_All = c("Windows 7", "Windows 10+", "Windows (Unknown)"),
                                         Other_OS = c("iOS", "Linux (unknown)", "Other")
           ),
         Connection.State = fct_collapse(Connection.State,
                                         Others = c("INVALID", "NEW", "RELATED")
           )
  ) %>%
  filter(Class %in% c(0, 1)) %>%
  na.omit()
str(MLData2023_cleaned)

# Splitting the Data
set.seed(1)
dat.class0 <- filter(MLData2023_cleaned, Class == 0)
dat.class1 <- filter(MLData2023_cleaned, Class == 1)

rows.train0 <- sample(1:nrow(dat.class0), size = 19800, replace = FALSE)
rows.train1 <- sample(1:nrow(dat.class1), size = 200, replace = FALSE)

train.class0 <- dat.class0[rows.train0, ]
train.class1 <- dat.class1[rows.train1, ]
mydata.ub.train <- rbind(train.class0, train.class1) %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))

train.class1_2 <- dat.class1[sample(1:nrow(dat.class1), size = 19800, replace = TRUE), ]
mydata.b.train <- rbind(train.class0, train.class1_2) %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))

test.class0 <- dat.class0[-rows.train0, ]
test.class1 <- dat.class1[-rows.train1, ]
mydata.test <- rbind(test.class0, test.class1) %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))

# Write training and testing sets to csv files
write.csv(mydata.b.train, "mydata.b.train.csv", row.names = FALSE)
write.csv(mydata.ub.train, "mydata.ub.train.csv", row.names = FALSE)
write.csv(mydata.test, "mydata.test.csv", row.names = FALSE)

# Logistic LASSO Regression Model Training
set.seed(1)
lambda_range <- 10^seq(-5, 1, length = 100)
lasso_model_b <- train(
  Class ~ ., data = mydata.b.train, method = "glmnet",
  trControl = trainControl("repeatedcv", number = 10, repeats = 5),
  tuneGrid = expand.grid(alpha = 1, lambda = lambda_range)
)

lasso_model_ub <- train(
  Class ~ ., data = mydata.ub.train, method = "glmnet",
  trControl = trainControl("repeatedcv", number = 10, repeats = 5),
  tuneGrid = expand.grid(alpha = 1, lambda = lambda_range)
)

# Bagging Tree Model Training
set.seed(1)
bagging_model_b <- bagging(
  Class ~ ., data = mydata.b.train, coob = TRUE, nbagg = 100,
  control = rpart.control(cp = 0.01, minsplit = 20)
)

bagging_model_ub <- bagging(
  Class ~ ., data = mydata.ub.train, coob = TRUE, nbagg = 100,
  control = rpart.control(cp = 0.01, minsplit = 20)
)

# Evaluating the Models
evaluate_model <- function(model, data_test, pred_type = "class") {
  # Use pred_type to specify the prediction type dynamically
  predictions <- predict(model, newdata = data_test, type = pred_type)
  cm <- confusionMatrix(predictions, data_test$Class)
  return(cm)
}

# Evaluating bagging models (unchanged calls, using default pred_type = "class")
evaluation_b_bagging <- evaluate_model(bagging_model_b, mydata.test)
evaluation_ub_bagging <- evaluate_model(bagging_model_ub, mydata.test)

# Evaluating LASSO models (specify pred_type = "raw" for LASSO models)
evaluation_b_lasso <- evaluate_model(lasso_model_b, mydata.test, pred_type = "raw")
evaluation_ub_lasso <- evaluate_model(lasso_model_ub, mydata.test, pred_type = "raw")

# Print Evaluation Results
print_evaluation_results <- function(cm, model_name) {
  cat("Model:", model_name, "\n")
  cat("Accuracy:", cm$overall['Accuracy'], "\n")
  cat("Kappa:", cm$overall['Kappa'], "\n")
  
  precision <- cm$byClass['Pos Pred Value']
  recall <- cm$byClass['Sensitivity']
  f1_score <- 2 * ((precision * recall) / (precision + recall))
  
  cat("Precision:", precision, "\n")
  cat("Recall:", recall, "\n")
  cat("F1 Score:", f1_score, "\n")
  
  print(cm$table)
  cat("\n")
}

print_evaluation_results(evaluation_b_lasso, "LASSO Balanced")
print_evaluation_results(evaluation_ub_lasso, "LASSO Unbalanced")
print_evaluation_results(evaluation_b_bagging, "Bagging Balanced")
print_evaluation_results(evaluation_ub_bagging, "Bagging Unbalanced")

# EOF