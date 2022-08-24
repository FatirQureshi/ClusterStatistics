# ClusterStatistics

The purpose of this project was to run various forms of statistical analysis and visualize data. 
It was originally designed with the intention of performing analysis using t-distributed stochastic neighbor embedding and varimax factor analysis.


# Overview
This package is designed to visualize the results of t-distributed stochastic neighbor embedding (t-SNE), varimax factor analysis (VFA) and Partial least squares discriminant analysis (PLS-DA). 
## t-Distributed Stochastic Neighbor Embedding 
The purpose of t-SNE is to better visualize high dimensional data. This technique operates by constructing a probability density function between pairs of high dimensional objects. The objects that are closer in multidimensional space are assigned a higher probability value, while more distant objects are given a lower probability. However, one of the primary limitations of this technique is that it does not preserve distances associated with dissimilarity well in lower dimensional space. For this reason, this technique should not be used for dimensionality reduction.  
## Partial least squares discriminant analysis 
Partial least squares discriminant analysis (PLS-DA) is defined as a variant of partial least squares regression when the dependent variable is categorical. PLS is especially useful in cases where there are many predictors which are highly collinear. Unlike FA, PLS-DA is a supervised learning approach where training data is utilized to fit a model. This technique is composed of two main parts, dimensionality reduction and model fitting. Membership in the predictor group is treated as a dummy matrix and is paired with the training data derived from the independent variables.  Partial least square components are derived such that the covariance between the independent variables X and the dependent variables Y is maximized. 
## Mahalanobis distance 

The Mahalanobis distance is a metric used to quantify the proximity between a point in n-dimensional space and the mean of a distribution D.  Mahalanobis distance is distinct from Euclidean distance as it takes into consideration the covariance matrix between variables and can account for different variables following different scales. Utilizing this metric, the degree to which values deviate from their respective groups centroids as well as the distinctiveness between differing groups can be quantified. 

# Installation

Please ensure that 

# User Instructions

Please ensure that 
