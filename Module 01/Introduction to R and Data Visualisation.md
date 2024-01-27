# Introduction to R and Data Visualisation

## 1.1 Introduction to machine learning

### What is machine learning?

- A set of tools and methods that attempt to extract insights from a record of the observable world and infer patterns in data.

- Studying and understanding a phenomenon.
  - Make observations and collect relevant data.
  - Model the underlying patterns.
  - Use the model to inform our understanding of the phenomenon.
  - Make predictions.

- An important feature of any ML method is its ability to learn and improve with experience, i.e. both exsiting and new data.

- ML attempts to answer:
  - How does learning performance vary with the number of training examples?
  - Which learning algorithms are most appropriate for various types of learning tasks?

- ML draws on concepts and results from:
  - Statistics
  - Artificial intelligence
  - Philosophy
  - Information theory
  - Biology
  - Cognitive science
  - Control theory

Book reference: [[An Introduction to Statistical Learning with Applications in R]]

![Machine Learning](image-1.png)

This unit focuses on Supervised and Unsupervised learning.

### Supervised learning

- The goal is to predict or estimate an output based on one or more inputs.
- The training data consists of a set of inputs and outputs.
- The goal is to learn a function that maps inputs to outputs.
- The function is learned from the training data.
- The function is then used to predict outputs for new inputs.
- The function is evaluated on a test set of inputs and outputs.

- Infers a function that maps set of inputs (features, predictors, covariates, independent variables) to an output (response, target, outcome, dependent variable) from input/output pairs.

- The function is inferred from training examples, which are mapped to new examples.

- Goals:

  - Accurately predict unseen cases, i.e test cases (primary)
  - Understand the relationship between inputs and outputs (secondary)

- Two sub-categories:

  - Regression: a continuous outcome
  - Classification: a categorical/qualitive outcome

### Unsupervised learning

- No distinction between inputs and outputs within a data set.
- Attempts to uncover the underlying structure or pattern within a data set.
- Can lead to testable hypothesis.
- Difficult to know how well you have done.
- Two sub-categories:
  - Clustering: group similar observations together. grouping of objects based on some similarity measure.
  - Dimension reduction: reduce the number of variables. Visualisation of multidimensional data in lower dimensions, 2-D and 3-D.

## 1.2 Introduction to data analytics

### Analysis vs Analytics?

- Analysis: the process of breaking a complex topic or substance into smaller parts to gain a better understanding of it.
- Analytics: the systematic computational analysis of data or statistics.

### What is statistics?

- statistics allow us to learn from our data by:
  - summarising the data
  - extracting patterns
  - drawing inferences
  - making predictions

- data are numbers with context.
- data contains information about some group of individuals or objects.
- A characteristic of an individual or object is called a variable.

### Data Types

Two main types of variables:

- Qualitative (categorical)
  - Nominal: no natural ordering - charateristics have no order, e.g. eye colour, gender.
  - Ordinal: natural ordering - charateristics are intrinsically ordered, e.g. education level (primary, secondary, tertiary).

- Quantitative (numerical)
  - Discrete: countable, e.g. number of children in a family. Able to take only certain distinct values within an allowable range. The alloweable range maybe finite or infinite. For example, outcome of a dice roll, number of students in a class.
  - Continuous: data measured on a scale, able to take on any values within an allowable range. which maybe finite or infinite. For example, height, weight, time, temperature.

### Exploratory Data Analysis (EDA)

- EDA is an approach to analysing data sets to summarise their main characteristics, often with visual methods.
- It is the process of describing the data and summarising the main characteristics of the data.
- Provides some insight into the behaviour of the data.
- A critical aspect of EDA is outlier detection.
- Describe graphically and numerically.

Goal is to summarise the main points of the data. how is it behaving? what is the distribution? what is the spread? what is the centre? what is the shape?.

- Graphical methods:
  - Histograms
  - Boxplots
  - Scatterplots
  - QQ plots
- Numerical methods:
  - Mean
  - Median
  - Standard deviation
  - Quantiles

### Descibing Qualitative and Discrete Data

- Qualitative and discrete (finite) data are typically expressed as count data.
- For a better perspective, counts are often expressed as proportions or percentages of the total.

|Education Level     |Count |Percent|
|--------------------|------|-------|
|Below high School   |4600  |15.33% |
|High school graduate|120000|40.00% |
|TAFE Degree         |75000 |25.00% |
|Bachelor's Degree   |50000 |16.67% |
|Post-graduate Degree|9000  |3.00%  |
|Total               |300000|100.00%|

### Describing Quantitative Data

Three Aspects are addressed

- Measures of centre: describes how data cluster around a particular value.
- Measures of spread: describes the dispeersion/variability of the data.
- Measure of shape: describes the shape of the distribution (or pattern) of the data. symmetric, skewed, bimodal, uniform. etc.

### Measure of Centre

mean - average value of the data.

- formula: $\bar{x} = \frac{1}{n} \sum_{i=1}^{n} x_i$

median (M) - middle score in the ordered data set.

- formula: $M = \frac{n+1}{2}$

mode - most frequent value in the data set. (discrete and qualitative data).

- formula: $mode = \underset{x}{\operatorname{argmax}} \sum_{i=1}^{n} I(x_i = x)$

### Measure of Spread (Variability)

variance - measures how spread out the data points are from their mean.

formula: $s^2 = \frac{1}{n-1} \sum_{i=1}^{n} (x_i - \bar{x})^2$

standard deviation (s) - is the average offset of each data point from its mean. it is calculated as the square root of variance. it is the most commonly used measure of spread.

formula: $s = \sqrt{\frac{1}{n-1} \sum_{i=1}^{n} (x_i - \bar{x})^2}$

![Example](CYB6009-Data-Analysis-and-Visualisation/Module%2001/attachments/image.png)

Mean = 33.98667
sd(BMI) = 7.88673

|BMI|Classification|
|---|--------------|
|18.5 - 24.9|Normal weight|
|25.0 - 29.9|Overweight|
|30.0 - 34.9|Obesity class I|
|35.0 - 39.9|Obesity class II|

just by looking at the mean bmi, we can see the average person is in the obese class I category. but the standard deviation is quite large, so there is a lot of variability in the data. the mean is not a good measure of centre in this case.

One way to asses if we have variable data is to divide the standard deviation by the mean. e.g $\frac{sd}{mean} = \frac{7.88673}{33.98667} = 0.232$ which in a percentage is 23.2%. this is a large percentage, so we have a lot of variability in the data.

If there is a lot of variability it means there is a lot of uncertainty in the data. so we need to be careful when making predictions.

### Percentiles and 5-Number Summary

A Percentile is the percentage of values falling at or below a point.

- Quartiles: 25th, 50th, 75th percentiles.
- percentiles: P10 through P90. (10th, 20th, 30th, 40th, 50th, 60th, 70th, 80th, 90th percentiles).
  - P10: 10% of the data is below this value.
  - P90: 90% of the data is below this value.

The Five-Number Summary is given by:

minimum, Q1, median, Q3, maximum.

Range = maximum - minimum

Interquartile Range (IQR) = Q3 - Q1 (middle 50% of the data) (robust to outliers) 

```r
fivenum(BMI)
24.5 27.80 30.95 40.90 54.30
```

- minimum = 24.5
- Q1 = 27.80
- median = 30.95
- Q3 = 40.90
- maximum = 54.30

looking at the distance betweent the minimum value, the first quartile and the median there's not that much of a difference. The difference between minimum and the median is just over 6.5. median is 50% of the data. If we look at the numbers after the median we can see there is a big difference between the median and the maximum. the difference is 23.35. which is large compared the difference between the minimum and the median. So we have a bit of data in the upper range that is skewing the distribution.

### Measure of Shape

A standard Normal distribution ![A standard Normal distribution](image-2.png)

Two measures of shape:

1. Skewness - measures the symmetry of the distribution. Or the lack of symmetry. A distribution is symmetric if the left and right sides are mirror images of each other. 
   - A distribution is skewed if one of its tails is longer than the other. 
   - A distribution is skewed to the left if the left tail is longer than the right tail. 
   - A distribution is skewed to the right if the right tail is longer than the left tail.

Skewed Distributions

![Standard Normal Distribution](image-3.png)

- If the skewness is exactly zero, the distribution is symmetric. = 0
- If the skewness is negative, the distribution is skewed to the left. < 0
  - This means that the outliers are from the lower end of the data.
- If the skewness is positive, the distribution is skewed to the right. > 0
  - If we do have outliers they are from the upper end of the data.


1. Kurtosis - measures the heaviness of the tails of a distribution. Or the lack of heaviness.
   - A distribution with heavy tails has more values in its tails than a normal distribution.
   - A distribution with light tails has fewer values in its tails than a normal distribution.
   - A distribution with normal tails has the same number of values in its tails as a normal distribution.

```r
skewness(BMI)
[1] 1.0905

kurtosis(BMI)
[1] 1.563
```

Excess Kurtosis ![Excess Kurtosis](image-4.png)

- If the kurtosis is exactly zero, the distribution is normal known as mesokurtic. = 3

- If the kurtosis is negative, the distribution is platykurtic. < 3
  - This means that the distribution has fewer values in its tails than a normal distribution.
  - much broader than a normal distribution.
  - this shape means that we would expect to see outliers in the middle of the data.* 

- If the kurtosis is positive, the distribution is leptokurtic. > 3
  - This means that the distribution has more values in its tails than a normal distribution.
  - much narrower than a normal distribution.
  - we would expect to see outliers in both extremes of the data.

```r
> skewness(BMI)
[1] 0.8356647
```

```r
> kurtosis(BMI)
[1] 2.765782
```

![Histogram](image-5.png)

- The distribution is skewed to the right.
- The distribution is leptokurtic.
- The distribution is not normal.
- The distribution has a lot of variability.
- Skewness is high so kurtosis is not useful.

When describing data we should describe all three features,

- the measure of centre,
- the measure of spread and
- the measure of shape.

## 1.3 Cleaning data and quality checks

### Data Quality Issues

What are the issues to consider?

- Data entry errors
  - Values outside of expected ranges
  
- Missing values
  - notes as NA in R
  - \>20% is not good.

- Outliers
  - Certain descriptive statistics are sensitive to outliers.
  - Can lead to bias estimates and potentially incorrect conclusions.

#### Handling Missing Values

- **Approach 1: Drop any features with missing values**
  - Typically not recommended
  - Depends on the % of missing values
  - the `is.na()` command in R can be used to check for missing values.

- **Approach 2: Analyse complete cases only**
  - `na.omit()` command in R can be used to remove missing values.
  - Important to note % of cases removed.

- **Approach 3: Impute the missing values**
  - Mean impuration, regression imputation, K-NN and etc.
  - Reccomended only for continuous data.

#### Detecting Outliers

- Check the range, i.e min to max
- Visualise the data using a boxplot, histograms etc.
- Use thresholds, e.g. (Q1, Q3) +/- 1.5 * IQR, z-scores outside of +/- 3. etc

#### Handling Outliers

- **Approach 1: Remove them**
  - Typically not recommended, in particular with small data sets.
  - Somewhat acceptable with large data sets.

- **Approach 2: Investigate the source and find out why this has happened**
  - If the outlier is due to a data entry error, then it can be removed.
  - If the outlier is due to a real phenomenon, then it should be kept.

- **Approach 3: Non-linear data transformation**
  - Squear-root and log-transformation for right skewed data.


## 1.4 Fundamentals of programming in R

## 1.5 Data Types
## 1.6 Data Structures
## 1.7 Create, manipulate and summarise data
## 1.8 Importing and exporting data
## 1.9 Data manipulation with dplyr
## 1.10 Descriptive statistics
## 1.11 Summarising data
## 1.12 Piping
## 1.13 Functions
## 1.14 Control structures
## 1.15 Introduction to Grammar of Graphics (ggplots)
## 1.16 Bar Charts
## 1.17 Histograms
## 1.18 Scatterplots
## 1.19 Boxplots
## 1.20 Line Charts
## 1.21 Arranging and exporting ggplots

## Summary of week 1

