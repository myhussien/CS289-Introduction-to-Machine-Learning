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
%Part d ii)
nTests=length(nSample);
k=5;
for i=1:nTests
    sampleSize=nSample(i);
    results2(i).sampleSize=sampleSize;
    indx=randsample(nTrain,sampleSize);
    trainData=train_data(:,indx);
    trainLabel=train_label(indx);
    epsilon=[1];
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
            [mu,sigma]=trainDigit(tData,tLabel,2);
            dtSCV=zeros(10,1);
            for is=1:10
                sigma(:,:,is)=sigma(:,:,is)+epsilon(j)*eye(np);
                inv_SCV(:,:,is)=inv(sigma(:,:,is));
                dtSCV(is)=det(sigma(:,:,is));
            end
            %validation
            [errorRate,predictionCV]=testDigit(vData,vLabel,mu,inv_SCV,dtSCV,ni,2);
            error(m)=errorRate;
        end
        errorEpsilon(j)=mean(error);
    end
    find best epsilon
    [eBest,indxE]=min(errorEpsilon);
    bestEpsilon(i)=epsilon(indxE);
    %train on the whole sample
    [muT,sigmaT]=trainDigit(trainData,trainLabel,2);
    dtSigma=zeros(10,1);
    bestEpsilon(i)=1;
    for dt=1:10
        sigmaT(:,:,dt)=sigmaT(:,:,dt)+bestEpsilon(i)*eye(np);
        dtSigma(dt)=det(sigmaT(:,:,dt));
        inv_sigma(:,:,dt)=inv(sigmaT(:,:,dt));
    end
    results2(i).mu=muT;
    results2(i).sigma=sigmaT;
    results2(i).epsilon=bestEpsilon(i);
    %test results
    
    [error,prediction]=testDigit(test_data,test_label,muT,inv_sigma,dtSigma,ni2);
    results2(i).errorRate=error;
end
eR=zeros(nTests,1);
for i=1:nTests
    eR(i)=results2(i).errorRate;
end
d2=plot(1:nTests,eR);
