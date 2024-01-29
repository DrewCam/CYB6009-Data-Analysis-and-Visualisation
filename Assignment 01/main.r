# Assignment 01 - Data preparation and visualisation
#   Goals:
#   1. Perform some basic exploratory data analysis.
#   2. Clean the file and prepare it for Machine Learning (ML).
#   3. Perform an initial Principal Component Analysis (PCA) of the data.
#   4. Identify features that may be useful for ML algorithms.
#   5. Create a brief report to the rest of the research team on your findings.

#De-comment to install the packages below
install.packages(c("tidyverse", "moments", "ggpubr", "factoextra"))
library(tidyverse) # Data manipulation and visualization.
library(moments) # Descriptive statistics, kurtosis and skewness.
library(ggpubr) # ggplot2-based publication ready plots.
library(factoextra) # visualize the output of multivariate data analyses, including 'PCA' (Principal Component Analysis)

###############################################################
### Part 1 – Create data sub-sample
###############################################################

# Import Data and get sub-sample.

# My working directory
setwd("C:/Users/drewc/OneDrive/Documents/J97 - Master of Cyber Security/CYB6009-Data-Analysis-and-Visualisation/Assignment 01")
getwd()

# You may need to change/include the path of your working directory
dat <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)

# Separate samples of non-malicious and malicious events
dat.class0 <- dat %>% filter(Class == 0) # non-malicious # nolint: object_name_linter.
dat.class1 <- dat %>% filter(Class == 1) # malicious # nolint: object_name_linter.

# Randomly select 300 samples from each class, then combine them to form a working dataset
set.seed(10215233)
rand.class0 <- dat.class0[sample(1:nrow(dat.class0), size = 300, replace = FALSE),] # nolint
rand.class1 <- dat.class1[sample(1:nrow(dat.class1), size = 300, replace = FALSE),] # nolint: object_name_linter, commas_linter.

# Your sub-sample of 600 observations
mydata <- rbind(rand.class0, rand.class1)

dim(mydata)  # Check the dimension of your sub-sample

###############################################################
### Part 2 – Explore the Data
###############################################################


### (i) Categorical & Binary features

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

### (ii) Continuous/Numeric features

# Create a vector to hold Continuous features
continuous_features <- c("Assembled.Payload.Size",
                         "DYNRiskA.Score",
                         "Response.Size",
                         "Source.Ping.Time",
                         "Connection.Rate",
                         "Server.Response.Packet.Time",
                         "Packet.Size",
                         "Packet.TTL",
                         "Source.IP.Concurrent.Connection")

#Calculate summary data from each feature.
missing_count <- colSums(is.na(mydata[, continuous_features])) # Get the number of missing values
missing_pct <- round(colMeans(is.na(mydata[, continuous_features])) * 100, 2) # Get % of missing rounded to 2 decimal places
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

# Confirm the number of -1 values in Assembled.Payload.Size feature
sum(mydata$Assembled.Payload.Size == -1)

### (iii) Outlier detection

# Initialize an empty list to store the indices of the outliers
outliers_indices <- list()

# Loop for Outlier Detection using +/- 4 Standard Deviations
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

# Histograms for features with outliers.

# Plot Histogram for Assembly.Payload.Size
aps_plot <- ggplot(mydata, aes(x = Assembled.Payload.Size)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(x = "Assembly.Payload.Size", y = "Count") +
  theme_bw()

# Histogram for Response.Size

rs_plot <- ggplot(mydata, aes(x = Response.Size)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(x = "Response.Size", y = "Count") +
  theme_bw()

# Histogram for Connection.Rate

cr_plot <- ggplot(mydata, aes(x = Connection.Rate)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(x = "Connection.Rate", y = "Count") +
  theme_bw()

# Histogram for Packet.TTL

pttl_plot <- ggplot(mydata, aes(x = Packet.TTL)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "white") +
  labs(x = "Packet.TTL", y = "Count") +
  theme_bw()

# Save the plots as PNG files with a unique filename
ggsave(filename = "histogram_Assembly.Payload.Size.png", plot = aps_plot, width = 10, height = 7, units = "in")
ggsave(filename = "histogram_Response.Size.png", plot = rs_plot, width = 10, height = 7, units = "in")
ggsave(filename = "histogram_Connection.Rate.png", plot = cr_plot, width = 10, height = 7, units = "in")
ggsave(filename = "histogram_Packet.TTL.png", plot = pttl_plot, width = 10, height = 7, units = "in")


###############################################################
### Part 3 – Clean the Data, Perform PCA and Visualise the Data
###############################################################

### (i) Clean the data

# Replace outliers with NA for all continuous features and save as mydata

for (feature in continuous_features) {
  # Check if the feature exists in the dataset
  if (!feature %in% names(mydata)) {
    next  # Skip to the next feature if the current one is not found
  }

  # Replace outliers with NA
  mydata[[feature]][outliers_indices[[feature]]] <- NA
}

# Remove IPv6.Traffic feature. It has a large proportion of invalid or bad data.
mydata <- mydata %>% select(-IPV6.Traffic)

# Remove -1 values in Assembly.Payload.Size feature and replace with NA
mydata <- mydata %>%
  mutate(Assembled.Payload.Size = replace(Assembled.Payload.Size, Assembled.Payload.Size == -1, NA))

# Merge Operating.System categories Windows 7, Windows 10+, Windows (Unknown) in to one category called Windows_OS
mydata$Operating.System <- fct_collapse(mydata$Operating.System,
                                        Windows_OS = c("Windows 7", "Windows 10+", "Windows (Unknown)"))

# Merge Connection.State categories INVALID, NEW and RELATED to form a new category called Others.
# Simplifying the data and identifying where connections are established.
mydata$Connection.State <- fct_collapse(mydata$Connection.State,
                                        Others = c("INVALID", "NEW", "RELATED"))

# (ii) Export your “cleaned” data as follows.
write.csv(mydata, "mydata_clean.csv") #Write to a csv file.


### Principal Component Analysis (PCA)

### (iii) extract numeric features and 'Class'
numeric_class_data <- mydata %>%
  select_if(is.numeric) %>%
  mutate(Class = mydata$Class)

# filter the incomplete cases (NAs)
numeric_class_clean <- na.omit(numeric_class_data)

str(numeric_class_clean)

# Perform PCA with prcomp excluding the 9th column (Class) from the PCA analysis
pca_numeric <- prcomp(numeric_class_clean[, 1:9], scale = TRUE)
summary(pca_numeric)

# Get Loadings from PCA
pca_numeric$rotation[, 1:3]

# Convert Class variable to factor
numeric_class_clean$Class <- factor(numeric_class_clean$Class, levels = c(0, 1))

#Plot PCA
plot_pca <- data.frame(pca_numeric$x, #PCA scores
                       Class = numeric_class_clean$Class)
ggplot(df, aes(x = PC1, y = PC2)) +
  geom_point(aes(colour = Class), alpha = 0.8, size = 4) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "right") +
  xlab("PC1") +
  ylab("PC2")

### (iv) Plot Biplot
biplot_pca <- fviz_pca_biplot(pca_numeric,
                              axes = c(1, 2),
                              col.ind = numeric_class_clean$Class,
                              fill.ind = numeric_class_clean$Class,
                              alpha = 0.5,
                              pointsize = 4,
                              pointshape = 21,
                              col.var = "black",
                              label = "var",
                              repel = TRUE,
                              addEllipses = TRUE,
                              legend.title = list(colour = "Class", fill = "Class", alpha = "Class")) +
  scale_fill_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious")) +
  scale_color_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious")) +
  labs(x = "Principal Component 1", y = "Principal Component 2")

# View the plot
biplot_pca

### (v) Choose a dimension that can assist with identifying malicious events.

# (v) Density plot for PC1
density_pc1 <- ggplot(df, aes(x = PC1, fill = Class)) +
  geom_density(alpha = 0.5) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "right") +
  xlab("PC1") +
  ylab("Density") +
  scale_fill_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious")) +
  scale_color_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious"))

# View the plot
density_pc1

# (v) Density plot for PC2

density_pc2 <- ggplot(df, aes(x = PC2, fill = Class)) +
  geom_density(alpha = 0.5) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "right") +
  xlab("PC2") +
  ylab("Density") +
  scale_fill_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious")) +
  scale_color_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious"))

# View the plot
density_pc2

# Density plot for PC3

density_pc3 <- ggplot(df, aes(x = PC3, fill = Class)) +
  geom_density(alpha = 0.5) +
  theme_minimal(base_size = 14) +
  theme(legend.position = "right") +
  xlab("PC3") +
  ylab("Density") +
  scale_fill_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious")) +
  scale_color_manual(values = c("green", "red"), labels = c("Non-Malicious", "Malicious"))

# View the plot
density_pc3

# Save the plot as a PNG file with a unique filename
ggsave(filename = "density_plot_PC3.png", plot = density_pc3, width = 10, height = 7, units = "in")

# EOF