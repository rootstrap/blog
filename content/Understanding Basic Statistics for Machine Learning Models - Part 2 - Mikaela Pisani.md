![](images/business-361126_1280.jpg)
    
# UNDERSTANDING BASIC STATISTICS FOR MACHINE LEARNING MODELS - PART 2

In this article you can find the basic information necessary for a data scientist about distributions. It is expected that you have knowledge about random variables and probability concepts such as variance, covariance and expected value. You can find that information on Understanding Basic Statistics for Machine Learning Models - Part 1. 

## What is a distribution?
A probability distribution: is a summary of probabilities for the values of a random variable.

Measurements: The distribution also has general properties that can be measured. Important properties of a probability distribution are: expected value, variance, skewness and kurtosis. 

The probability for a discrete random variable can be summarized with a discrete probability distribution. In the same way, the summary for a continuous random variable is called continuous probability distribution. 


## Discrete distributions 
**Bernoulli:**  distribution for a binary variable, represents the probability of a single experiment with 2 possible outcomes (probability p and 1-p). 

![](https://render.githubusercontent.com/render/math?math=E(X)%3Dp)

![](https://render.githubusercontent.com/render/math?math=Var(X)%3Dp(1-p))

**Binomial:** represents the number of successes in n Bernoulli trials. Thus, the experiments are independent, where each one has 2 possible outcomes. 

![](https://render.githubusercontent.com/render/math?math=E(X)%3Dnp)

![](https://render.githubusercontent.com/render/math?math=Var(X)%3Dnp(1-p))

**Negative binomial:** represents the number of successes (r) in a sequence of i.i.d. Bernoulli trials with probability p before a specified number of failures occurs.

![](https://render.githubusercontent.com/render/math?math=E(X)%3D%5Cfrac%7Bpr%7D%7B%2F(1-p)%7D)

![](https://render.githubusercontent.com/render/math?math=Var(X)%3D%5Cfrac%7Bpr%7D%7B(1-p)2%7D)

**Poisson distribution:** models the number of events produced by a random process during a fixed interval of time or space.  is the rate of events or arrivals within disjoint intervals. 

![](https://render.githubusercontent.com/render/math?math=P(X%3Dx)%20%3De%5E%7B-%5Clambda%20%5Cfrac%7B%5Clambda%5Ex%7D%7Bx!%7D%7D)

![](https://render.githubusercontent.com/render/math?math=E(X)%3DVar(X)%20%3D%5Clambda)

## Continuous distributions
### Normal

<img src="images/bayesian-2889576_1280.png"
     alt="Normal Distribution"
     width="100" height="100"
     align="right"/>
A normal distribution is symmetric about the mean, where data near the mean is more frequent in occurrence than data far from the mean. It has a bell shape. Notation: ![](https://render.githubusercontent.com/render/math?math=N(%5Cmu%2C%5Csigma)), where ![](https://render.githubusercontent.com/render/math?math=%5Cmu) refers to the mean and ![](https://render.githubusercontent.com/render/math?math=%5Csigma) to the standard deviation. 


[Empirical curve](https://www.statisticshowto.com/empirical-rule-2/)    

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Standard_deviation_diagram.svg/800px-Standard_deviation_diagram.svg.png"
     alt="Normal distribution"
     width="350" height="200"
     align="middle"/>
    


The empirical rule establishes:    
- Approximately 68% of the data falls within one standard deviation of the mean   
- Approximately 95% of the data falls within two standard deviations of the mean       
- Approximately 99.7% of the data falls within three standard deviations of the mean       

### Truncated normal
A truncated normal distribution is a variation of the normal distribution, but the random variables are bound from either below or above, or both. 

<img src="https://upload.wikimedia.org/wikipedia/en/d/df/TnormPDF.png"
     alt="Truncated normal distribution"
     width="350" height="200"
     align="middle"/>


### Uniform
A uniform distribution describes an experiment with arbitrary outcomes in a certain bounds determined by  a and b, minimum and maximum values for the interval. The interval can be either open (a,b) or closed [a,b].

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Uniform_cdf.svg/500px-Uniform_cdf.svg.png"
     alt="Uniform distribution"
     width="200" height="150"
     align="middle"/>

 
### Exponential
An exponential distribution expresses the probability distribution for time between intervals in a Poisson point process. 

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Exponential_probability_density.svg/856px-Exponential_probability_density.svg.png"
     alt="Exponential distribution"
     width="350" height="250"
     align="middle"/>

 
### Triangular
A triangular distribution is limited by a lower, upper limits and the mode value. 
 <center>
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Window_function_and_frequency_response_-_Rectangular.svg/1024px-Window_function_and_frequency_response_-_Rectangular.svg.png"
     alt="Triangular distribution"
     width="350" height="200"
     align="middle"/>
 </center>
 
### Bimodal distribution
A bimodal distribution involves 2 different models. 

### Multimodality
A multimodal distribution involves more than 2 models ( data comes from more than 2 groups).


## Skewness
The skewness measures lack of symmetry. A distribution, or data set, is symmetric if it looks the same to the left and right of the center point. Thus, it can be described as the measure of the distortion from a normal distribution.
A distribution that has negative skewness commonly indicates that the tail is on the left side, and in the same way positive skew indicates that the tail is on the right. 

## Kurtosis
Kurtosis measures extreme values in either left or right tail. Measures whether the data is heavy-tailed in comparison with a normal distribution. When there is a large kurtosis the tails exceeds the tails of the normal distribution, and It means that the dataset has outliers. Data sets with low kurtosis tend to have light tails, or lack of outliers. 

## Quantiles
The quantiles are equal portions that divide a distribution. The image shows the 4 quantiles for a normal distribution. When the divisions correspond to 25%, 50% and 75% of the total distribution are called quartiles. The inter-quartile range is the difference between Q3 and Q1, and the 2nd quartile is the median.


<img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Iqr_with_quantile.png"
     alt="Triangular distribution"
     width="350" height="200"
     align="middle"/>
 
 
**Confidence interval** 
A confidence interval is the level of certainty that the true parameter is in the proposed range. 
The confidence interval represents the probability of containing the true interval. In other words, it represents the proportion of intervals that contain the true value of the statistical parameter. 
The graph represents a confidence interval for 95%. The level of confidence is 95% and 
the likelihood that the true population parameter lies outside is ![](https://render.githubusercontent.com/render/math?math=%5Calpha) , in this case ![](https://render.githubusercontent.com/render/math?math=%5Calpha%3D0.5%3D1-0.95).
    




