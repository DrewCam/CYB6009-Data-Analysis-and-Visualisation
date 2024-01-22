# NumericFeatureSummary.R
# This script generates a summary table for each numerical feature in the dataset 'mydata'.
# The summary includes count, missing values, minimum, maximum, mean, median, and skewness.

# List of numerical features in the dataset
num_features <- c("Assembled.Payload.Size", "DYNRiskA.Score", "Response.Size", 
                  "Source.Ping.Time", "Connection.State", "Server.Response.Packet.Time", 
                  "Packet.Size", "Packet.TTL", "Source.IP.Concurrent.Connection")

# Loop through each feature and calculate summary statistics
for (feature in num_features) {
  # Check if the feature is numeric
  if (is.numeric(mydata[[feature]])) {
    # Basic statistics
    n <- length(mydata[[feature]])
    missing <- sum(is.na(mydata[[feature]]))

    # Summary values calculation with handling of infinite and NA values
    min_val <- min(mydata[[feature]], na.rm = TRUE)
    max_val <- max(mydata[[feature]], na.rm = TRUE)
    mean_val <- mean(mydata[[feature]], na.rm = TRUE)
    median_val <- median(mydata[[feature]], na.rm = TRUE)
    skewness_val <- e1071::skewness(mydata[[feature]], na.rm = TRUE)
    
    # Creating a summary table for the current feature
    summary_table <- data.frame(
      Feature = feature,
      `Number (%)` = paste0(n, " (100.0%)"),
      Missing = paste0(missing, " (", round(missing/n*100, 1), "%)"),
      Min = ifelse(is.infinite(min_val), "NA", sprintf("%.2f", min_val)),
      Max = ifelse(is.infinite(max_val), "NA", sprintf("%.2f", max_val)),
      Mean = ifelse(is.na(mean_val), "NA", sprintf("%.2f", mean_val)),
      Median = ifelse(is.na(median_val), "NA", sprintf("%.2f", median_val)),
      Skewness = ifelse(is.na(skewness_val), "NA", sprintf("%.2f", skewness_val))
    )
    
    # Print the summary table to the console
    print(summary_table)
    cat("\n")  # Print a newline for better readability
    flush.console()  # Ensure that the output is displayed in the console immediately
  }
}
