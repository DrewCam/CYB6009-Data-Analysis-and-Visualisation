# Case Study 02

## Early Incident Identification

Disc Consulting Enterprises (DCE) has identified some potentially suspicious attacks on their network and computer systems. The attacks are thought to be a new type of attack from a skilled threat actor. To date, the attacks have only been identified ‘after the fact’ by examining post-exploitation activities of the attacker on compromised systems. 

Unfortunately, the attackers are skilled enough to evade detection and the exact mechanisms of their exploits have not been identified. The incident response team, including IT services, security operations, security architecture, risk management, the CISO (Chief Information Security Officer), and the CTO (Chief Technology Officer) have been meeting regularly to determine next steps. It has been suggested that the security architecture and operations teams could try to implement some real-time threat detection using machine learning models that build on earlier consultancy your firm has completed (i.e., building upon your Assessment 1 work). 

Data description 
The data you will use is the same data set provided in Assessment 1. It is provided again below.

## Things to keep in mind

Each event record is a snapshot triggered by an individual network ‘packet’. The exact triggering conditions for the snapshot are unknown. But it is known that multiple packets are exchanged in a ‘TCP conversation’ between the source and the target before an event is triggered and a record created. It is also known that each event record is anomalous in some way (the SIEM logs many events that may be suspicious).

The malicious events account for a very small amount of data. As such, your training needs to consider the “imbalanced” data and the effect these data may have on accuracy (both specificity and sensitivity).

A very small proportion of the data are known to be corrupted by their source systems and some data are incomplete or incorrectly tagged. The incident response team indicated this is likely to be less than a few hundred records. A list of the relevant features in the data is given below.

## About the dataset

| Variable | Description |
| ---- | ---- |
| **Assembled Payload Size (continuous)** | The total size of the inbound suspicious payload. Note: This would contain the data sent by the attacker in the “TCP conversation” up until the event was  triggered. |
| **DYNRiskA Score (continuous)** | An untested in-built risk score assigned by a new SIEM plug-in. |
| **IPV6 Traffic (binary)** | A flag indicating whether the triggering packet was using IPV6 or IPV4 protocols (True = IPV6). |
| **Response Size (continuous)** | The total size of the reply data in the TCP  conversation prior to the triggering packet. |
| **Source Ping Time (ms) (continuous)** | The ‘ping’ time to the IP address which triggered the event record. This is affected by network structure, number of ‘hops’ and even physical distances. E.g.: <br><br>- < 1 ms is typically local to the device<br>- 1-5ms is usually located in the local network<br>- 5-50ms is often geographically local to a country<br>- ~100-250ms is trans-continental to servers<br>- 250+ may be trans-continental to a small network. <br><br>_Note, these are estimates only and many factors can influence ping times._ |
| **Operating System (Categorical)** | A limited ‘guess’ as to the operating system that generated the inbound suspicious connection. This is not accurate, but it should be somewhat consistent for each ‘connection’. |
| **Connection State (Categorical)** | An indication of the TCP connection state at the time the packet was triggered. |
| **Connection Rate (continuous)** | The number of connections per second by the inbound suspicious connection made prior to the event record creation. |
| **Ingress Router (Binary)** | DCE has two main network connections to the ‘world’. This field indicates which connection the events arrived through. |
| **Server Response Packet Time (ms) (continuous)** | An estimation of the time from when the payload was sent to when the reply packet was generated. This may indicate server processing time/load for the event. |
| **Packet Size (continuous)** | The size of the triggering packet. |
| **Packet TTL (continuous)** | The time-to-live (TTL) of the previous inbound packet. TTL can be a measure of how many ‘hops’ (routers) a packet has traversed before arriving at our network. |
| **Source IP Concurrent Connection (Continuous)** | How many concurrent connections were open from the source IP at the time the event was triggered. |
| **Class (Binary)** | Indicates if the event was confirmed malicious, i.e., 0 = Non-malicious, 1 = Malicious. |

### Variable names

#### Categorical

- Operating System = Operating.System
- Connection State = Connection.State
- Ingress Router = Ingress.Router
- IPV6 Traffic =  IPV6.Traffic
- Class = Class

#### Continuous

- Assembled Payload Size = Assembled.Payload.Size
- DYNRiskA Score = DYNRiskA.Score
- Response Size = Response.Size
- Source Ping Time (ms) = Source.Ping.Time
- Connection Rate = Connection.Rate
- Server Response Packet Time (ms) = Server.Response.Packet.Time
- Packet Size = Packet.Size
- Packet TTL = Packet.TTL
- Source IP Concurrent Connection = Source.IP.Concurrent.Connection

## The needle in the haystack

The data were gathered over a period of time and processed by several systems in order to associate specific events with confirmed malicious activities. However, the number of confirmed malicious events was very low, with these events accounting for less than 1% of all logged network events. Because the events associated with malicious traffic are quite rare, rate of ‘false negatives’ and ‘false positives’ are important .

## Scenario

Following the meetings of the security incident response team, it has been decided to try to make an ‘early warning’ system that extends the functionality of their current SIEM. It has been proposed that DCE engage 3rd party developers to create a ‘smart detection plugin’ for the SIEM.

The goal is to have a plug-in that would extract data from real-time network events, send it to an external system (your R script) and receive a classification in return. However, for the plugin to be effective it must consider the alert-fatigue experienced by security operations teams as excessive false-positives can lead to the team ignoring real incidents. But, because the impact of a successful attack is very high, false negatives could result in attackers overtaking the whole network.

## Part 1 - General data preparation and cleaning

1. Import the dataset from the case study into R Studio. This version is the same as Assessment 1.

2. Write the appropriate code in R Studio to prepare and clean the  dataset as follows:
   1. Clean the **whole** dataset based on what you have suggested / feedback from Assessment 1.
   2. Filter the data to only include cases labelled with Class = 0 or 1.
   3. For the feature `Operating.System`, merge the three Windows categories together to form a new category, say `Windows_All`. Furthermore, merge **iOS**, **Linux (Unknown)**, and **Other** to form the new category named **Others**. Hint: use the `forcats:: fct_collapse(.)` function. 
   4. Similarly, for the feature `Connection.State`, merge **INVALID**, **NEW** and **RELATED** to form the new category named **Others**.
   5. Select only the complete cases using the `na.omit(.)` function, and name the dataset **MLData2023_cleaned**.

    Briefly outline the preparation and cleaning process in your report and why you believe the above steps were necessary.

3. Use the code below to generated two training datasets (one unbalanced `mydata.ub.train` and one balanced `mydata.b.train`) along with the testing set (`mydata.test`). Make sure you enter your student ID into the command `set.seed(.)`

```r
# Separate samples of non-malicious and malicious events
dat.class0 <- MLData2023_cleaned %>% filter(Class == 0) # non-malicious
dat.class1 <- MLData2023_cleaned %>% filter(Class == 1) # malicious

# Randomly select 19800 non-malicious and 200 malicious samples, then combine them to form the training samples
set.seed(Enter your student ID)
rows.train0 <- sample(1:nrow(dat.class0), size = 19800, replace = FALSE)
rows.train1 <- sample(1:nrow(dat.class1), size = 200, replace = FALSE)
# Your 20000 unbalanced training samples
train.class0 <- dat.class0[rows.train0,] # Non-malicious samples
train.class1 <- dat.class1[rows.train1,] # Malicious samples
mydata.ub.train <- rbind(train.class0, train.class1)
mydata.ub.train <- mydata.ub.train %>%
                     mutate(Class = factor(Class, labels = c("NonMal","Mal")))
# Your 39600 balanced training samples, i.e. 19800 non-malicious and malicious samples each.
set.seed(123)
train.class1_2 <- train.class1[sample(1:nrow(train.class1), size = 19800, 
                               replace = TRUE),]
mydata.b.train <- rbind(train.class0, train.class1_2)
mydata.b.train <- mydata.b.train %>%
                    mutate(Class = factor(Class, labels = c("NonMal","Mal")))
# Your testing samples
test.class0 <- dat.class0[-rows.train0,]
test.class1 <- dat.class1[-rows.train1,]
mydata.test <- rbind(test.class0, test.class1)
mydata.test <- mydata.test %>%
                 mutate(Class = factor(Class, labels = c("NonMal","Mal")))
```

> [!NOTE] Note that in the master data set, the percentage of malicious events is less than 1%. This distribution is roughly represented by the unbalanced data. The balanced data is generated based on up-sampling of the minority class using bootstrapping. The idea here is to ensure the trained model is not biased towards the majority class, i.e. non-malicious event.

## Part 2 - Compare the performances of different ML Algorithms

1. Randomly select two supervised learning modelling algorithms to test against one another by running the following code. Make sure you enter your student ID into the command set.seed(.). Your 2 ML approaches are given by myModels.

    ```r
    set.seed(Enter your student ID)
    models.list1 <- c("Logistic Ridge Regression",
                      "Logistic LASSO Regression",
                      "Logistic Elastic-Net Regression")
    models.list2 <- c("Classification Tree",
                      "Bagging Tree",
                      "Random Forest")
    myModels <- c(sample(models.list1, size = 1),
                  sample(models.list2, size = 1))
    myModels %>% data.frame
    ```

    For each of your two ML modelling approaches, you will need to:

2. Run the ML algorithm in R on the two training sets with Class as the outcome variable.

3. Perform hyperparameter tuning to optimise the model:

    Outline your hyperparameter tuning/searching strategy for each of the ML modelling approaches. Report on the search range(s) for hyperparameter tuning, which 𝑘-fold CV was used, and the number of repeated CVs (if applicable), and the final optimal tuning parameter values and relevant CV statistics (i.e. CV results, tables and plots), where appropriate. If you are using repeated CVs, a minimum of 2 repeats are required.

    - If your selected tree model is Bagging, you must tune the nbagg, cp and minsplit hyperparameters, with at least 3 values for each.
    - If your selected tree model is Random Forest, you must tune the num.trees and mtry hyperparameters, with at least 3 values for each. Be sure to set the randomisation seed using your student ID.

4. Evaluate the predictive performance of your two ML models, derived from the balanced and unbalanced training sets, on the testing set. Provide the confusion matrices and report and describe the following measures in the context of the project:

   - False positive rate
   - False negative rate
   - Overall accuracy
   - Make sure you define each of the above metrics in the context of the case study.

5. Provide a brief statement on your final recommended model and why you chose it. Parsimony, and to a lesser extent, interpretability maybe taken into account if the decision is close. You may outline your penalised model if it helps with your argument.


## Rubric

Accurate implementation of data cleaning and of each supervised machine learning algorithm in R
Strictly about code: (1) Does the code work from start to finish? (2) Are the results reproducible? (3) Are all the steps performed correctly? (4) Is it your own work? Note: No more than 20% of your code are to come from external sources.

Part 1 - Explanation of data cleaning and preparation.

1. Corresponds to part 1 b
2. Briefly outline the reasons for sub-parts (i) and (ii)
    (i) Clean the whole dataset based on what you have suggested / feedback from Assessment 1.
    (ii) Filter the data to only include cases labelled with Class = 0 or 1.
3. Provide justifications for merging of categories, i.e. sub- part(iii) and (iv).
   1. (iii) For the feature Operating.System, merge the three Windows categories together to form a new category, say Windows_All. Furthermore, merge iOS, Linux (Unknown), and Other to form the new category named Others. Hint: use the forcats:: fct_collapse(.) function.
   2. (iv) Similarly, for the feature Connection.State, merge INVALID, NEW and RELATED to form the new category named Others.
   3. (v) Select only the complete cases using the na.omit(.) function, and name the dataset MLData2023_cleaned.

Part 2 - An outline of the selected modelling approaches, the hyperparameter tuning and search strategy, the corresponding performance evaluation in the training sets (i.e. CV results, tables and plots), and the optimal tuning hyperparameter values.

1. Penalised logistic regression model 
   - Outline the range of values for your lambda and alpha (if elastic-net).
   - Plot/tabulate the CV results. 
   - Outline the optimal value(s) of your hyperparameter(s). Outline the coefficients if required for your arguments of model choice.

2. Tree models
   - Outline the range of the hyperparameters (bagging and RF).
   - Tabulate, e.g. the top combinations and the optimal OOB misclassification error, or plot the CV results (e.g. classification tree).

Presentation, interpretation and comparison of the performance measures (i.e. confusion matrices, false positives, false negatives, etc.) among the selected machine learning algorithms. Justification of the recommended modelling approach.

1. Provide the confusion matrices (frequencies, proportions) in the test set.
2. Interpretation of the metrics, including accuracy, false positive rate, false negative rate in the context of the study

