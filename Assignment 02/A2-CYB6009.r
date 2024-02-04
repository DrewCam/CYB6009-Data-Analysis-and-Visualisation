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
