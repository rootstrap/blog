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
**Step 3** Find eigenvalues $$1,2,...,p$$ -> variance and eigenvectors $$a1,a2,...,ap$$ -> principal components.

$$Z_i= a_{i1}*x_1\space + \space a_{i2}*x2\space +\space ...\space +\space a_{ip}*xp\space$$      

$$\lambda_1 >= \lambda_2>=...>=\lambda_p>=0$$    

$$a_{i1}^2+a_{i2}^2+...+a_{ip}^2=1$$    

$$Maximize\space Var(Z_i)= i$$   


* **First principal component**     
$$Z1= a_{11}*x_1+a_{12}*x_2+...+a_{1p}*xp$$  
$$Maximize \space Var(Z_1)$$                
Linear combination of the original variables which maximize the variance of the data.

* **Second principal component**      
$$Z2= a_{21}*x_1+a_{22}*x_2+...+a_{2p}*x_p$$      
$$Corr(Z_1,Z_2)=0$$        
Is chosen perpendicular to the first principal component.


* **Third principal component**.   
$$Z_3=a_{31}*x_1+a_{32}*x_2+...+a_{3p}*x_p$$            
$$Corr(Z1,Z3)=0$$     
$$Corr(Z2,Z3)=0$$       
Uncorrelated with the other 2 principal components. 

**Step 4:** Discard any components that account for a small proportion of the variance in the data.
Retain just enough components to explain a large percentage of total variation of original variables (70%-90%). Exclude principal components whose eigenvalues are less than average.

*Observation: The sum of the variance of the principal components is equal to the sum of the variances of the original values.*


## Exploratory Factor Analysis (EFA) 
[EFA](https://datasciencetips.com/use-factor-analysis-to-better-understand-your-data/) is a regression model to link original variables to a set of unobservable variables (common factors). 

**Exploratory Factor Analysis:** Investigate relationship between manifest variables and factors without making any assumptions about which manifest variables are related to which factors. 

**Confirmatory Factor Analysis:** Test whether a specific factor model provides an adequate fit for the covariances or correlations between the manifest variables. 

$$Z_i=\lambda_{i1}*f1+i2f2+...+ikfk +ui$$

$$Z_i=x_i-x_{ii}$$ z-score  
$$\lambda_{ij}$$ coefficients (loadings)              
k<q k number of factors, q number of variables        
$$f_i$$ factors(latent variables):      
$$f_1, f_2,...,f_k$$   uncorrelated
scaled (mean=0 and standard deviation=1)              
$$u_i$$ error
$$u_i, u_2,...,u_k$$ uncorrelated with each other and with factors $$f_1, f_2,...,f_k$$











