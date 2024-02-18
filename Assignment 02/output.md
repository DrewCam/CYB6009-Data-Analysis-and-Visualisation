r$> str(MLData2023pre)
'data.frame':   502159 obs. of  14 variables:

r$> str(MLData2023_cleaned)
'data.frame':   492036 obs. of  13 variables:

## === Lasso Model (Balanced) ===
Confusion Matrix and Statistics

| |Mal |NonMal|
|---|---|---|
|Mal|2672|2780|
|NonMal|69 |466515|

      Accuracy : 0.994
      95% CI : (0.9937, 0.9942)
      No Information Rate : 0.9942
      P-Value [Acc > NIR] : 0.9807
      Kappa : 0.6496
      Mcnemar's Test P-Value : <2e-16

            Sensitivity : 0.974827
            Specificity : 0.994076
         Pos Pred Value : 0.490095
         Neg Pred Value : 0.999852
             Prevalence : 0.005807
         Detection Rate : 0.005661
   Detection Prevalence : 0.011550
      Balanced Accuracy : 0.984451

       'Positive' Class : Mal

False Positive Rate:  0.005923779
False Negative Rate:  0.02517329
Precision:  0.4900954
Recall:  0.9748267
F1-Score:  0.6522641

   alpha       lambda
11     1 4.037017e-05

## === Lasso Model (UnBalanced) ===
Confusion Matrix and Statistics

| |Mal |NonMal|
|---|---|---|
|Mal|2554|95|
|NonMal|187|469200|

               Accuracy : 0.9994
                 95% CI : (0.9993, 0.9995)
    No Information Rate : 0.9942
    P-Value [Acc > NIR] : < 2.2e-16

                  Kappa : 0.9474

      Mcnemar's Test P-Value : 5.994e-08

            Sensitivity : 0.931777
            Specificity : 0.999798
         Pos Pred Value : 0.964137        
         Neg Pred Value : 0.999602
             Prevalence : 0.005807
         Detection Rate : 0.005411
      Detection Prevalence : 0.005612
      Balanced Accuracy : 0.965787

       'Positive' Class : Mal

      False Positive Rate:  0.0002024313
      False Negative Rate:  0.06822328
      Precision:  0.9641374
      Recall:  0.9317767
      F1-Score:  0.9476809

## === Lasso Model (UnBalanced) ===

   alpha       lambda
19     1 0.0001232847


## === Tree Model (Balanced) ===
Confusion Matrix and Statistics

| |Mal| NonMal|
|---|---|---|
  |Mal   |   2474|    497|
  |NonMal|    267| 468798|

               Accuracy : 0.9984
                 95% CI : (0.9983, 0.9985)
    No Information Rate : 0.9942
    P-Value [Acc > NIR] : < 2.2e-16

                  Kappa : 0.8654

      Mcnemar's Test P-Value : < 2.2e-16

            Sensitivity : 0.902590
            Specificity : 0.998941
         Pos Pred Value : 0.832716
         Neg Pred Value : 0.999431
             Prevalence : 0.005807
         Detection Rate : 0.005241        
      Detection Prevalence : 0.006294
      Balanced Accuracy : 0.950766

       'Positive' Class : Mal

      False Positive Rate:  0.001059035
      False Negative Rate:  0.0974097
      Precision:  0.8327163
      Recall:  0.9025903
      F1-Score:  0.8662465

## === Tree Model (UnBalanced) ===
Confusion Matrix and Statistics

| |Mal| NonMal|
|---|---|---|
|Mal|      2518 |    98|
|NonMal|    223 |469197|

               Accuracy : 0.9993
                 95% CI : (0.9992, 0.9994)
    No Information Rate : 0.9942
    P-Value [Acc > NIR] : < 2.2e-16

                  Kappa : 0.9397

      Mcnemar's Test P-Value : 4.485e-12

            Sensitivity : 0.918643
            Specificity : 0.999791
         Pos Pred Value : 0.962538
         Neg Pred Value : 0.999525
             Prevalence : 0.005807
         Detection Rate : 0.005334
      Detection Prevalence : 0.005542
      Balanced Accuracy : 0.959217

       'Positive' Class : Mal

      False Positive Rate:  0.0002088239
      False Negative Rate:  0.08135717
      Precision:  0.9625382
      Recall:  0.9186428
      F1-Score:  0.9400784

## === Bagging OOB (Balanced) ===
   nbagg cp minsplit OOB.misclass test.sens test.spec test.acc
2    100  0        5         0.04     99.89     90.77    99.84
27   150  0       10         0.04     99.88     91.61    99.84
4    200  0        5         0.05     99.90     91.10    99.84
26   100  0       10         0.05     99.87     90.77    99.82
1     50  0        5         0.05     99.89     90.73    99.84
28   200  0       10         0.05     99.88     91.72    99.83
3    150  0        5         0.06     99.89     90.66    99.84
25    50  0       10         0.06     99.89     91.75    99.84
49    50  0       15         0.06     99.86     93.47    99.83
50   100  0       15         0.07     99.86     93.51    99.82

## === Bagging OOB (UnBalanced) ===
   nbagg cp minsplit OOB.misclass test.sens test.spec test.acc
3    150  0        5         0.16     99.98     92.12    99.93
1     50  0        5         0.16     99.98     91.35    99.93
50   100  0       15         0.16     99.97     90.66    99.92
2    100  0        5         0.17     99.97     92.27    99.93
4    200  0        5         0.17     99.98     92.01    99.93
25    50  0       10         0.17     99.98     90.19    99.92
27   150  0       10         0.17     99.98     91.28    99.93
28   200  0       10         0.18     99.98     91.75    99.93
51   150  0       15         0.18     99.97     89.97    99.91
26   100  0       10         0.18     99.97     91.54    99.93

r$>


r$> # print lasso balanced lambda vs accuracy
    cat("=== Lasso Model (Balanced) ===\n"); print(lasso_model_b$results)
=== Lasso Model (Balanced) ===
    alpha       lambda  Accuracy     Kappa   AccuracySD     KappaSD
1       1 1.000000e-05 0.9965707 0.9931414 0.0009907048 0.001981410
2       1 1.149757e-05 0.9965707 0.9931414 0.0009907048 0.001981410
3       1 1.321941e-05 0.9965707 0.9931414 0.0009907048 0.001981410
4       1 1.519911e-05 0.9965707 0.9931414 0.0009907048 0.001981410
5       1 1.747528e-05 0.9965707 0.9931414 0.0009907048 0.001981410
6       1 2.009233e-05 0.9965707 0.9931414 0.0009907048 0.001981410
7       1 2.310130e-05 0.9965707 0.9931414 0.0009907048 0.001981410
8       1 2.656088e-05 0.9965707 0.9931414 0.0009907048 0.001981410
9       1 3.053856e-05 0.9965707 0.9931414 0.0009907048 0.001981410
10      1 3.511192e-05 0.9965707 0.9931414 0.0009907048 0.001981410
11      1 4.037017e-05 0.9965707 0.9931414 0.0009907048 0.001981410
12      1 4.641589e-05 0.9965657 0.9931313 0.0009958278 0.001991656
13      1 5.336699e-05 0.9965556 0.9931111 0.0010085021 0.002017004
14      1 6.135907e-05 0.9965202 0.9930404 0.0009909675 0.001981935
15      1 7.054802e-05 0.9965000 0.9930000 0.0010036513 0.002007303


r$> cat("=== Lasso Model (UnBalanced) ===\n"); print(lasso_model_ub$results)
=== Lasso Model (UnBalanced) ===
    alpha       lambda Accuracy      Kappa   AccuracySD    KappaSD
1       1 1.000000e-05  0.99853 0.92309124 0.0007100589 0.03788644
2       1 1.149757e-05  0.99853 0.92309124 0.0007100589 0.03788644
3       1 1.321941e-05  0.99853 0.92309124 0.0007100589 0.03788644
4       1 1.519911e-05  0.99852 0.92252521 0.0007281511 0.03879294
5       1 1.747528e-05  0.99852 0.92252521 0.0007281511 0.03879294
6       1 2.009233e-05  0.99853 0.92299181 0.0007242871 0.03864410
7       1 2.310130e-05  0.99853 0.92299181 0.0007242871 0.03864410
8       1 2.656088e-05  0.99853 0.92291491 0.0007172083 0.03830518
9       1 3.053856e-05  0.99857 0.92475561 0.0006925994 0.03727125
10      1 3.511192e-05  0.99858 0.92532079 0.0006651684 0.03582621
11      1 4.037017e-05  0.99858 0.92532079 0.0006651684 0.03582621
12      1 4.641589e-05  0.99859 0.92602535 0.0006363961 0.03418738
13      1 5.336699e-05  0.99858 0.92548052 0.0006256425 0.03361781
14      1 6.135907e-05  0.99862 0.92745265 0.0006023762 0.03267016
15      1 7.054802e-05  0.99862 0.92745265 0.0006023762 0.03267016


r$> # print lasso model best tune parameters
    cat("=== Lasso Model (Balanced) ===\n"); print(lasso_model_b$bestTune)
    cat("=== Lasso Model (UnBalanced) ===\n"); print(lasso_model_ub$bestTune)
=== Lasso Model (Balanced) ===
   alpha       lambda
11     1 4.037017e-05
=== Lasso Model (UnBalanced) ===
   alpha       lambda
24     1 0.0002477076



## Tree Bagging OOB (Balanced)
|nbagg| cp| minsplit| OOB.misclass| test.sens| test.spec| test.acc|
|--|--|--|--|--|--|--|
|  100|  0|        5|         0.04|     99.89|     90.77|    99.84|
|  150|  0|       10|         0.04|     99.88|     91.61|    99.84|
|  200|  0|        5|         0.05|     99.90|     91.10|    99.84|
|  100|  0|       10|         0.05|     99.87|     90.77|    99.82|
|   50|  0|        5|         0.05|     99.89|     90.73|    99.84|

For the balanced dataset, the best model had the parameters nbagg: 100, cp: 0, minsplit: 5 with an OOB error of 0.04, sensitivity of 99.89%, specificity of 90.77%, and accuracy of 99.84%.

## Tree Bagging OOB (Unbalanced)
|nbagg| cp| minsplit| OOB.misclass| test.sens| test.spec| test.acc|
|--|--|--|--|--|--|--|
|  150|  0|        5|         0.16|     99.98|     92.12|    99.93|
|   50|  0|        5|         0.16|     99.98|     91.35|    99.93|
|  100|  0|       15|         0.16|     99.97|     90.66|    99.92|
|  100|  0|        5|         0.17|     99.97|     92.27|    99.93|
|  200|  0|        5|         0.17|     99.98|     92.01|    99.93|



For the balanced dataset, the best model had the parameters nbagg: 100, cp: 0, minsplit: 5 with an OOB error of 0.04, sensitivity of 99.89%, specificity of 90.77%, and accuracy of 99.84%.

For the unbalanced dataset, the best model had the parameters nbagg: 150, cp: 0, minsplit: 5 with an OOB error of 0.16, sensitivity of 99.98%, specificity of 92.12%, and accuracy of 99.93%.