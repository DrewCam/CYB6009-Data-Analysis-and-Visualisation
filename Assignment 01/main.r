# Data exploration and preparation.
# Goals:
# 1. Perform some basic exploratory data analysis.
# 2. Clean the file and prepare it for Machine Learning (ML).
# 3. Perform an initial Principal Component Analysis (PCA) of the data.
# 4. Identify features that may be useful for ML algorithms.
# 5. Create a brief report to the rest of the research team on your findings.

#A1 Main

#De-comment to install the packages below
#install.packages(c("tidyverse","moments","ggpubr","vegan","factoextra",""))
library(tidyverse)
library(moments)
library(ggpubr)
library(vegan)
library(factoextra)

####--------------------------------------------------------------------------------------------------------------------
# Import Data and get sub-sample.
#Setting Seed
#My working directory
setwd("C:/Users/drewc/OneDrive/Documents/J97 - Master of Cyber Security/CYB6009-Data-Analysis-and-Visualisation/Assignment 01")
getwd()


# You may need to change/include the path of your working directory
dat <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)

# Separate samples of non-malicious and malicious events
dat.class0 <- dat %>% filter(Class == 0) # non-malicious
dat.class1 <- dat %>% filter(Class == 1) # malicious

# Randomly select 300 samples from each class, then combine them to form a working dataset
set.seed(10215233)
rand.class0 <- dat.class0[sample(1:nrow(dat.class0), size = 300, replace = FALSE),]
rand.class1 <- dat.class1[sample(1:nrow(dat.class1), size = 300, replace = FALSE),]

# Your sub-sample of 600 observations
mydata <- rbind(rand.class0, rand.class1)

dim(mydata)  # Check the dimension of your sub-sample

### Part 1 – Exploratory Data Analysis and Data Cleaning

## (i) For each of the categorical or binary variables determine the number (%) of instances for each of their categories.

# Create a vector to hold Categorical features
categorical_features = c("Operating.System", 
                         "Connection.State", 
                         "IPV6.Traffic", 
                         "Ingress.Router", 
                         "Class")

# loop through the categorical features and generate summary data frames
categorical_summary = lapply(categorical_features, function(var) {
  mydata %>%
    group_by(!!sym(var)) %>%
    summarize(Count = n()) %>%
    mutate(Percentage = paste0(round(Count / sum(Count) * 100, 1), "%")) %>%
    mutate(Category = ifelse(is.na(!!sym(var)), "Missing", as.character(!!sym(var)))) %>%
    mutate(Feature = var) %>%
    select(Feature, Category, Count, Percentage)
})

categorical_output = do.call(rbind, categorical_summary) # combine to an output variable.
print(categorical_output) # Print summary to the console.


##(ii) Summarise each of your continuous/numeric variables in a table as follows. State all values to 2 decimal places.
# Create a vector to hold continuous features
continuous_features = c("Assembled.Payload.Size",
                     "DYNRiskA.Score",
                     "Response.Size",
                     "Source.Ping.Time",
                     "Connection.Rate",
                     "Server.Response.Packet.Time",
                     "Packet.Size",
                     "Packet.TTL",
                     "Source.IP.Concurrent.Connection")

#Calculate summary data from each feature.
missing_count = colSums(is.na(mydata[, continuous_features])) # Get the number of missing values
missing_pct = round(colMeans(is.na(mydata[, continuous_features])) * 100, 2) # Get percentage of missing rounded to 2 decimal places 
min_values = round(sapply(mydata[, continuous_features], min, na.rm = TRUE), 2) # Minimum to 2 decimal places. 
max_values = round(sapply(mydata[, continuous_features], max, na.rm = TRUE), 2) # Max to 2 decimal places. 
mean_values = round(sapply(mydata[, continuous_features], mean, na.rm = TRUE), 2) # Mean to to 2 decimal places.
median_values = round(sapply(mydata[, continuous_features], median, na.rm = TRUE), 2) # Median to 2 decimal places.
skew_values = round(sapply(mydata[, continuous_features], skewness, na.rm = TRUE), 2) # Skewness to to 2 decimal places.

# Combine all the results into a data frame
continuous_output = data.frame(
  Feature = continuous_features,
  Missing = missing_count,
  MissingPct = missing_pct,
  Min = min_values,
  Max = max_values,
  Mean = mean_values,
  Median = median_values,
  Skewness = skew_values)

# Print output to the console. 
print(continuous_output)

### Identifying Outliers using Histograms
# Function to create histograms for continuous features. 
histogram = function(df, feature) {
  ggplot(df, aes(x = !!sym(feature))) +
    geom_histogram(bins = 30, fill = "black", color = "white") +
    labs(x = feature, y = "Frequency", title = paste0(feature," Histogram")) +
    theme_minimal()
}
# Loop through each print and save the plot. 
#for (feature in continuous_features) {
#  print(histogram(mydata, feature))
#}

for (feature in continuous_features) {
  # Create the plot
  p = histogram(mydata, feature)
  
  # Print the plot
  print(p)
  
  # Save the plot as a PNG file with a unique filename
  ggsave(filename = paste0("histogram_", feature, ".png"), plot = p, width = 10, height = 7, units = "in")
}