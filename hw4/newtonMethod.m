function newBeta=newtonMethod(beta,X,Y,lambda)
newBeta=beta;
n=length(beta);
Hessian=2*lambda*eye(n);
gradientB=2*lambda*beta;
for i=1:length(Y)
    Hessian=Hessian+exp(-beta'*X(i,:)')*X(i,:)'*X(i,:)/((1+exp(-beta'*X(i,:)'))^2);
    gradientB=gradientB-exp(-beta'*X(i,:)')*X(i,:)'/(1+exp(-beta'*X(i,:)'))...
        +(1-Y(i))*X(i,:)';
end
newBeta=newBeta-inv(Hessian)*gradientB;
