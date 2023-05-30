% Dummy variable input data
X = table2array(X_values); % Example dummy variable input matrix
Y = table2array(Y_values); % Example categorical response vector
% Dummy variable input data
X = table2array(Y_values); % Example dummy variable input matrix
Y = table2array(X_values); % Example categorical response vector

% Fit PLS-DA model
ncomp = 2; % Number of components to retain
[Xloadings, Yloadings, Xscores, ~, ~, ~, PLScoefficients] = plsregress(X, (Y), ncomp);

% Leave-One-Out Cross Validation
numSamples = size(X, 1);
predictedLabels = zeros(numSamples, 1);
for i = 1:numSamples
    % Exclude i-th sample from the training set
    Xtrain = X;
    Xtrain(i, :) = [];
    Ytrain = Y;
    Ytrain(i, :) = [];
    
    % Fit PLS-DA model without the i-th sample
    [XloadingsCV, YloadingsCV, XscoresCV, ~, ~, ~, PLScoefficientsCV] = plsregress(Xtrain, (Ytrain), ncomp);
    
    % Predict the class label for the i-th sample
    xTest = X(i, :);
    xTest = [1 xTest]; % Add a column of ones for the intercept
    ypredCV = [1 xTest] * PLScoefficientsCV'; % Include the intercept in the prediction
    [~, predictedLabels(i)] = max(ypredCV);
end

% Calculate accuracy of the fit
accuracy = sum(predictedLabels == Y) / numSamples;
disp("Accuracy of the fit (LOOCV):")
disp(accuracy)