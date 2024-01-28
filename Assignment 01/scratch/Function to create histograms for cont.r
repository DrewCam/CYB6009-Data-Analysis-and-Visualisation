# Function to create histograms for continuous features.

histogram <- function(df, feature) {
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
