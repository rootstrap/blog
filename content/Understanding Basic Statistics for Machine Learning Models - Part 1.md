![Matrix multiplication](https://storage.needpix.com/rsynced_images/business-361126_1280.jpg)
     
# UNDERSTANDING BASIC STATISTICS FOR MACHINE LEARNING MODELS - PART 1

If you want to understand machine learning algorithms, it is very important to have basic statistical knowledge so as to understand what is behind them. Understanding how the algorithm operates gives you the possibility of configuring the model according to what you need, as well explaining with more confidence the results obtained from the execution of the model. 

This series of articles presents a very brief summary that tries to list all basic statistical concepts necessary to face machine learning problems. The articles are presented in a schematic way since the main purpose is to start being familiar with terminologies and definitions that are going to be used in machine learning algorithms.

In this first section an outline of definitions about probability and matrices is provided.  


## Probability 
Firstly, some probability terms are described. Those terms are being used then to explain the fundamentals of the algorithms. 

**Sample:** set of observations drawn from a population. It is necessary to use samples because it is impossible to study all the population. Population refers to the set of all the data. 

**Sample space:** set of all possible outcomes that can happen in a chance situation.

**Event:** a subset of the sample space. A probability is assigned to the event.

**Probability:** a measure of the likelihood that an event will occur in a random experiment. It is quantified as a number between 0 and 1, where. The higher, the more likely is the occurrence of the event. 

*Probability = # desired outcomes / # possible outcomes*

### Probability rules

<img src="images/Probability_rules.jpg"
     alt="Skills for Data Scientists"
     width="550" height="450"
     align="middle"/>
     
**Independent events:** The occurrence of one event has no effect on the probability of occurrence of the other event. If A,B are independent, then *P(A and B) = P(A) x P(B)*


**Joint probability:** chance of an outcome of having two events occurring together at the same time.


**Marginal probability:** the probability of observing an outcome with a single variable, regardless of its other variables. 


**Conditional probability:** the conditional probability of an event A given that the event B occurs. It is written like: *P(A|B) = P(A and B) / P(B)*


**Multiplication rule:** 
*P(A and B)= P(A|B) x P(B)*
*P(A and B)= P(B|A) x P(A)*

**Bayes Rule:** *P(A|B)=P(B|A) x P(A)/P(B)*

### Representation

**Probability tree:** diagram to represent different outcomes in function of the occurrence of the events. 

<img src="images/probability_tree.png"
     alt="Skills for Data Scientists"
     align="middle"/>
     
 Probability table: A probability table is another way  of representing probabilities. 


| Event         | Probability   |
| --------------|:-------------:| 
| A             | 0.15          | 
| B             | 0.35          | 
| C             | 0.50          | 

## Random variables
A **random variable** describes the probability for an uncertain future numerical outcome of a random process. It is a function that maps an outcome of a random experiment to a numerical value.
For instance, in the case of the experiment of flipping a coin twice, the sample space is S={HH,TT,HT,TH}. Where H corresponds to head and T to tail respectively. Therefore, let be a random variable X the number of heads, it would be a function that from the outcome determines how many heads were flipped.   
Thus, X takes the following values:   
HH -> 2  
TT -> 0  
HT -> 1  
TH -> 1  

Then, the random variable X can take the values {0,1,2}, corresponding to the possible cases. Observe that although the sample space had 4 cases, the random variable can only take 3 values. 

**Discrete random variable:** the set of possible outcomes is finite. 

**Continue random variable:** can take any value within an interval. 

[**Expected value:**](https://towardsdatascience.com/what-is-expected-value-4815bdbd84de) weighted average, based on probability to weigh the possible outcomes. It is the sum of all gains multiplied by each probability. Where x1..xn are values for the sample space of the discrete random variable X. Reaching to the following [formula](https://www.statisticshowto.com/probability-and-statistics/expected-value/):
 
<img src="https://render.githubusercontent.com/render/math?math=E(X) = X_1*p(X_1) + X_2*p(X_2) + … + X_n*p(X_n)">

**Variance:** intents to describe how spread is the data from the mean value. It is defined as the expected value of the squared deviation of X from the mean m. 

<img src="https://render.githubusercontent.com/render/math?math=Var(X)= E[(X-m)2]">

So, here the function is <img src="https://render.githubusercontent.com/render/math?math=g(X)=(X-m)^2">, applying the formula of the expected value of a function, we get: 
<img src="https://render.githubusercontent.com/render/math?math=Var(X)= E[(X-m)2]=(x_1-m)^2*p(x_1)+(x_2-m)^2+...+(x_n-m)^2">
<img src="https://render.githubusercontent.com/render/math?math==\sum(x_i - m)^2p(x_i)">

<img src="https://render.githubusercontent.com/render/math?math=E(X)=Y">

[**Standard deviation:**] (https://www.youtube.com/watch?v=2egl_5c8i-g)
it is the square root of Var(X).  It is denoted as <img src="https://render.githubusercontent.com/render/math?math=\sigma_x">

[**Covariance:**](https://corporatefinanceinstitute.com/resources/knowledge/finance/covariance/)  measures the variance between two random variables.

<img src="https://render.githubusercontent.com/render/math?math=COV(X,Y)=\sum\frac{(X_i - \bar X)(Y_i - \bar Y)}{n}">

- Positive covariance: the variables tend to move in the same direction.
- Negative covariance: the variables tend to move in inverse directions.
It is important to notice that the covariance shows the direction of the relationship between the two variables, but not the strength of it.

**Correlation:** measures the strength of the relationship between variables.

<img src="https://render.githubusercontent.com/render/math?math=COV(X,Y)=\sum\frac{(X_i - \bar X)(Y_i - \bar Y)}{n}">


- Positive correlation: the variables are correlated and they move in the same direction.
- Negative correlation: the variables are correlated and they move in opposite directions.
- No correlation: when the coefficient is 0 does not exist any relationship between the variables. It means that the variables are independent. 

**Distance matrix:** squared matrix that contains the distance between the variables of the set. The most common distance used is the Euclidean distance, but there are other distances that can be used.

**I.i.d (Identically independent distributed) random variables:** when two random variables are identically (have the same probability distribution) and are mutually independent. Often this assumption is applied in machine learning algorithms in order to imply that all samples come from the same process which does not depend from past generated samples.

## Matrices 
Basic knowledge about matrices is necessary in order to understand some of the math behind the algorithms and handle images. 


<img src="https://render.githubusercontent.com/render/math?math=A_{mxn}"> It is a matrix with m rows and n columns. 

**Square matrix:** when <img src="https://render.githubusercontent.com/render/math?math=m=n">


**Column vector:** is a matrix with only 1 column


**Row vector:** a matrix with only 1 row


**Transpose matrix:** interchange rows and columns. Notation: <img src="https://render.githubusercontent.com/render/math?math=A'=t(A)">


**Diagonal matrix:** has 0 values except the main diagonal


**Symmetric matrix:** square matrix unchanged when it is transposed. <img src="https://render.githubusercontent.com/render/math?math=A'=A">


**Identity matrix:** diagonal matrix with all elements of the diagonal equal to 1. Notation: I


**Matrix multiplication:** <img src="https://render.githubusercontent.com/render/math?math=A_{lxm} B_{mxn}= C_{lxn}">

![Matrix multiplication](https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Matrix_multiplication_qtl1.svg/1240px-Matrix_multiplication_qtl1.svg.png)

**Element-wise multiplication:** <img src="https://render.githubusercontent.com/render/math?math=A_{nxm}  B_{nxm}= C_{nxm}">

![Element-wise multiplication](https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Hadamard_product_qtl1.svg/440px-Hadamard_product_qtl1.svg.png)

**Inverse matrix:** <img src="https://render.githubusercontent.com/render/math?math=AA-1=I">


**Trace:** sum of the elements of the diagonal.


**Determinant:** Notation: <img src="https://render.githubusercontent.com/render/math?math=det(A)=|A|">

![Determinant](https://upload.wikimedia.org/wikipedia/commons/d/d2/Determinant_3x3_Example_Barking_Mad_1.jpg)

**Eigenvalues and eigenvectors**

<img src="https://render.githubusercontent.com/render/math?math=A\bar x =\lambda\bar x">   
<img src="https://render.githubusercontent.com/render/math?math=\lambda"> is a scalar and is called the eigenvalue of A    
<img src="https://render.githubusercontent.com/render/math?math=\bar x"> is the eigenvector belonging to <img src="https://render.githubusercontent.com/render/math?math=\lambda">.   
Any nonzero multiple of  <img src="https://render.githubusercontent.com/render/math?math=\bar x"> will be an eigenvector.  
To find : <img src="https://render.githubusercontent.com/render/math?math=|A - \lambdaI|=0">

## Roadmap 
Cheat sheets are very useful to have all the concepts in one document, [here](images/Probability_and_Matrices_Roadmap.pdf) you can find a cheat sheet for this part. 


