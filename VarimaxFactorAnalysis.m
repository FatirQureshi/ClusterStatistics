function Model = VarimaxFactorAnalysis(X0)
[n,N]   =  size(X0);
% Estimate sample correlation matrix
Rx      =  X0'*X0/(n-1);
% Compute eigendecomposition of sample correlation matrix
[P,S,~] =  svd(Rx,0);
% Estimate the number of factors

bar(diag(S),'w','LineWidth',2.0), hold on
m       =  input('How many factors : ');
% Store the dominant principal directions in the matrix P0
P0      =  P(:,1:m);
% Compute the principal components
T       =  X0*P0;

% Calculate the average eigenvalue (from the N-m "discarded" ones)
l_mean  =  mean(diag(S(m+1:N,m+1:N)));
% Scale the matrix of eigenvalues, so that the scores have a unit variance
B       =  P0*(S(1:m,1:m)^0.5);
U       =  T*(S(1:m,1:m))^(-0.5);
% Varimax roatation - square the values of the coefficient matrix B
B4      =  B.^4;
% Mean center the squared values values of the coefficient matrix B
B40      =  (eye(N) - (1/N)*ones(N,1)*ones(1,N))*B4;
% Square the values of the centered (squared) matrix B0
[~,~,V]  =  svd(B40,0);
% Determining the factor loadings and the factor scores

A        =  P0*V;
F        =  U*V';
Model.A = A;
Model.F = F;
Model.V = V;