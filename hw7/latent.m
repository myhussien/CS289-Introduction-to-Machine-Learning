%%
%CS289 Homework 7 Problem 2 Latent
%Jiaying Shi
%SID: 24978491
%shijy07@berkeley.edu
%%
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
%%
%PCA
%
%Process Data
% meanTrain=mean(trainData);
% stdTrain=std(trainData);
% trainDataMeanRemv=trainData;
% for i=1:nJoke
%     trainDataMeanRemv(:,i)=trainData(:,i)-ones(nPeople,1)*meanTrain(i);
% end
[U,S,V]=svd(trainData,0);
d=[2,5,10,20];
nd=length(d);
error=zeros(nd,1);
errorPredict=zeros(nd,1);
indxNAN=1-isnan(train);
for i=1:nd
    sPredictPCA=zeros(nValidate,1);
    RPredictPCA=zeros(100,nJoke);
    newS=S(1:d(i),1:d(i));
    newU=U(:,1:d(i));
    newV=V(:,1:d(i));
    REst=newU*newS*newV';
    errorEst=norm((REst-trainData).*indxNAN,'fro')^2;
    error(i)=errorEst;
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
    errorPredict(i)=sum(abs(sPredictPCA-validate_s))/nValidate;    
end
f1=figure;
plot(d,errorPredict);
xlabel('d');
ylabel('Error Rate on Validation Set');
saveas(f1,'latentPredictplot.jpg');
f1=figure;
plot(d,error);
xlabel('d');
ylabel('MSE');
saveas(f1,'latentMSEplot.jpg');
