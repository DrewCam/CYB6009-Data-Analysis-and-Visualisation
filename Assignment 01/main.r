# Data preparation and visualisation
# Data exploration and preparation.
# Goals:
# 1. Perform some basic exploratory data analysis.
# 2. Clean the file and prepare it for Machine Learning (ML).
# 3. Perform an initial Principal Component Analysis (PCA) of the data.
# 4. Identify features that may be useful for ML algorithms.
# 5. Create a brief report to the rest of the research team on your findings.

#A1 Main

#De-comment to install the packages below
install.packages(c("tidyverse", "moments", "ggpubr", "vegan", "factoextra", "e1071"))
library(tidyverse)
library(moments)
library(ggpubr)
library(vegan)
library(factoextra)
#library(e1071)

#--------------------------------------------------------------------------------------------------------------------#

### Part 1 – Create data sub-sample
# Import Data and get sub-sample.

# My working directory
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

#--------------------------------------------------------------------------------------------------------------------#

### Part 2 – Explore the Data

## (i) For each of your categorical or binary variables, determine the number (%) of instances for each of their categories and summarise them in a table

# Create a vector to hold Categorical features
categorical_features <- c("Operating.System",
                          "Connection.State",
                          "IPV6.Traffic",
                          "Ingress.Router",
                          "Class")

# loop through the categorical features and generate summary data frames
categorical_summary <- lapply(categorical_features, function(var) {
  mydata %>%
    group_by(!!sym(var)) %>%
    summarize(Count = n()) %>%
    mutate(Percentage = paste0(round(Count / sum(Count) * 100, 1), "%")) %>%
    mutate(Category = ifelse(is.na(!!sym(var)), "Missing", as.character(!!sym(var)))) %>%
    mutate(Feature = var) %>%
    select(Feature, Category, Count, Percentage)
})

categorical_output <- do.call(rbind, categorical_summary) # combine to an output variable.
print(categorical_output) # Print summary to the console.

# # A tibble: 16 x 4
#    Feature          Category            Count Percentage
#    <chr>            <chr>               <int> <chr>
#  1 Operating.System "Android"             238 39.7%
#  2 Operating.System "iOS"                  40 6.7%
#  3 Operating.System "Windows (Unknown)"   264 44%
#  4 Operating.System "Windows 10+"           4 0.7%
#  5 Operating.System "Windows 7"            54 9%
#  6 Connection.State "ESTABLISHED"         397 66.2%
#  7 Connection.State "INVALID"             177 29.5%
#  8 Connection.State "NEW"                  13 2.2%
#  9 Connection.State "RELATED"              13 2.2%
# 10 IPV6.Traffic     "-"                   151 25.2%
# 11 IPV6.Traffic     " "                    53 8.8%
# 12 IPV6.Traffic     "FALSE"               396 66%
# 13 Ingress.Router   "mel-aus-01"          365 60.8%
# 14 Ingress.Router   "syd-tls-04"          235 39.2%
# 15 Class            "0"                   300 50%
# 16 Class            "1"                   300 50%

# (ii) Summarise each of your continuous/numeric variables in a table in your report as follows.
# State all values, except N, to 2 decimal places.

continuous_features <- c("Assembled.Payload.Size",
                         "DYNRiskA.Score",
                         "Response.Size",
                         "Source.Ping.Time",
                         "Connection.Rate",
                         "Server.Response.Packet.Time",
                         "Packet.Size",
                         "Packet.TTL",
                         "Source.IP.Concurrent.Connection")

summary(mydata[, continuous_features]) # Print summary to the console.

#Calculate summary data from each feature.
missing_count <- colSums(is.na(mydata[, continuous_features])) # Get the number of missing values
missing_pct <- round(colMeans(is.na(mydata[, continuous_features])) * 100, 2) # Get percentage of missing rounded to 2 decimal places
min_values <- round(sapply(mydata[, continuous_features], min, na.rm = TRUE), 2) # Minimum to 2 decimal places.
max_values <- round(sapply(mydata[, continuous_features], max, na.rm = TRUE), 2) # Max to 2 decimal places.
mean_values <- round(sapply(mydata[, continuous_features], mean, na.rm = TRUE), 2) # Mean to to 2 decimal places.
median_values <- round(sapply(mydata[, continuous_features], median, na.rm = TRUE), 2) # Median to 2 decimal places.
skew_values <- round(sapply(mydata[, continuous_features], skewness, na.rm = TRUE), 2) # Skewness to to 2 decimal places.

# Combine all the results into a data frame
continuous_output <- data.frame(Feature = continuous_features,
                                Missing = missing_count,
                                MissingPct = missing_pct,
                                Min = min_values,
                                Max = max_values,
                                Mean = mean_values,
                                Median = median_values,
                                Skewness = skew_values)

# Print output to the console.
print(continuous_output)

#                                                         Feature Missing MissingPct      Min       Max      Mean    Median Skewness
# Assembled.Payload.Size                   Assembled.Payload.Size       0          0    -1.00  80580.00  48476.33  49268.50    -0.28
# DYNRiskA.Score                                   DYNRiskA.Score       0          0     0.19      0.92      0.61      0.63    -0.57
# Response.Size                                     Response.Size       0          0 76495.00 822051.00 492667.72 492937.00    -0.06
# Source.Ping.Time                               Source.Ping.Time       0          0   119.00    415.00    267.75    267.00    -0.04
# Connection.Rate                                 Connection.Rate       0          0     0.02   1821.42    432.24    399.72     0.95
# Server.Response.Packet.Time         Server.Response.Packet.Time       0          0    75.00    417.00    226.75    221.00     0.23
# Packet.Size                                         Packet.Size       0          0  1260.00   1439.00   1349.68   1348.00     0.05
# Packet.TTL                                           Packet.TTL       0          0    32.00    108.00     63.98     63.00     0.19
# Source.IP.Concurrent.Connection Source.IP.Concurrent.Connection       0          0     9.00     34.00     21.37     21.50    -0.03

# (iii) Examine the results in sub-parts (i) and (ii). Are there any invalid categories/values for the categorical variables?
# Is there any evidence of outliers for any of the continuous/numeric variables?
# If so, how many and what percentage are there? Include your answers in your report.


# Count the number of -1 values in Assembly.Payload.Size
sum(mydata$Assembled.Payload.Size == -1)
# == 7

### Outlier Detection using +/- 4 Standard Deviations

# Initialize an empty list to store the indices of the outliers
outliers_indices <- list()

# Print or return the list of outlier indices for each continuous feature
print(outliers_indices)

for (feature in continuous_features) {
  # Check if the feature exists in the dataset
  if (!feature %in% names(mydata)) {
    next  # Skip to the next feature if the current one is not found
  }

  # Calculate the mean and standard deviation for the feature
  mean_val <- mean(mydata[[feature]], na.rm = TRUE)
  sd_val <- sd(mydata[[feature]], na.rm = TRUE)

  # Calculate the upper and lower bounds
  upper_bound <- mean_val + 4 * sd_val
  lower_bound <- mean_val - 4 * sd_val

  # Identify outliers
  outliers <- which(mydata[[feature]] > upper_bound | mydata[[feature]] < lower_bound)

  # Store the indices of outliers in the list
  outliers_indices[[feature]] <- outliers

}

# Print the list of outlier indices
print(outliers_indices)

# $Assembled.Payload.Size
# integer(0)
#
# $DYNRiskA.Score integer(0)
#
# $Response.Size [1] 573 1 Outlier.
# $Source.Ping.Time integer(0)
# $Connection.Rate [1] 488 600 2 Outliers.
# $Server.Response.Packet.Time integer(0)
# $Packet.Size integer(0)
# $Packet.TTL [1] 579 1 Outlier.
# $Source.IP.Concurrent.Connection integer(0)

# Function to create histograms for continuous features.

histogram = function(df, feature) {
  ggplot(df, aes(x = !!sym(feature))) +
    geom_histogram(bins = 30, fill = "black", color = "white") +
    labs(x = feature, y = "Frequency", title = paste0(feature," Histogram")) +
    theme_minimal()
}
# Loop through each print and save the plot.
for (feature in continuous_features) {
  print(histogram(mydata, feature))
}

for (feature in continuous_features) {
  # Create the plot
  p <- histogram(mydata, feature)

  # Print the plot
  print(p)

  # Save the plot as a PNG file with a unique filename
  ggsave(filename = paste0("histogram_", feature, ".png"), plot = p, width = 10, height = 7, units = "in")
}

### Part 3 – Clean the Data, Perform PCA and Visualise the Data

# (i) Now clean your data. For all the observations that you have deemed to be invalid/outliers in Part 1 (iii)
# mask them by replacing them with NAs using the replace(.) command in R.

mydata_clean <- mydata

# Replace -1 values in Assembly.Payload.Size with NA

mydata$Assembled.Payload.Size[mydata$Assembled.Payload.Size == -1] <- NA

# Replace outliers with NA for all continuous features and save as mydata_clean

for (feature in continuous_features) {
  # Check if the feature exists in the dataset
  if (!feature %in% names(mydata_clean)) {
    next  # Skip to the next feature if the current one is not found
  }

  # Replace outliers with NA
  mydata_clean[[feature]][outliers_indices[[feature]]] <- NA
}

# Check the number of NAs in each feature

colSums(is.na(mydata_clean))
colSums(is.na(mydata))


# (ii) Export your “cleaned” data as follows. This file will need to be submitted along with your report.

#Write to a csv file.
write.csv(mydata,"mydata.csv")

# (iii) Extract only the data for the numeric features in mydata, along with Class, and store them as a separate data frame/tibble

# Create a new data frame with numeric features and 'Class'
numeric_class_data = mydata %>%
  select_if(is.numeric) %>%
  mutate(Class = mydata$Class)
view(numeric_class_data)

# Filter NAs.
numeric_class_clean = na.omit(numeric_class_data)

# Then, filter the incomplete cases (i.e. any rows with NAs) and perform PCA using prcomp(.) in R, but only on the numeric features (i.e. exclude Class). 

# Include answers to the following in your report:
# Outline why you believe the data should or should not be scaled, i.e. standardised, when performing PCA.
# Outline the individual and cumulative proportions of variance (3 decimal places) explained by each of the first 4 components.
# Outline how many principal components (PCs) are adequate to explain at least 50% of the variability in your data.
# Outline the coefficients (or loadings) to 3 decimal places for PC1, PC2 and PC3, and describe which features (based on the loadings) are the key drivers for each of these three PCs.

# (iv) Create a biplot for PC1 vs PC2 to help visualise the results of your PCA in the first two dimensions.
# Colour code the points with the variable Class. Write a paragraph to explain what your biplots are showing.
# That is, comment on the PCA plot, the loading plot individually, and then both plots combined 
# (see Slides 28-29 of Module 3 notes) and outline and justify which (if any) of the features can help to distinguish Malicious events.

# PC1 vs PC2

fviz_pca_biplot(pca.mydata,
                axes = c(1, 2),
                col.ind=mydata$Class,
                fill.ind = mydata$Class,
                alpha=0.5,
                pointsize=4,
                pointshape=21,
                col.var="red",
                label = "var",
                repel = TRUE,
                addEllipses = TRUE,
                legend.title=list(colour="Class", fill="Class", alpha="Class"))

# PC1 vs PC3

fviz_pca_biplot(pca.mydata,
                axes = c(1, 3),
                col.ind=mydata$Class,
                fill.ind = mydata$Class,
                alpha=0.5,
                pointsize=4,
                pointshape=21,
                col.var="red",
                label = "var",
                repel = TRUE,
                addEllipses = TRUE,
                legend.title=list(colour="Class", fill="Class", alpha="Class"))

# PC2 vs PC3

fviz_pca_biplot(pca.mydata,
                axes = c(2, 3),
                col.ind=mydata$Class,
                fill.ind = mydata$Class,
                alpha=0.5,
                pointsize=4,
                pointshape=21,
                col.var="red",
                label = "var",
                repel = TRUE,
                addEllipses = TRUE,
                legend.title=list(colour="Class", fill="Class", alpha="Class"))

# (v) Based on the results from parts (iii) to (iv), describe which dimension (choose just one) can assist with the identification of Malicious events (Hint: project all the points in the PCA plot to PC1 axis and see whether there is good separation between the points for Malicious and Non-Malicious events. Then project to PC2 axis and see if there is separation between Malicious and Non-Malicious events, and whether it is better than the projection to PC1).


