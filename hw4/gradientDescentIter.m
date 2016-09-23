function [mu, betanew] = gradientDescentIter(X,Y,beta,alpha,lambda)
%Gradient Descent method
gradientB=2*lambda*beta;
M=length(Y);
for i=1:M
    gradientB=gradientB-1/M*X(i,:)'*(1-1/(1+exp(-beta'*X(i,:)')))...
        +1/M*(1-Y(i))*X(i,:)';
end
betanew=beta-alpha*gradientB;
mu=(1./(1+exp(-betanew'*X')))';

end

