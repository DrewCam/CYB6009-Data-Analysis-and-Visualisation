# Outliers z-scores

outliers <- apply(mydata[, continuous_features, drop = FALSE], 2, function(x) abs((x - mean(x)) / sd(x)) > 4)

# print the feature name, the outlier count, the percentage of outliers and the number of missing values and what the outlier was.
for (i in 1:length(continuous_features)) {
  print(paste0(continuous_features[i], ": ", colSums(outliers)[i], " (", round(colSums(outliers)[i] / nrow(mydata) * 100, 2), "%)"))
  print(mydata[outliers[, i], continuous_features[i]])
}