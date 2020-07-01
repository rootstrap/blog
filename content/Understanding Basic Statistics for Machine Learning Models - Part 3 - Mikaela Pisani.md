![](images/business-361126_1280.jpg)
    
# UNDERSTANDING BASIC STATISTICS FOR MACHINE LEARNING MODELS - PART 2

In this article you can find explanations for statistical concepts such as Statistical hypothesis test, used for answering questions about sample data and validating assumptions. In addition, it is provided a list of concepts regarding sampling distribution. Finally, we discuss the relationship between variance and bias.

## Statistical hypothesis testing
States a hypothesis that provides the confidence level for the calculation of a quantity under a certain assumption. Commonly, the assumption to be tested is based on a comparison between two statistical data or a sample against the population parameter. The result of the test allows us to interpret whether the assumption holds or has been violated. The assumption of a statistical test is called the **null hypothesis or H0**. 

**p-value:** is the level of marginal significance, represents the probability of occurrence of a given event under the assumption that the null hypothesis is correct. It is used to quantify the result of the test and either reject or fail to reject the null hypothesis. This is done by comparing the p-value to the desired significance level. A result is statistically significant when the p-value is less than the significant level.  

```
If p-value > : Fail to reject the null hypothesis   
If p-value <= : Reject the null hypothesis 
```

The p-value is the smallest significance level at which H0 can be rejected. 
The significance level is set generally to 0.05. A smaller value implies a more robust interpretation. 

## Type error I and II


| Type error I        | Type error II |
| --------------------|:-------------:| 
|Is the rejection of a true null hypothesis| Is the non-rejection of a false null hypothesis | 
|Take action when unnecessary| Failure to take an appropriate action |  
|Can only occur when H0 is true | Can only occur when H0 is false|   

## Z-test and T-test

| Type error I        | Type error II |
| --------------------|:-------------:| 
| Hypothesis test to determine whether two population means are different. | Hypothesis test to determine if there is a significant difference between two population means. |
| Standard deviation or variances are known | Standard deviation are unknown|
| Large sample size| Small sample size|
| Based on a normal distribution| Based on t-distribution (heavier tails, less space in the center)|
| A z-statistic, or z-score, is a number representing the result from the z-test.| A t-statistic, or t-score, is a number representing the result from the t-test.|

## Sampling distribution
Sometimes we have a lot of data, so we cannot use all the data. Therefore, we use sampling to extract a group of data from the total. 

**Sampling distribution:** The sampling distribution shows how a statistic varies from sample to sample. You can find an explanation in this [video](https://www.youtube.com/watch?v=FXZ2O1Lv-KE&feature=youtu.be) 

**Randomization:** ensures that on average a sample mimics the population in order to avoid bias. 

**Sample size:** larger populations do not require larger samples

**Stratified random sample:** divides the sampling frame into subsets before the sample is selected. 

**Sample size condition:** 
![](https://render.githubusercontent.com/render/math?math=n%20%3E%2010*%7Ck_4%7C) where ![](https://render.githubusercontent.com/render/math?math=k_4%3D(z_1%5E4%2Bz_2%5E4...%2Bz_n%5E4)%2Fn%20-3)

**Control limits** - set boundaries that determine whether a process should be stopped or allowed to continue 

- UCL- upper control limit    
- LCL- lower control limit   

By these limits you can find a balance between errors type I and II. You cannot reduce both errors by moving limits.    
- s-chart : control chart that tracks sample standard deviation    
- R-chart: control chart that tracks sample ranges observations    
- X-bar: controls the mean of a process    


|Central Limitorial Theorem: if the sample size is large enough the shape of X is normally distributed regardless of the distribution of the population. Where X is the sampling distribution for the mean. | 
|:--------------------------------------------------------------:|

**Test statistics:** sample statistics that estimates the population parameter specific by the null and hypothesis. 
