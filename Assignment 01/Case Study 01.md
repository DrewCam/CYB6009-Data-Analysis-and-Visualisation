# Case Study 01: Data preparation and visualisation

Available until 31 Jan 2024 14:00

## Scenario

You have been provided an export from Disc Consulting Enterprises’s (DCE’s) incident response team’s security information and event management (SIEM) system. The team have provided a .csv file (MLData2023.csv), with 500,000 event records, of which approximately 3,000 have been ‘tagged’ as malicious. Your goal is to integrate machine learning into their SIEM platform so that suspicious events can be investigated in real-time.

## Data description

Each event record is a snapshot triggered by an individual network ‘packet’. The exact triggering conditions for the snapshot are unknown. But it is known that multiple packets are exchanged in a ‘TCP conversation’ between the source and the target before an event is triggered and a record created. It is also known that each event record is unusual in some way (the SIEM logs many events that may be suspicious). A very small proportion of the data are known to be corrupted by their source systems and some data are incomplete or incorrectly tagged. The incident response team indicated this is likely to be less than a few hundred records. A list of the relevant features in the data is given below. The raw data for the variables below are contained in the MLData2023.csv file provided at the start of this case study.

### About the dataset

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

## Objectives

The data were gathered over a period and processed by several systems in order to associate specific events with confirmed malicious activities. However, the number of confirmed malicious events was very low, with these events accounting for less than 1% of all logged network events. Because the events associated with malicious traffic are quite rare, the rate of ‘false negatives’ and ‘false positives’ are important.

Initial goals will be to

1. Perform some basic exploratory data analysis.
2. Clean the file and prepare it for Machine Learning (ML).
3. Perform an initial Principal Component Analysis (PCA) of the data.
4. Identify features that may be useful for ML algorithms.
5. Create a brief report to the rest of the research team on your findings.

## Task Details

### 1. Create data sub sample

First, copy the code below to an R script. Enter your student ID into the command `set.seed(.)` and run the whole code. The code will create a sub-sample that is unique to you.

```r
# You may need to change/include the path of your working directory

dat <- read.csv("MLData2023.csv", stringsAsFactors = TRUE)

# Separate samples of non-malicious and malicious events

dat.class0 <- dat %>% filter(Class == 0) # non-malicious
dat.class1 <- dat %>% filter(Class == 1) # malicious

# Randomly select 300 samples from each class, then combine them to form a working dataset

set.seed(Enter your student ID here)
rand.class0 <- dat.class0[sample(1:nrow(dat.class0), size = 300, replace = FALSE),]
rand.class1 <- dat.class1[sample(1:nrow(dat.class1), size = 300, replace = FALSE),]

#### Your sub-sample of 600 observations

mydata <- rbind(rand.class0, rand.class1)

dim(mydata)  # Check the dimension of your sub-sample
```

> [!IMPORTANT]
> Use the str(.) command to check that the data type for each feature is correctly specified. Address the issue if this is not the case.

### 2. Explore the data

**(i)**
For each of your **categorical** or **binary** variables, determine the number (%) of instances for each of their categories and summarise them in a table as follows in your report. State all percentages in 1 decimal places.

|Categorical Feature|Category|N (%)|
|---|---|---|
|Feature 1|Category 1|10 (10.0%)|
|Category 2|30 (30.0%)|
|Category 3|50 (50.0%)|
|Missing|10 (10.0%)|
|Feature 2 (Binary)|YES|75 (75.0%)|
|NO|25 (25.0%)|
|Missing|0 (0.0%)|
|...|...|...|
|Feature k|Category 1|25 (25.0%)|
|Category 2|25 (25.0%)|
|Category 3|15 (15.0%)|
|Category 4|30 (30.0%)|
|Missing|5 (5.0%)|

> [!NOTE]  
> N (%) stands for frequency and percentage.  

**(ii)**  
Summarise each of your continuous/numeric variables in a table in your report as follows. State all values, except N, to 2 decimal places.

|Continuous Feature|Number (%) missing|Min|Max|Mean|Median|Skewness|
|---|---|---|---|---|---|---|
|Feature 1|||||||
|Feature 2|||||||
|...|...|...|...|...|...|...|
|Feature k|||||||

N (%) stands for frequency and percentage.

Note: The tables for subparts (i) and (ii) should be based on the original sub-sample of 600 observations, not the cleaned version (produced in the next step). You are only required to generate the statistics in R and then export the statistics into Excel, generate the tables, and format them appropriately.

### 3. Clean the data, Perform PCA and Visualise the data

**(iii)**  
Examine the results in sub-parts (i) and (ii). Are there any invalid categories/values for the categorical variables? Is there any evidence of outliers for any of the continuous/numeric variables? If so, how many and what percentage are there? Include your answers in your report.

1) Clean data, perform PCA and visualise the data

**(i)**
Now clean your data. For all the observations that you have deemed to be invalid/outliers in Part 1 (iii), mask them by replacing them with NAs using the `replace(.)` command in R.

**(ii)**
Export your “cleaned” data as follows. This file will need to be submitted along with your report.

```r
#Write to a csv file.  
write.csv(mydata,"mydata.csv")
```

**Your PCA must not use this exported csv file.**

**(iii)**
Extract only the data for the **numeric features** in **mydata**, along with **Class**, and store them as a separate data frame/tibble. Then, filter the incomplete cases (i.e. any rows with NAs) and perform PCA using `prcomp(.)` in R, but only on the numeric features (i.e. exclude Class). Include answers to the following in your report:

- Outline why you believe the data should or should not be scaled, i.e. standardised, when performing PCA.
- Outline the individual and cumulative proportions of variance (3 decimal places) explained by each of the first 4 components.
- Outline how many principal components (PCs) are adequate to explain at least 50% of the variability in your data.
- Outline the coefficients (or loadings) to 3 decimal places for PC1, PC2 and PC3, and describe which features (based on the loadings) are the key drivers for each of these three PCs.

**(iv)**
Create a biplot for PC1 vs PC2 to help visualise the results of your PCA in the first two dimensions. Colour code the points with the variable **Class**. Write a paragraph to explain what your biplots are showing. That is, comment on the PCA plot, the loading plot individually, and then both plots combined (see Slides 28-29 of Module 3 notes) and outline and justify which (if any) of the features can help to distinguish Malicious events.

**(v)**
Based on the results from parts (iii) to (iv), describe which dimension (choose just one) can assist with the identification of Malicious events (**Hint**: project all the points in the PCA plot to PC1 axis and see whether there is good separation between the points for Malicious and Non-Malicious events. Then project to PC2 axis and see if there is separation between Malicious and Non-Malicious events, and whether it is better than the projection to PC1).


## PREPARATION ACTIVITIES

The skills required to complete this assessment are covered Modules 1, 2 and 3.

## Rubric

ULO 3: Objectively use a range of modern visualisation methods appropriate for different types of data.

Correct implementation of descriptive analysis, data cleaning and PCA in R

1. Working code
2. Masking of invalid/outliers done correctly
3. Good documentation/commentary

Correct identification of missing and/or invalid observations in the data with justifications.

1. Correct summary statistics for the categorical and continuous features
2. Correct justification in the identification of outliers.

Accurate specification and interpretation of the contribution of principal components and its loading coefficients.

1. Explain why you should scale the observations when running PCA
2. Outline the individual and cumulative proportion of variance explained, and comment on the number of components required to explain at least 50% of the variance
3. Outline the loadings (to specified decimal place) and comment as to their contribution to its respective PC
4. Tabulation of results – no screenshots.

Accurate biplot, with appropriate interpretation presented.

1. 2-d with clear labels
2. Interpretation of the biplot: PCA plot – Clustering? Separation? Loadings plot – vectors (features) and its relation to each of the dimension, and as well as to each other
3. PCA + Loadings plot – Are any features able to assist with the classification of Malicious events, and if so, how?

Appropriate selection of dimension for the identification Malicious events with justification.

1. Choose a dimension, i.e. PC or PC2 and justify why it’s the best for classifying Malicious events.

Presentation and communication skills – Tables (no screenshots) and figures are well presented and appropriately captioned and are referenced in text. Report, analysis and overall narrative is well-articulated and communicated.

1. All figures and tables should be labelled/captioned appropriately and referenced in text. The labels in the plots should be clear
2. Solutions should be in the order that the questions were posed in the assignment
3. Spelling and grammatical errors should be kept to a minimum
4. Overall narrative – all interpretation should be in the context of the study.
