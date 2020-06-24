# SOLUTIONS FOR COMMON PROBLEMS IN DATA SCIENCE & MACHINE LEARNING

# PART 2 - OVERFITTING

## What is overfitting? 
One of the most common problems that you would need to deal with is overfitting the model that you are building. [Overfitting](https://towardsdatascience.com/what-are-overfitting-and-underfitting-in-machine-learning-a96b30864690) occurs when the model fits the training set so well that it learns very specific details from the training set. But those details are not representation for the whole data, and as consequence the model makes bad predictions for new data. Now, you might be questioning, **how to avoid overfitting?** A variety of [techniques](https://towardsdatascience.com/handling-overfitting-in-deep-learning-models-c760ee047c6e) are used in order to avoid it, which are presented in this article.

## Oversampling
Oversampling means that the sample is chosen in a way that there are **more elements from a certain class**. This works well whenever you have unbalanced datasets. By oversampling you are making sure that the random sample taken for the training set contains elements from the class with less elements. 

## Stratified sample
A Stratified sample refers to forcing the sample to have the **same proportion of classes** as the original data. This is very useful since you are sure that the sample represents the data. However, notice that if you have a class with few elements in the original data, in terms of proportion might be insignificant and as a result the stratified sample will not contain any element of that class. 

## Cross-validation
[Cross-validation](https://dziganto.github.io/cross-validation/data%20science/machine%20learning/model%20tuning/python/Model-Tuning-with-Validation-and-Cross-Validation/) (CV) refers to any method that divides the data into different sets in order to evaluate how the model performs for new data, and define if the model is overfitting or it does not generalize well. 

## Test-Train-Validation sets
This technique in each iteration of the learning process divides the training set into two sets: training and validation. During each iteration, trains the model with the training set, followed by a validation phase with the validation set corrects errors made by the training. Once the iterations are finished, the test set is used to test the model with new data.     

<div id="div2">


<img src="https://upload.wikimedia.org/wikipedia/commons/1/12/Train-Test-Validation.png"
     alt="Skills for Data Scientists"
     width="250" height="250"
     align="middle" style="transform:rotate(90deg);"/>  
     
## K-folds
In K-folds cross validation method the data set is divided into k groups and the training and testing phases are repeated. Each time one set is selected for testing and the other k-1 folds for training. 

![](https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/K-fold_cross_validation_EN.svg/1042px-K-fold_cross_validation_EN.svg.png)

## Early stopping
[Early stopping](https://machinelearningmastery.com/early-stopping-to-avoid-overtraining-neural-network-models/) consists of **stopping the training before** the model begins to overfit. This is controlled by the number of iterations. You can set this number, by first choosing a large number of epochs (iterations), and compare the error in each iteration, when the validation error starts to increase there is sign to overfitting. Thus, you need to set a number of iterations before the point the validation error increases. 

## Pruning
Pruning reduces the size of a tree by removing sections that do not provide important information. First the training is performed and after the pruning is done. It is different from early stopping (pre-pruning), which stops the tree from growing before it classifies perfectly.

## Tuning
Tuning means choosing the best hyperparameters for a model to optimize the performance. This process can be done manually or automatically. Different algorithms have parameters to be adjusted. 

An automatic way of doing this is, for example, by [Grid Search](https://scikit-learn.org/stable/modules/grid_search.html) (search exhaustively through a specified subset of hyperparameters, and then see which combination has better performance) or Random Search (search randomly among the subset of hyperparameters). 

## Regularization
[Regularization](https://towardsdatascience.com/regularization-in-machine-learning-76441ddcf99a) methods try to reduce the complexity of the model by **adding penalty** to the weights (coefficients) of the model. This makes the model less likely to overfit because the learning process is discouraged. 

Ridge and Lasso regression are methods of regularization which add a penalty term for having large coefficients.     
- Lasso Regression: respect to the square norm L1 (Manhattan distance)     
- Ridge Regression: respect to the L2 norm (Euclidean distance)
By a tuning parameter  that defines how much penalty is added.

## Learning rate
For regression models and neural networks, lowering the learning rate can be a good option to slow down the learning process. It represents how fast or slow the algorithm will learn, it refers to the size of the steps to reach the optimal weights, if the [learning rate](https://mlexplained.com/2018/01/29/learning-rate-tuning-in-deep-learning-a-practical-guide/) is large the optimal solution will be skipped, if the learning rate is small it will need a lot of iterations to reach the optimal solution.

## Linear regression

**Loss function:** the loss is the error in the predicted value. The goal is to minimize this error.     

**Gradient Descent Algorithm:** is an algorithm to find the minimum of a function, in this case the loss function.      
 
**Learning rate:** it is an hyperparameter that controls the speed of adjusting the weights with respect to the loss function. The lowest value for the learning rate, the slower you go through the slope, it means there is less possibility of losing any local minima. On the other hand, going too slow might affect the time taken to converge.      

Applying **regularization** to a regression means constraining the coefficient estimates to zero. Therefore, the magnitude of coefficients and the error term are penalized. This generally is done to avoid overfitting.

- L2 regularization in the Lasso regression adds penalty “squared” to the magnitude of the coefficients. Works well for avoiding overfitting.  
- L1 adds in the Lasso regression penalty “absolute value” to the magnitude of the coefficients. Works well for feature selection.

**Regularization term:** The strength of the penalty is controlled by a tuning parameter called regularization parameter . Increasing this parameter results in less overfitting but also greater bias. So, you will need to define how much bias you are willing to have, and find a balance. Higher lambda means a simpler model, but you are at risk that the model does not learn well from the data. Whereas, with a lower lambda you have the risk that the model learns specific details from the data. 

## Trees

**Number of trees:** When applying boosting, sometimes the default number of trees is small. You can change this parameter and try different values to see which number is the best. Adding more trees beyond a certain limit does not improve the performance of the model. This is because in boosting, one tree corrects errors generated by the other in a sequence mode. Thus, the algorithm reaches some point where it does not have too much to correct, it means that the error stays constant after a certain amount of trees. 

**Size/depth of the tree:** Deeper trees generally capture too many details of the data and overfit the training dataset. Thus, limiting the size of the tree can avoid overfitting.

**Learning rate:** the learning rate also can be tuned when applying boosting.


## Neural Networks 
**Weights initialization:** the weights are adjusted during the learning phase, setting good initial weights can make the algorithm learn faster and find the best weights that minimize the loss function. The approaches available are:

1. Initializing all weights to 0: this makes your model equivalent to a linear model, because the derivative with respect to loss function is the same for every weight, having the same values for each iteration.            
2. Choose the weights randomly: when setting the weights randomly, two main problems can be presented:

	**Exploding gradient:** very large gradients generate an unstable network that cannot learn from the training data, and it can result in NaN weight values that can no longer be updated.
	
	**Vanishing gradient:** when the gradient is very small, and this prevents the weights from changing its value.

[In order to mitigate this problem](https://medium.com/usf-msds/deep-learning-best-practices-1-weight-initialization-14e5c0295b94), you can use a heuristic (a formula in function of the number of neuron layers) to determine the weights. For example, Xavier initialization for the Tanh activation function. 

**Learning rate:** When training a neural network, we also minimize a loss function, such as the log loss in a classification. So, we can add a penalty to the coefficients of the weights. 
The longer we train the network, the more specialized the weights will become to the training set, so there will be more probability of overfitting. 

**Ensemble:** use different models to make predictions and then take an average from the values of each prediction to get the final result. 

**Activation function:** the activation is the function used to process the inputs coming into each neuron. The activation function can impact the network’s ability to learn and the training speed. Choose the right activation function for your problem.    
- regression: use ‘linear’      
- binary classification: use ‘sigmoid’        
- multi-class classification: use ‘softmax’      

**The Dying ReLU problem:** it happens when inputs approach zero, or are negative, and as consequence the gradient of the function becomes zero. So, the network cannot perform backpropagation and cannot learn.

**Dropout:** the dropout determines the percentage of neurons that should be randomly “killed” during each epoch to prevent overfitting.

**Amount of nodes:** there are some rule of thumb to choose the amount of nodes for the layers:     
- Input layer: For the input layer the same amount of predictors are used         
- Hidden layer: 
1 hidden layer with (Number of inputs + outputs) * (2/3) nodes
A typical recommendation is that the number of weights should be no more than 1/30 of the number of training cases.       
- Output layer:  The result for the prediction should be only one value, therefore only one node for the output layer is used.

**Amount of layers:** generally we start with 3 layers and keep adding more layers in order to improve the generalization error. Adding layers increases the complexity of the network, so it is better to avoid it and instead adding more nodes or changing the regularization parameter might be a better option. 

**Optimizer:** it is the algorithm used to determine the optimal weights in each iteration when calculating the loss that is trying to minimize. 

**Training epochs:** An epoch corresponds to a group of samples which are passed through the network and then run backpropagation to determine their optimal weights.If the group cannot run all together because of the size, it is divided into batches. The number of epochs and the batch size, can affect the performance of the model.


**Data Augmentation:** When using images, we can increase the training data by doing some modification to the original one. For instance, in this image some modifications have been made to the original handwritten numbers. 

![](https://cdn.analyticsvidhya.com/wp-content/uploads/2018/04/Screen-Shot-2018-04-04-at-12.14.45-AM.png)

I recommend these links for further reading about tuning neural networks:    
- [https://towardsdatascience.com/types-of-optimization-algorithms-used-in-neural-networks-and-ways-to-optimize-gradient-95ae5d39529f](https://towardsdatascience.com/types-of-optimization-algorithms-used-in-neural-networks-and-ways-to-optimize-gradient-95ae5d39529f)           
- [https://missinglink.ai/guides/neural-network-concepts/hyperparameters-optimization-methods-and-real-world-model-management/](https://missinglink.ai/guides/neural-network-concepts/hyperparameters-optimization-methods-and-real-world-model-management/)           
- [https://towardsdatascience.com/a-walkthrough-of-convolutional-neural-network-7f474f91d7bd](https://towardsdatascience.com/a-walkthrough-of-convolutional-neural-network-7f474f91d7bd)          
- [https://frnsys.com/ai_notes/machine_learning/neural_nets.html](https://frnsys.com/ai_notes/machine_learning/neural_nets.html)      
- [https://www.deeplearning.ai/ai-notes/initialization/](https://www.deeplearning.ai/ai-notes/initialization/)         
- [https://towardsdatascience.com/neural-network-optimization-7ca72d4db3e0](https://towardsdatascience.com/neural-network-optimization-7ca72d4db3e0)      
- [https://www.deeplearning.ai/ai-notes/initialization/](https://www.deeplearning.ai/ai-notes/initialization/)               
- [https://machinelearningmastery.com/rectified-linear-activation-function-for-deep-learning-neural-networks/](https://machinelearningmastery.com/rectified-linear-activation-function-for-deep-learning-neural-networks/)       
- [https://machinelearningmastery.com/ensemble-methods-for-deep-learning-neural-networks/](https://machinelearningmastery.com/ensemble-methods-for-deep-learning-neural-networks/)         
- [https://gist.github.com/dyerrington/b136a24e4137415b307fde68aa8cb53b](https://gist.github.com/dyerrington/b136a24e4137415b307fde68aa8cb53b)            
- [https://machinelearningmastery.com/weight-regularization-to-reduce-overfitting-of-deep-learning-models/](https://machinelearningmastery.com/weight-regularization-to-reduce-overfitting-of-deep-learning-models/)           
- [https://www.deeplearning.ai/ai-notes/optimization/](https://www.deeplearning.ai/ai-notes/optimization/)  
- [https://machinelearningmastery.com/how-to-configure-the-number-of-layers-and-nodes-in-a-neural-network/](https://machinelearningmastery.com/how-to-configure-the-number-of-layers-and-nodes-in-a-neural-network/)     
- [https://stackoverflow.com/questions/10565868/multi-layer-perceptron-mlp-architecture-criteria-for-choosing-number-of-hidde](https://stackoverflow.com/questions/10565868/multi-layer-perceptron-mlp-architecture-criteria-for-choosing-number-of-hidde)            
- [https://machinelearningmastery.com/introduction-to-regularization-to-reduce-overfitting-and-improve-generalization-error/](https://machinelearningmastery.com/introduction-to-regularization-to-reduce-overfitting-and-improve-generalization-error/)    


# Conclusion
Many methods can help to avoid overfitting such as choosing the sample with certain characteristics can prevent overfitting, applying oversampling or stratified sampling. In addition, stopping the training phase before the model overfits is another way to evade overfitting. Finally,  tuning the model by setting hyperparameters can also avoid overfitting. Do not apply methods without thinking in the first place the reason why the model is overfitting. Otherwise, you won’t resolve the problem, and in the case of resolving it you won’t be able to explain.




