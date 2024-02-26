CYB6009 - Data Analysis & Visualisation

**Enhancing Incident Detection: A Comparative Analysis of Supervised Machine Learning Models**

DCCAMERO - 10215233

![[Cyber Defend Shield.png]]

note: Hello my name is Drew Cameron; My student ID is 10215233.

This presentation forms Assignment 3: A Comparative Analysis of Supervised Machine Learning Models

---
## Introduction
### Background

- DCE facing sophisticated cyberattacks
- Reliance on inadequate post-exploitation detection
- Critical need for real-time threat detection
- Challenge: Isolating few malicious events withing a vast number of non-malicious events.
### Purpose

- Enhance SIEM with an early warning system
- Evaluate ML-Based detection models
- Accurately detect threats and minimise false alerts.

note: This project aims to enhance DCE's Security Information and Event Management system with an early warning feature by utilising machine learning models. DCE as experiencing sophisticated attacks where current detection methods are lacking.

---
## Objective

- **Analyse** Logistic LASSO Regression and Bagging Tree models.
- **Compare** model effectiveness in classifying malicious events.
- **Identify** the optimal model for SIEM system integration to enhance cybersecurity.


note: Our primary objective is to determine the most effective machine learning model for classifying malicious events while accounting for false positives. The ultimate aim is to help build a robust early warning system as part of the SIEM infrastructure. We are evaluating two models Logistic LASSO Regression and Bagging Tree in their ability to accurately identify malicious events while considering the cost of false negatives, and the fatigue of false positives.

---
## Methodology

### The Data

> [!WARNING] **Pre-cleaning:** 502,159 observations across 14 variables

- Key Drivers of note
	- **Assembled.Payload.Size**
	- **DYNRiskA.Score**
	- **Server.Response.Packet.Time**
- Outcome Variable 
	- Class (Malicious, Non-Malicious.)

note: Before cleaning the dataset, consisted of more than five hundred thousand observations across 14 variables, Some variables of note are
- Assembled Payload size:  The total size of the inbound suspicious payload.
- DYNRisk.Score: An assigned risk score by a new SIEM plug-in.
- Server Response Packet time: The estimated time from payload dispatch to reply packet generation.
- and the outcome variable "Class": An indicator of whether the event was confirmed malicious or not. The target variable to be predicted by the models.
---
### Data Cleaning & Preparation

- Removal of invalid entries, replacing with NA values.
- Merging of categories for operating systems and connection states.
- Filtering of data to include only Class 0 and Class 1.
- Removal of the "IPv6.Traffic" feature.

> [!WARNING] **Post-cleaning:** 492,036 observations across 13 variables

note: the data underwent a cleaning and preparation process. We identified and replaced invalid entries with NA values and simplified categories of operating systems and connection states. The feature "IPv6.Traffic" was removed during this process as it contained to many invalid observations and not important to this evaluation. We then filtered the data to include only Class 0 and 1 (NonMal and Mal),

---
### Methodology Cont.

> [!TIP] Model Selection & Training
> - Logistic LASSO Regression
> - Bagging Tree

> [!NOTE] Prediction & Performance
> - Generated predictions using trained models on the test set.
> - Calculating False positive rate, false negative rate, precision, recall, f1 etc
> - Values and results collated and evaluated.

Note: We selected two machine learning models: Logistic LASSO Regression and Bagging Tree.

Lasso Regression was tuned by searching a sequence of lambda values and repeatedcv, 10 kfold with 5 repeats.

The Bagging Tree model underwent parameter tuning through a grid search function.

After determining the optimal parameters, we trained the model and generated predictions for performance metrics calculation. These metrics included False Positive Rate, False Negative Rate, Precision, Recall, and F1-Score.

---
## Results

![[Performance Comparison.png]]

Note: Comparing  the performance of the LASSO Regression and Bagging Tree models across balanced and unbalanced datasets, focusing on four key metrics: accuracy, precision, recall, and F-score.

For the LASSO Regression model, on a balanced dataset, accuracy was 99.40%, precision at 49.01%, recall at 97.48%, and the F-score at 65.23%. On an unbalanced dataset, the model improved significantly, showing a precision of 96.41%, recall at 93.18%, and an F-score of 94.77%. This indicates the model's strong ability to minimize false positives, particularly in unbalanced datasets.

The Bagging Tree model showed high accuracy across both datasets. On a balanced dataset, accuracy was 99.84%, precision at 83.27%, recall at 90.26%, and the F-score at 86.62%. On an unbalanced dataset, it maintained high performance with a precision of 96.25%, recall at 91.86%, and an F-score of 94.01%.

---
## Discussion

### Lasso Regression
- **Precision Optimized**: Superior in unbalanced datasets.
- **Reduces False Positives**: Critical for minimizing alert fatigue.
### Bagging Tree:

- **High Accuracy & Balance**: Effective across dataset conditions.
- **Robust Performance**: effective in specificity and precision.

note:
The LASSO Regression model demonstrates exceptional precision and an impressive F-score in unbalanced datasets, highlighting its efficiency in correctly identifying malicious events while minimizing false positives. This performance is crucial in environments where the precision of threat detection can significantly reduce operational overhead and alert fatigue.

Conversely, the Bagging Tree model, known for its robustness, offers consistent performance across both balanced and unbalanced datasets. It excels in maintaining high accuracy and provides a reliable recall rate, which is essential for ensuring that few malicious events are missed. Its F-score, while competitive, suggests a slightly broader focus, balancing the detection of true positives against false positives effectively, but not quite matching the LASSO model in precision.

---
## Recommendation

- **LASSO Regression on Unbalanced Data**
- **Key Justifications:**
  - Superior Precision and F-Score
  - Reduced False Positives and Alert Fatigue
  - Operational Efficiency in Real-World Security Contexts

![stopconfusingmewithfacts.jpg (690×356) (wp.com)](https://i0.wp.com/timoelliott.com/blog/wp-content/uploads/2009/03/stopconfusingmewithfacts.jpg?resize=690%2C356&ssl=1)

note: Concluding the analysis, the LASSO Regression model, particularly when trained on unbalanced data, emerges as the optimal choice for enhancing our cybersecurity measures. This decision is grounded in the model's superior precision and F-score, which are critical for minimizing false positives - a prevalent issue in cybersecurity operations known as alert fatigue. By effectively reducing false alerts, the LASSO Regression model ensures that security teams can focus on genuine threats, enhancing operational efficiency. Its performance in unbalanced datasets, which closely mirrors real-world data scenarios where malicious events are rare, makes it especially valuable. This model's ability to maintain high precision while balancing the detection of true positives and minimizing false negatives is key to its recommendation. It strikes the right balance for our operational needs, ensuring that alerts are both meaningful and actionable, without overwhelming our security personnel.
