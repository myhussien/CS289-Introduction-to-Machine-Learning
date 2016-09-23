%%
%CS289 Problem 4 Part d)
%Jiaying Shi
%shijy07@berkeley.edu
%%
clear all;
clc;
%%
%Load Data
load 'spam_data.mat'
load 'testlabel.mat'
np=size(training_data,2);
n=size(training_labels,2);
trainData=training_data';
testData=test_data';
trainLabel=double(training_labels');
% testLabel=zeros(size(testData,2),1);
nSpam=sum(trainLabel);
Prior=[1-nSpam/n;nSpam/n];
% Prior=[1;1];
k=12;
nV=n/k;
epsilon=[0.0000001,0.000001,0.00001,0.0001,0.01,0.1,1];
nE=length(epsilon);
indx=randsample(n,n);
trainLabel=trainLabel(indx);
trainData=trainData(:,indx);
%%
%cross validation
%

for i=1:nE
    for m=1:k
        vData=trainData(:,(nV*(m-1)+1):(nV*m));
        vLabel=trainLabel((nV*(m-1)+1):(nV*m));
        tData=trainData;
        tLabel=trainLabel;
        tData(:,(nV*(m-1)+1):(nV*m))=[];
        tLabel((nV*(m-1)+1):(nV*m))=[];
        %get mu and sigma for each class
        mu=zeros(np,2);
        sigma=zeros(np,np);
        [mu,sigma]=trainSpam(tData,tLabel,1);
        sigma=sigma/2+epsilon(i)*eye(np);
        %validation
        inv_sigmaCV=inv(sigma);
        [errorRate,predictionCV]=testSpam(vData,vLabel,mu,inv_sigmaCV,1,Prior,1);
        error(m)=errorRate;               
    end
    errorEpsilon(i)=mean(error);
end
%     find best epsilon
        [eBest,indxE]=min(errorEpsilon);
        bestEpsilon=epsilon(indxE);
%     train on the whole sample

    [muT,sigmaT]=trainSpam(trainData,trainLabel,1);
    sigmaT=sigmaT/2+bestEpsilon*eye(np);
    results1.mu=muT;
    results1.sigma=sigmaT;
    results1.epsilon=bestEpsilon;
    %test results
    inv_sigma=inv(sigmaT);
    [error,prediction]=testSpam(testData,testLabel,muT,inv_sigma,1,Prior,1);
    results1.errorRate=error;