# Introduction to R and Data Visualisation

## 1.1 Intoduction to machine learning

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
  - [[Statistics]]
  - [[Artificial intelligence]]
  - [[Philosophy]]
  - [[Information theory]]
  - [[Biology]]
  - [[Cognitive science]]
  - [[Control theory]]

Book reference: [[An Introduction to Statistical Learning with Applications in R]]

![Machine Learning](<../zz. Files/image.png>)

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

### 1.2 Introduction to data analytics

Analysis vs Analytics?

- Analysis: the process of breaking a complex topic or substance into smaller parts to gain a better understanding of it.
- Analytics: the systematic computational analysis of data or statistics.
- 