# Case Study 1 - Report

- [Case Study 1 - Report](#case-study-1---report)
  - [Introduction](#introduction)
  - [Summary Tables](#summary-tables)
    - [Table 1 - Categorical \& Binary Variables](#table-1---categorical--binary-variables)
  - [Part 2 - Continuous/Numerical Variables](#part-2---continuousnumerical-variables)

## Introduction

## Summary Tables

### Table 1 - Categorical & Binary Variables

| Categorical Feature | Category            | N   | %     |
| ------------------- | ------------------- | --- | ----- |
| Operating.System    | "Android"           | 238 | 39.7% |
|                     | "iOS"               | 40  | 6.7%  |
|                     | "Windows (Unknown)" | 264 | 44.0% |
|                     | "Windows 10+"       | 4   | 0.7%  |
|                     | "Windows 7"         | 54  | 9.0%  |
| Connection.State    | "ESTABLISHED"       | 397 | 66.2% |
|                     | "INVALID"           | 177 | 29.5% |
|                     | "NEW"               | 13  | 2.2%  |
|                     | "RELATED"           | 13  | 2.2%  |
| IPv6.Traffic        | "-"                 | 151 | 25.2% |
|                     | " "                 | 53  | 8.8%  |
|                     | "FALSE"             | 396 | 66.0% |
| Ingress.Router      | "mel-aus-01"        | 365 | 60.8% |
|                     | "syd-tls-04"        | 235 | 39.2% |
| Class               | "0"                 | 300 | 50.0% |
|                     | "1"                 | 300 | 50.0% |

Table 1 shows the categorical and binary variables in the dataset. The table shows the number of observations in each category and the percentage of the total observations that category represents.

Issues with the data:

- The `Operating.System` variable has a category for "Windows (Unknown)", "Windows 7" and "Windows 10+". Could be combined into a single category. As the "Windows 10+" category only has 4 observations, and combineing the categories would make the variable more interpretable.

- The `IPv6.Traffic` variable has a category for " " and "-". Which suggests missing data. This variable should be investigated further or repalaced with NA values. Alternitivly, the variable could be removed from the dataset as it does not appear to be useful. False is the only category that has a significant number of observations.

## Part 2 - Continuous/Numerical Variables

| Continuous Feature              | Number Missing | Percentage Missing | Min      | Max       | Mean      | Median    | Skewness |
| ------------------------------- | -------------- | ------------------ | -------- | --------- | --------- | --------- | -------- |
| Assembled.Payload.Size          | 0              | 0%                 | -1.00    | 80580.00  | 48476.33  | 49268.50  | -0.28    |
| DYNRiskA.Score                  | 0              | 0%                 | 0.19     | 0.92      | 0.61      | 0.63      | -0.57    |
| Response.Size                   | 0              | 0%                 | 76495.00 | 822051.00 | 492667.72 | 492937.00 | -0.06    |
| Source.Ping.Time                | 0              | 0%                 | 119.00   | 415.00    | 267.75    | 267.00    | -0.04    |
| Connection.Rate                 | 0              | 0%                 | 0.02     | 1821.42   | 432.24    | 399.72    | 0.95     |
| Server.Response.Packet.Time     | 0              | 0%                 | 75.00    | 417.00    | 226.75    | 221.00    | 0.23     |
| Packet.Size                     | 0              | 0%                 | 1260.00  | 1439.00   | 1349.68   | 1348.00   | 0.05     |
| Packet.TTL                      | 0              | 0%                 | 32.00    | 108.00    | 63.98     | 63.00     | 0.19     |
| Source.IP.Concurrent.Connection | 0              | 0%                 | 9.00     | 34.00     | 21.37     | 21.50     | -0.03    |

Table 2 shows the continuous/numerical variables in the dataset. The table shows the number of missing observations, the percentage of missing observations, the minimum, maximum, mean, median and skewness of each variable.

Issues with the data:

- The `Assembled.Payload.Size` variable has a minimum value of -1.0%. It is not possible for an assembled payload size to be negative.
- The `Connection.Rate` variable skewness is 0.95. This suggests that the variable is not normally distributed. This should be investigated further. as there may be outliers in the data.
