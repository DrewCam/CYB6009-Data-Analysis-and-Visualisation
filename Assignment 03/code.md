
```r
# install.packages(c("tidyverse", "caret", "forcats", "rpart", "rpart.plot", "ipred", "e1071", "ggpubr", "pROC"))

# Load the required libraries

library(tidyverse) # Dplyr etc, Data manipulation
library(forcats) # factor manipulation
library(caret) # logistic LASSO regression
library(ipred) # bagging
library(ggplot2) # Data visualisation
library(rpart) # Recursive Partitioning and Regression Trees
library(rpart.plot) # plot rpart model

# My working directory
setwd("/Assignment 02")
getwd()

# Import the data
MLData2023 <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)
str(MLData2023)

## Part 1 - General data preparation and cleaning

# Remove IPv6.Traffic feature. It has a large proportion of invalid or bad data, advised to remove it from the data set.
MLData2023 <- MLData2023 %>% select(-IPV6.Traffic)

# Remove -1 values in Assembly.Payload.Size feature and replace with NA as size cannot be negative.
MLData2023 <- MLData2023 %>%
  mutate(Assembled.Payload.Size = replace(Assembled.Payload.Size, Assembled.Payload.Size == -1, NA))

# Replace invalid values and Operating.System categories with NA and reapply factor.
MLData2023 <- MLData2023 %>%
  mutate(Operating.System = factor(replace(Operating.System, Operating.System == "-", NA)))

# take Class and apply factor - remove any -1 or 99999 values and replace with NA
MLData2023 <- MLData2023 %>%
  mutate(Class = factor(replace(Class, Class == "-1" | Class == "99999", NA)))

# Merge Operating.System categories Windows 7, Windows 10+, Windows (Unknown) in to one category called Windows_All
MLData2023$Operating.System <- fct_collapse(MLData2023$Operating.System,
                                            Windows_All = c("Windows 7", "Windows 10+", "Windows (Unknown)"))

# Merge Operating.System categories iOS, Linux(Unknown) and Other in to a new category called Other_OS
MLData2023$Operating.System <- fct_collapse(MLData2023$Operating.System,
                                            Other_OS = c("iOS", "Linux (unknown)", "Other"))

# Merge Connection.State categories INVALID, NEW and RELATED to form a new category called Others
MLData2023$Connection.State <- fct_collapse(MLData2023$Connection.State,
                                            Others = c("INVALID", "NEW", "RELATED"))

# filter data to only include cases labelled with Class = 0 or 1
MLData2023 <- subset(MLData2023, Class %in% c(0, 1))

# Select only the complete cases using the na.omit(.) function, and name the dataset MLData2023_cleaned
MLData2023_cleaned <- na.omit(MLData2023)

str(MLData2023_cleaned)

# Separate samples of non-malicious and malicious events
dat.class0 <- MLData2023_cleaned %>% filter(Class == 0) # non-malicious
dat.class1 <- MLData2023_cleaned %>% filter(Class == 1) # malicious

# Randomly select 19800 non-malicious and 200 malicious samples, then combine them to form the training samples
set.seed(1)
rows.train0 <- sample(1:nrow(dat.class0), size = 19800, replace = FALSE)
rows.train1 <- sample(1:nrow(dat.class1), size = 200, replace = FALSE)
# Your 20000 unbalanced training samples
train.class0 <- dat.class0[rows.train0, ] # Non-malicious samples
train.class1 <- dat.class1[rows.train1, ] # Malicious samples
mydata.ub.train <- rbind(train.class0, train.class1)
mydata.ub.train <- mydata.ub.train %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))
# Your 39600 balanced training samples, i.e. 19800 non-malicious and malicious samples each.
set.seed(123)
train.class1_2 <- train.class1[sample(1:nrow(train.class1), size = 19800,
                                      replace = TRUE), ]
mydata_b_train <- rbind(train.class0, train.class1_2)
mydata_b_train <- mydata_b_train %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))
# Your testing samples
test.class0 <- dat.class0[-rows.train0, ]
test.class1 <- dat.class1[-rows.train1, ]
mydata.test <- rbind(test.class0, test.class1)
mydata.test <- mydata.test %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))

# View the structure of the training and testing sets
str(mydata_b_train) # balanced training set
str(mydata.ub.train) # unbalanced training set
str(mydata.test) # testing set

# Write training and testing sets to csv files
write.csv(mydata_b_train, "mydata_b_train.csv", row.names = FALSE)
write.csv(mydata.ub.train, "mydata.ub.train.csv", row.names = FALSE)
write.csv(mydata.test, "mydata.test.csv", row.names = FALSE)

# Select models to be evaluated.
set.seed(1)
models.list1 <- c("Logistic Ridge Regression",
                  "Logistic LASSO Regression",
                  "Logistic Elastic-Net Regression")
models.list2 <- c("Classification Tree",
                  "Bagging Tree",
                  "Random Forest")
myModels <- c(sample(models.list1, size = 1),
              sample(models.list2, size = 1))
myModels %>% data.frame

# Models
# Logistic LASSO Regression
# Bagging Tree

# Logistic LASSO Regression on the balanced training set mydata_b_train

# Range of lambda values to test
lambdas <- 10^seq(-5, 1, length = 100)

# Logistic LASSO Regression on the balanced training set
lasso_model_b <- train(Class ~ ., #Formula
                       data = mydata_b_train, #Training data
                       method = "glmnet", #Penalised regression modelling
                       preProcess = NULL,
                       #Perform 10-fold CV, 5 times over.
                       trControl = trainControl("repeatedcv",
                                                number = 10,
                                                repeats = 5),
                       tuneGrid = expand.grid(alpha = 1, #LASSO regression
                                              lambda = lambdas))

# Logistic LASSO Regression on the unbalanced training set mydata.ub.train

lasso_model_ub <- train(Class ~ ., #Formula
                        data = mydata.ub.train, #Training data
                        method = "glmnet", #Penalised regression modelling
                        preProcess = NULL,
                        #Perform 10-fold CV, 5 times over.
                        trControl = trainControl("repeatedcv",
                                                 number = 10,
                                                 repeats = 5),
                        tuneGrid = expand.grid(alpha = 1, #LASSO regression
                                               lambda = lambdas))

# Bagging Grid to identify best parameters.

bagging_grid <- expand.grid(nbagg = seq(50, 200, 50),  #A sequence of nbagg values
                            cp = seq(0, 0.5, 0.1),  #A sequence of cp values
                            minsplit = seq(5, 15, 5),  #A sequence of minsplits values
                            #Initialise columns to store the OOB misclassification rate
                            OOB.misclass = NA,
                            #Initialise columns to store sensitivity, specificity and
                            #accuracy of bagging at each run.
                            test.sens = NA,
                            test.spec = NA,
                            test.acc = NA)

# Bagging Tree Search function. Used to search for the best parameters.

bagging_search <- function(train_data, test_data, bagging_grid) {
  for (I in 1:nrow(bagging_grid)) {

    # Perform bagging on input dataset
    btree <- bagging(Class ~ .,
                     data = train_data,
                     nbagg = bagging_grid$nbagg[I],
                     coob = TRUE,
                     control = rpart.control(cp = bagging_grid$cp[I],
                                             minsplit = bagging_grid$minsplit[I]))

    # OOB misclassification rate
    bagging_grid$OOB.misclass[I] <- btree$err * 100

    # Make predictions on test dataset
    test_pred <- predict(btree, newdata = test_data, type = "class")


    # Create a confusion matrix and adjust class levels
    test_cf <- confusionMatrix(test_pred %>% relevel(ref = "NonMal"),
                               test_data$Class %>% relevel(ref = "NonMal"))
    prop_cf <- test_cf$table %>% prop.table(2)

    # Calculate sensitivity, specificity, and accuracy
    bagging_grid$test.sens[I] <- prop_cf[1, 1] * 100
    bagging_grid$test.spec[I] <- prop_cf[2, 2] * 100
    bagging_grid$test.acc[I] <- test_cf$overall[1] * 100
  }
  return(bagging_grid)
}

# Usage of bagging_search function
results_balanced <- bagging_search(mydata_b_train, mydata.test, bagging_grid)
results_unbalanced <- bagging_search(mydata.ub.train, mydata.test, bagging_grid)

# Order the results by OOB misclassification rate
oob_b <- results_balanced[order(results_balanced$OOB.misclass, decreasing = FALSE)[1:10], ] %>% round(2)
oob_ub <- results_unbalanced[order(results_unbalanced$OOB.misclass, decreasing = FALSE)[1:10], ] %>% round(2)

# assign the best model parameters.
best_model_params <- results_balanced[which.min(results_balanced$OOB.misclass), ]
best_model_params1 <- results_unbalanced[which.min(results_unbalanced$OOB.misclass), ]

# Run bagging using optimal hyperparameters.
bagging_model_b <- bagging(Class ~ .,
                           data = mydata_b_train,
                           nbagg = best_model_params$nbagg,
                           coob = TRUE,
                           control = rpart.control(cp = best_model_params$cp,
                                                   minsplit = best_model_params$minsplit))

bagging_model_ub <- bagging(Class ~ .,
                            data = mydata.ub.train,
                            nbagg = best_model_params1$nbagg,
                            coob = TRUE,
                            control = rpart.control(cp = best_model_params1$cp,
                                                    minsplit = best_model_params1$minsplit))

# Predictions and Confusion Matrices

# Lasso Predictions and releveling of the Class levels
pred_lasso_b <- predict(lasso_model_b, new = mydata.test)
cm_b_lasso <- table(pred_lasso_b %>% relevel(ref = "Mal"),
                    mydata.test$Class %>% relevel(ref = "Mal"))

pred_lasso_ub <- predict(lasso_model_ub, new = mydata.test)
cm_ub_lasso <- table(pred_lasso_ub %>% relevel(ref = "Mal"),
                     mydata.test$Class %>% relevel(ref = "Mal"))

# Bagging tree prediction and releveling of the Class levels
pred_tree_b <- predict(bagging_model_b, newdata = mydata.test, type = "class")
cm_b_tree <- table(pred_tree_b %>% relevel(ref = "Mal"),
                   mydata.test$Class %>% relevel(ref = "Mal"))

pred_tree_ub <- predict(bagging_model_ub, newdata = mydata.test, type = "class")
cm_ub_tree <- table(pred_tree_ub %>% relevel(ref = "Mal"),
                    mydata.test$Class %>% relevel(ref = "Mal"))

# Confusion Matrix for each model
cm_b_lasso <- confusionMatrix(cm_b_lasso)
cm_ub_lasso <- confusionMatrix(cm_ub_lasso)
cm_b_tree <- confusionMatrix(cm_b_tree)
cm_ub_tree <- confusionMatrix(cm_ub_tree)

# Calculate and print all results.

# Function to calculate fscore, fpr, fnr, precision, recall etc.
calculate_metrics <- function(cm, model_name) {
  tp <- cm$table[1, 1]
  fp <- cm$table[1, 2]
  fn <- cm$table[2, 1]
  tn <- cm$table[2, 2]

  fpr <- fp / (fp + tn)
  fnr <- fn / (fn + tp)
  precision <- tp / (tp + fp)
  recall <- tp / (tp + fn)
  f1_score <- 2 * ((precision * recall) / (precision + recall))

  cat("\n", model_name, "\n")
  print(cm)
  cat("False Positive Rate: ", fpr, "\n")
  cat("False Negative Rate: ", fnr, "\n")
  cat("Precision: ", precision, "\n")
  cat("Recall: ", recall, "\n")
  cat("F1-Score: ", f1_score, "\n")
}

# Class to the function to calculate metrics and prints the results.
calculate_metrics(cm_b_lasso, "== Lasso Model (Balanced) ==")
calculate_metrics(cm_ub_lasso, "== Lasso Model (UnBalanced) ==")
calculate_metrics(cm_b_tree, "== Tree Model (Balanced) ==")
calculate_metrics(cm_ub_tree, "== Tree Model (UnBalanced) ==")

# print lasso model best tune parameters
cat("== Lasso Model (Balanced) ==\n"); print(lasso_model_b$bestTune)
cat("== Lasso Model (UnBalanced) ==\n"); print(lasso_model_ub$bestTune)

# print lasso balanced lambda vs accuracy
cat("== Lasso Model (Balanced) ==\n"); print(lasso_model_b$results)
cat("== Lasso Model (UnBalanced) ==\n"); print(lasso_model_ub$results)

# plot lasso model accuracy
lasso_plot <- ggplot() +
  geom_line(data = lasso_model_b$results, aes(x = log(lambda), y = Accuracy, colour = "Balanced")) +
  geom_point(data = lasso_model_b$results, aes(x = log(lambda), y = Accuracy, colour = "Balanced")) +
  geom_line(data = lasso_model_ub$results, aes(x = log(lambda), y = Accuracy, colour = "UnBalanced")) +
  geom_point(data = lasso_model_ub$results, aes(x = log(lambda), y = Accuracy, colour = "UnBalanced")) +
  ggtitle("Lasso Model Accuracy") +
  xlab("Log Lambda") +
  ylab("Accuracy") +
  scale_color_manual(values = c("Balanced" = "blue", "UnBalanced" = "red")) +
  theme(legend.title = element_blank()) +
  coord_cartesian(xlim = c(-3, 1), ylim = c(0.95, 1.0))

# save the plot.
# ggsave("lasso_plot.png", plot = lasso_plot, width = 10, height = 8, dpi = 300)

# Print OOB sorted.
cat("Bagging OOB (Balanced)\n"); print(oob_b)
cat("Bagging OOB (UnBalanced)\n"); print(oob_ub)

# EOF
```