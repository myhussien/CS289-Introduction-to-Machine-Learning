%%
%CS289 Problem 4 Part d)
%Jiaying Shi
%shijy07@berkeley.edu
%%
clear all;
clc;
%%
%Load Data
load 'train.mat'
load 'test.mat'
load 'kaggle.mat'
load 'ni.mat'
nTrain=length(train_label);
nTest=length(test_label);
nKaggle=5000;
np=size(train_image,1)*size(train_image,2);
nSample=[100, 200, 500, 1000, 2000, 5000, 10000, 30000, 60000];
% nSample=[60000];
%%
%Process Data, normalize images
train_data=reshape(train_image,np,nTrain);
test_data=reshape(test_image,np,nTest);
kaggle_data=reshape(kaggle_image,np,nKaggle);
for i=1:nTrain
    train_data(:,i)=train_data(:,i)/norm(train_data(:,i),2);
end
for i=1:nTest
    test_data(:,i)=test_data(:,i)/norm(test_data(:,i),2);
end
for i=1:nKaggle
    kaggle_data(:,i)=kaggle_data(:,i)/norm(kaggle_data(:,i),2);
end
%%
%Part d i)
nTests=length(nSample);
k=5;
for i=1:nTests
    sampleSize=nSample(i);
    results1(i).sampleSize=sampleSize;
    indx=randsample(nTrain,sampleSize);
    trainData=train_data(:,indx);
    trainLabel=train_label(indx);
    epsilon=[0.000001,0.001,0.1,1,10];
    nE=length(epsilon);
    nV=sampleSize/k;
    %
    %Select best epsilon
    errorEpsilon=zeros(nE,1);
        for j=1:nE
            error=zeros(10,1);
            for m=1:k
                vData=trainData(:,(nV*(m-1)+1):(nV*m));
                vLabel=trainLabel((nV*(m-1)+1):(nV*m));
                tData=trainData;
                tLabel=trainLabel;
                tData(:,(nV*(m-1)+1):(nV*m))=[];
                tLabel((nV*(m-1)+1):(nV*m))=[];
                %get mu and sigma for each class
                mu=zeros(np,10);
                sigma=zeros(np,np);
                [mu,sigma]=trainDigit(tData,tLabel,1);
                sigma=sigma/10+epsilon(j)*eye(np);
                %validation
                inv_sigmaCV=inv(sigma);
                errorRate=testDigit(vData,vLabel,mu,inv_sigmaCV,1,ni,1);
                error(m)=errorRate;
            end
            errorEpsilon(j)=mean(error);
        end
%     find best epsilon
        [eBest(i),indxE]=min(errorEpsilon);
        bestEpsilon(i)=epsilon(indxE);
%     train on the whole sample

    [muT,sigmaT]=trainDigit(trainData,trainLabel,1);
    sigmaT=sigmaT/10+bestEpsilon(i)*eye(np);
    results1(i).mu=muT;
    results1(i).sigma=sigmaT;
    results1(i).epsilon=bestEpsilon(i);
    %test results
    inv_sigma=inv(sigmaT);
    [error,prediction]=testDigit(test_data,test_label,muT,inv_sigma,1,ni,1);
    results1(i).errorRate=error;
end

eR=zeros(nTests,1);
 for i=1:nTests
    eR(i)=results1(i).errorRate;
 end
d1=plot(1:nTests,eR);
% saveas(d1,'p4d1.jpg');
kaggle_label=ones(nKaggle,1);
[errorK,predictionK]=testDigit(kaggle_data,kaggle_label,muT,inv_sigma,1,ni,1);
