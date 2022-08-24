# ClusterStatistics

The purpose of this project was to run various forms of statistical analysis and visualize data. 
It was originally designed with the intention of performing analysis using t-distributed stochastic neighbor embedding and varimax factor analysis.


# Overview
This package is designed to visualize the results of t-distributed stochastic neighbor embedding (t-SNE), varimax factor analysis (VFA) and Partial least squares discriminant analysis (PLS-DA). 

  ## t-Distributed Stochastic Neighbor Embedding 
The purpose of t-SNE is to better visualize high dimensional data. This technique operates by constructing a probability density function between pairs of high dimensional objects. The objects that are closer in multidimensional space are assigned a higher probability value, while more distant objects are given a lower probability. However, one of the primary limitations of this technique is that it does not preserve distances associated with dissimilarity well in lower dimensional space. For this reason, this technique should not be used for dimensionality reduction.  
  ## Varimax Factor Analysis 
Factor analysis (FA) is defined as a statistical method that seeks to uncover underlying latent factors that can account for the common variance among observed variables. As such, FA can serve as an unsupervised approach to dimensionality reduction. Unlike principal component analysis (PCA) which seeks to just determine optimal projections into lower dimensional space, FA assumes a certain number of underlying common variables that are correlated with observed measurements.  

Using the normalized values, the Pearson correlation coefficient between all variable pairs was calculated to determine the correlation matrix. Eigen decomposition was used to uncover the principal directions and principal values across all variables. The number of proposed exploratory factors was selected using a scree plot presentation of all eigenvalues. Based on the point by which eigenvalues level off in their relative value to each other, the number of factors for FA was selected. The matrix of eigenvalues was then scaled so that the scores had a unit variance. Using the rescaled matrix of eigenvalues,  the varimax rotation was applied. This technique is a variant of factor analysis that is derived by taking an orthogonal rotation of the factor axes such that the variance of the squared loadings for each factor is maximized.  

Factor loadings can be interpreted to represent the strength of the relationship between measured variables and underlying factors. Depending on the grouping between variables sharing common factors, FA can be used to uncover areas of interest for further investigation.   

  ## Partial least squares discriminant analysis 
Partial least squares discriminant analysis (PLS-DA) is defined as a variant of partial least squares regression when the dependent variable is categorical. PLS is especially useful in cases where there are many predictors which are highly collinear. Unlike FA, PLS-DA is a supervised learning approach where training data is utilized to fit a model. This technique is composed of two main parts, dimensionality reduction and model fitting. Membership in the predictor group is treated as a dummy matrix and is paired with the training data derived from the independent variables.  Partial least square components are derived such that the covariance between the independent variables X and the dependent variables Y is maximized. 

  ## Mahalanobis distance 
The Mahalanobis distance is a metric used to quantify the proximity between a point in n-dimensional space and the mean of a distribution D.  Mahalanobis distance is distinct from Euclidean distance as it takes into consideration the covariance matrix between variables and can account for different variables following different scales. Utilizing this metric, the degree to which values deviate from their respective groups centroids as well as the distinctiveness between differing groups can be quantified. 

# Installation

In order to utilize this package, you must have the following dependencies:

Python 3.7.3 or later (https://www.python.org/downloads/)

R (https://www.rstudio.com/products/rstudio/download/))

MATLAB R2021a or later (https://itssc.rpi.edu/hc/en-us/articles/360016199671-MatLab-License-Renewal-and-Activation)


# User Instructions


