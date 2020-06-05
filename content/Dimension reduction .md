# Dimension reduction 
Whenever you have too many features in your model, applying dimension reduction might be a good idea. It will help you to reduce the complexity of the model as well as to avoid overfitting. Dimension reduction can be applied either to represent the data graphically or to reduce the number of input variables. 

The main idea is to reduce the number of variables by representing them with a set of principal variables. There are two types, feature selection, and feature extraction. While feature selection selects variables from the original set, feature extraction tries to find new variables that are hidden. 

## Feature selection
There are two main types of [feature selection](https://towardsdatascience.com/the-5-feature-selection-algorithms-every-data-scientist-need-to-know-3a6b566efd2), filter-based and wrapped-based.        

* **Filter-based:** the measurements of the correlation are filtered by some threshold in order to determine the most relevant variables. The correlation used to make the comparison between variables will depend on the type of the variables (numerical or categorical).       

* **Wrapped-based:** creates various models with different input variables and selects the ones that have the best performance.    

## Feature extraction
### Principal Components Analysis (PCA) 
This method is based on the eigenvectors. It tries to represent the maximum variation in the data by finding linear combinations of the original variables. Below briefly explains the process done to find the principal components. 
These are steps followed to find the principal components:    
**Step 1** Standardize data.      
**Step 2** Calculate the correlation matrix.      
**Step 3** Find eigenvalues ![](https://render.githubusercontent.com/render/math?math=%5Clambda_1%2C%5Clambda_2%2C...%2C%5Clambda_p) -> variance and eigenvectors ![](https://render.githubusercontent.com/render/math?math=a_1%2Ca_2%2C...%2Ca_p) -> principal components.

![](https://render.githubusercontent.com/render/math?math=Z_i%3D%20a_%7Bi1%7D*x_1%2B%20a_%7Bi2%7D*x_2%20%2B...%20%2Ba_%7Bip%7D*x_p)

![](https://render.githubusercontent.com/render/math?math=%5Clambda_1%20%5Cgeq%20%5Clambda_2%5Cgeq...%5Cgeq%20%5Clambda_p%5Cgeq%200)

![](https://render.githubusercontent.com/render/math?math=a_%7Bi1%7D%5E2%2Ba_%7Bi2%7D%5E2%2B...%2Ba_%7Bip%7D%5E2%3D1)

Maximize ![](https://render.githubusercontent.com/render/math?math=Var(Z_i)%3D%20i)


* **First principal component**     
![](https://render.githubusercontent.com/render/math?math=Z1%3D%20a_%7B11%7D*x_1%2Ba_%7B12%7D*x_2%2B...%2Ba_%7B1p%7D*xp)

Maximize ![](https://render.githubusercontent.com/render/math?math=Var(Z_i))    
               
Linear combination of the original variables which maximize the variance of the data.

* **Second principal component**      
$$$$      
$$Corr(Z_1,Z_2)=0$$        
Is chosen perpendicular to the first principal component.


* **Third principal component**         
![](https://render.githubusercontent.com/render/math?math=Z_2%3D%20a_%7B21%7D*x_1%2Ba_%7B22%7D*x_2%2B...%2Ba_%7B2p%7D*x_p)

![](https://render.githubusercontent.com/render/math?math=Z_3%3Da_%7B31%7D*x_1%2Ba_%7B32%7D*x_2%2B...%2Ba_%7B3p%7D*x_p)
![](https://render.githubusercontent.com/render/math?math=Corr(Z_1%2CZ_3)%3D0)

![](https://render.githubusercontent.com/render/math?math=Corr(Z_2%2CZ_3)%3D0)

Uncorrelated with the other 2 principal components. 

**Step 4:** Discard any components that account for a small proportion of the variance in the data.
Retain just enough components to explain a large percentage of total variation of original variables (70%-90%). Exclude principal components whose eigenvalues are less than average.

*Observation: The sum of the variance of the principal components is equal to the sum of the variances of the original values.*


## Exploratory Factor Analysis (EFA) 
[EFA](https://datasciencetips.com/use-factor-analysis-to-better-understand-your-data/) is a regression model to link original variables to a set of unobservable variables (common factors). 

**Exploratory Factor Analysis:** Investigate relationship between manifest variables and factors without making any assumptions about which manifest variables are related to which factors. 

**Confirmatory Factor Analysis:** Test whether a specific factor model provides an adequate fit for the covariances or correlations between the manifest variables. 

![](https://render.githubusercontent.com/render/math?math=Z_i%3D%5Clambda_%7Bi1%7D*f_1%2B%5Clambda_%7Bi2%7Df_2%2B...%2B%5Clambda_%7Bik%7Df_k%20%2Bu_i)

![](https://render.githubusercontent.com/render/math?math=Z_i%3Dx_i-x_%7Bii%7D) z-score  
![](https://render.githubusercontent.com/render/math?math=%5Clambda_%7Bij%7D) coefficients (loadings)                 
k<q k number of factors, q number of variables        
![](https://render.githubusercontent.com/render/math?math=f_i) factors(latent variables):      
![](https://render.githubusercontent.com/render/math?math=f_1%2C%20f_2%2C...%2Cf_k)  uncorrelated
scaled (mean=0 and standard deviation=1)              
![u_i](https://render.githubusercontent.com/render/math?math=u_i) error
![](https://render.githubusercontent.com/render/math?math=u_i%2C%20u_2%2C...%2Cu_k) uncorrelated with each other and with factors ![](https://render.githubusercontent.com/render/math?math=f_1%2C%20f_2%2C...%2Cf_k)











