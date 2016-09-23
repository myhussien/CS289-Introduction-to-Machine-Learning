%%
%CS289 Homework 7 Problem 2 Warm up
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
nValidate=length(validate_i);
nPeople=size(train,1);
nJoke=size(train,2);
spredictAll=(nanmean(train)>0);
spredict=zeros(nValidate,1);
for i=1:length(validate_i)
    if(spredictAll(validate_j(i))==1)
        spredict(i)=1;
    end
end
errorRate=sum(abs(spredict-validate_s))/nValidate;
%%
train(isnan(train))=0;
k=[10,100,1000];
error=zeros(3,1);

nK=length(k);
for i=1:nK
    RPredictKNN=zeros(100,nJoke);
    sPredictKNN=zeros(nValidate,1);
    for n=1:100
        Rtemp=train;
        dataN=Rtemp(n,:);
        Rtemp(n,:)=[];
        [indx,d]=knnsearch(Rtemp,dataN,'k',k(i));
        RPredictKNN(n,:)=(mean(Rtemp(indx,:))>0);        
    end
    for j=1:nValidate
        sPredictKNN(j)=RPredictKNN(validate_i(j),validate_j(j));
    end
    error(i)=sum(abs(sPredictKNN-validate_s))/nValidate;
end
f1=figure;
plot(k,error);
xlabel('k');
ylabel('Error Rate on Validation Set');
saveas(f1,'warmupplot.jpg');