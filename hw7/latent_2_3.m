clear all;
clc;
cd '.\joke_data';
load 'joke_train.mat';
load 'validate.mat';
load 'test.mat';
cd '..';
%%
trainData=train;
trainData(isnan(trainData))=0;
nValidate=length(validate_i);
nPeople=size(train,1);
nJoke=size(train,2);
nTest=length(test_i);
[U,S,V]=svd(trainData,0);
nF=10;

lambdaSet=[0.1,1,10];
delta=100000;
epsilon=0.00001;
indxMatrix=1-isnan(train);

errorPredict=zeros(length(lambdaSet),1);
for ll=1:length(lambdaSet)
    lambda=lambdaSet(ll);
    Uini=U(:,1:nF)*sqrt(S(1:nF,1:nF));
    Vini=sqrt(S(1:nF,1:nF))*V(:,1:nF)';
    iniError=MSECost(Uini,Vini,lambda,train);
    while delta>epsilon
        %minimize cost function over U
        for i=1:nPeople
            hessianMatrixU=zeros(nF,nF);
            vecU=zeros(nF,1);
            for j=1:nJoke
                if indxMatrix(i,j)==1
                    hessianMatrixU=hessianMatrixU+Vini(:,j)*Vini(:,j)';
                    vecU=vecU+Vini(:,j)*trainData(i,j);
                end
            end
            hessianMatrixU=hessianMatrixU+lambda*eye(nF);
            Uini(i,:)=(hessianMatrixU\vecU)';
        end
        %minimize cost function over V
        for j=1:nJoke
            hessianMatrixV=zeros(nF,nF);
            vecV=zeros(nF,1);
            for i=1:nPeople
                if indxMatrix(i,j)==1
                    hessianMatrixV=hessianMatrixV+Uini(i,:)'*Uini(i,:);
                    vecV=vecV+Uini(i,:)'*trainData(i,j);
                end
            end
            hessianMatrixV=hessianMatrixV+lambda*eye(nF);
            Vini(:,j)=hessianMatrixV\(vecV);
        end
        error=MSECost(Uini,Vini,lambda,train);
        delta=(iniError-error)/error;
        iniError=error;
    end
    REst=Uini*Vini;
    sPredictPCA=zeros(nValidate,1);
    RPredictPCA=zeros(100,nJoke);
    for n=1:100
        Rtemp=REst;
        dataN=Rtemp(n,:);
        Rtemp(n,:)=[];
        [indx,dist]=knnsearch(Rtemp,dataN,'k',1000);
        RPredictPCA(n,:)=(mean(Rtemp(indx,:))>0);        
    end
    for j=1:nValidate
        sPredictPCA(j)=RPredictPCA(validate_i(j),validate_j(j));
    end
    errorPredict(ll)=sum(abs(sPredictPCA-validate_s))/nValidate;
end
[ee,indB]=min(errorPredict);
lambdaBest=lambdaSet(indB);

