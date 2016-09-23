function [mu, betanew] = stochGradDescentIter(X,Y,beta,alpha,lambda,i)
%Gradient Descent method
gradientB=2*lambda*beta-X(i,:)'*(1-1/(1+exp(-beta'*X(i,:)')))...
        +(1-Y(i))*X(i,:)';
betanew=beta-alpha*gradientB;
mu=(1./(1+exp(-betanew'*X')))';

end

