#

install.packages(c("tidyverse", "caret", "glmnet", "forcats", "rpart", "rpart.plot", "ipred", "e1071", "ggpubr"))

library(tidyverse)
library(caret)
library(glmnet)
library(forcats)
library(rpart)
library(rpart.plot)
library(ipred) #
library(e1071)
library(ggpubr)

# My working directory
setwd("C:/Users/drewc/OneDrive/Documents/J97 - Master of Cyber Security/CYB6009-Data-Analysis-and-Visualisation/Assignment 02")
getwd()

# Import the data
MLData2023 <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)
str(MLData2023)

# Clean the dataset.

# b) The main data issues are
# i) Invalid categories, i.e. "-" and " ", for IPV6.Traffic,
# ii) Invalid category, i.e. "-" for Operating.System,
# iii) invalid data entry of -1 (size cannot be negative) for Assembled.Payload.Size and
# iv) the invalid category of Operating.System is limited, and so it only applied to a few of you.
#Given that IPV6.Traffic has a significant proportion of invalid values, this feature should be "removed" from the dataset for Assessment 2.


