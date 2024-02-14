# Case Study 02


Goal - is to have a plug-in that would extract data from real-time network events, send it to an external system (your R script) and receive a classification in return.

## Part 1: General data preparation and cleaning

### Part 1.1 Data import

1. Imported the dataset MLData2023.csv into R and name it MLData2023.

## Part 1.2 Data cleaning

1. Corresponds to part 1 b
2. Briefly outline the reasons for sub-parts (i) and (ii)
    (i) Clean the whole dataset based on what you have suggested / feedback from Assessment 1.
    (ii) Filter the data to only include cases labelled with Class = 0 or 1.
3. Provide justifications for merging of categories, i.e. sub- part(iii) and (iv).
   1. (iii) For the feature Operating.System, merge the three Windows categories together to form a new category, say Windows_All. Furthermore, merge iOS, Linux (Unknown), and Other to form the new category named Others. Hint: use the forcats:: fct_collapse(.) function.
   2. (iv) Similarly, for the feature Connection.State, merge INVALID, NEW and RELATED to form the new category named Others.
   3. (v) Select only the complete cases using the na.omit(.) function, and name the dataset MLData2023_cleaned.


## Part 1.3 Data preparation

generated two training datasets (one unbalanced mydata.ub.train and one balanced mydata.b.train) along with the testing set (mydata.test). The training sets are to be used to train the ML models, and the testing set is to be used to evaluate the predictive performance of the models.

## Part 2: Compare the performances of 2 different ML algorithms

1. Selected models to be compared.

- Logistic LASSO Regression
- Bagging tree

1. Run the ML algorithm in R on the two training sets with Class as the outcome variable.

2. Perform hyperparameter tuning to optimise the models

Outline your hyperparameter tuning/searching strategy for each of the ML modelling approaches. Report on the search range(s) for hyperparameter tuning, which 𝑘-fold CV was used, and the number of repeated CVs (if applicable), and the final optimal tuning parameter values and relevant CV statistics (i.e. CV results, tables and plots), where appropriate. If you are using repeated CVs, a minimum of 2 repeats are required.

Penalised logistic regression model

- Outline the range of values for your lambda and alpha (if elastic-net).
- Plot/tabulate the CV results.
- Outline the optimal value(s) of your hyperparameter(s). Outline the coefficients if required for your arguments of model choice.

Bagging tree - must tune the nbagg, cp and minsplit hyperparameters, with at least 3 values each.

1. Evaluate the predictive performance of your two ML models, derived from the balanced and unbalanced training sets, on the testing set. Provide the confusion matrices and report and describe the following measures in the context of the project:

   - False positive rate
   - False negative rate
   - Overall accuracy
   - Make sure you define each of the above metrics in the context of the case study.

2. Provide a brief statement on your final recommended model and why you chose it. Parsimony, and to a lesser extent, interpretability maybe taken into account if the decision is close. **You may outline your penalised model if it helps with your argument.**

