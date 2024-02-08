#

install.packages(c("tidyverse", "caret", "glmnet", "forcats", "rpart", "rpart.plot", "ipred", "e1071", "ggpubr"))

library(tidyverse) # data manipulation and visualization
library(caret) # classification and regression training
library(glmnet) # LASSO and Elastic-Net Regularized Generalized Linear Models
library(forcats) # for factor manipulation
library(rpart) # recursive partitioning and regression trees
library(rpart.plot) # plotting trees
library(ipred) # improved predictive models
library(e1071) # support vector machines
library(ggpubr) # ggplot2-based publication ready plots

# My working directory
setwd("C:/Users/drewc/OneDrive/Documents/J97 - Master of Cyber Security/CYB6009-Data-Analysis-and-Visualisation/Assignment 02")
getwd()

# Import the data
MLData2023 <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)
str(MLData2023)

## Part 1 - General data preparation and cleaning

# b) The main data issues are
# i) Invalid categories, i.e. "-" and " ", for IPV6.Traffic,
# ii) Invalid category, i.e. "-" for Operating.System,
# iii) invalid data entry of -1 (size cannot be negative) for Assembled.Payload.Size and
# iv) the invalid category of Operating.System is limited, and so it only applied to a few of you.
# Given that IPV6.Traffic has a significant proportion of invalid values, this feature should be "removed" from the dataset for Assessment 2.

# Remove IPv6.Traffic feature. It has a large proportion of invalid or bad data, advised to remove it from the data set.
MLData2023 <- MLData2023 %>% select(-IPV6.Traffic)

# Remove -1 values in Assembly.Payload.Size feature and replace with NA
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
set.seed(10215233)
rows.train0 <- sample(1:nrow(dat.class0), size = 19800, replace = FALSE)
rows.train1 <- sample(1:nrow(dat.class1), size = 200, replace = FALSE)
# Your 20000 unbalanced training samples
train.class0 <- dat.class0[rows.train0,] # Non-malicious samples
train.class1 <- dat.class1[rows.train1,] # Malicious samples
mydata.ub.train <- rbind(train.class0, train.class1)
mydata.ub.train <- mydata.ub.train %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))
# Your 39600 balanced training samples, i.e. 19800 non-malicious and malicious samples each.
set.seed(123)
train.class1_2 <- train.class1[sample(1:nrow(train.class1), size = 19800,
                               replace = TRUE),]
mydata.b.train <- rbind(train.class0, train.class1_2)
mydata.b.train <- mydata.b.train %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))
# Your testing samples
test.class0 <- dat.class0[-rows.train0, ]
test.class1 <- dat.class1[-rows.train1, ]
mydata.test <- rbind(test.class0, test.class1)
mydata.test <- mydata.test %>%
  mutate(Class = factor(Class, labels = c("NonMal", "Mal")))

# datasets
# Unbalanced training dataset (mydata.ub.train)
# Balanced training dataset (mydata.b.train)
# Testing dataset (mydata.test)

str(mydata.ub.train)
str(mydata.b.train)
str(mydata.test)

## Part 2 - Compare the performances of different ML Algorithms

set.seed(10215233)
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
