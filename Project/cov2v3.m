clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%%
%Load Data
%pca
% cd '.\2VS3\person4'
% trainLabel=csvread('train_label_4.csv');
% trainDataRaw=csvread('train_pca_4.csv');
% testLabel=csvread('test_label_4.csv');
% testData=csvread('test_pca_4.csv');
% cd '..\..';
% nIn=size(trainDataRaw,2);
% nHid=49;
%plsr
% cd '.\2VS3\person5'
% trainLabel=csvread('train_label_5.csv');
% trainDataRaw=csvread('train_plsr_5.csv');
% testLabel=csvread('test_label_5.csv');
% testData=csvread('test_plsr_5.csv');
% cd '..\..';
% nIn=size(trainDataRaw,2);
% nHid=49;
% %rrf
cd '.\2VS3\person4'
trainLabel=csvread('train_label_4.csv');
trainDataRaw=csvread('train_rrf_4.csv');
testLabel=csvread('test_label_4.csv');
testData=csvread('test_rrf_4.csv');
cd '..\..';
nIn=size(trainDataRaw,2);
nHid=8;
%%
nOut=2;
n=size(trainLabel,1);
nTest=size(testLabel,1);
%%
%Preprocess
testLabel=testLabel-ones(length(testLabel),1);
trainLabel=trainLabel-ones(length(trainLabel),1);
indx=randsample(n,n);
trainData=trainDataRaw(indx,:);
trainLabel=trainLabel(indx);
meanTrain=mean(trainData);
stdTrain=std(trainData);
meanTest=mean(testData);
stdTest=std(testData);
for i=1:size(trainData,2);
    if(stdTrain(i)~=0)
        trainData(:,i)=(trainData(:,i)-meanTrain(i))/stdTrain(i);
    end
end
for i=1:size(testData,2);
    if(stdTest(i)~=0)
        testData(:,i)=(testData(:,i)-meanTest(i))/stdTest(i);
    end
end
%%
%get validation data
nBS=10;
nTrain=length(trainLabel);
%%
%
predictLabel=zeros(nTest,1);
nnOutput=zeros(nTest,nOut);
for bs=1:nBS
maxIter=5000;
stepSize=1;
nAvg=120;
indxBS=randsample(nTrain,120);
train_DataBS=trainData(indxBS,:);
train_LabelBS=trainLabel(indxBS);
% indxF=randsample(56,48);
indxF=randsample(nIn,floor(0.9*nIn));
% indxF=randsample(12,12);
train_DataBS=train_DataBS(:,indxF);
test_DataBS=testData(:,indxF);
test_LabelBS=testLabel;
tic;
[W1BS,W2BS,accuracyClassification,trainError]=trainNN(train_DataBS,train_LabelBS,nHid,nOut,2,maxIter,stepSize,nAvg);
toc;
[errorRate,predictLabelBS,nnOutputBS]= predictNN(W1BS,W2BS,test_DataBS,test_LabelBS);
nnOutput=nnOutput+nnOutputBS/nBS;
end
[maxOut, predictLabel] = max(nnOutput, [], 2);
errorRate=sum(predictLabel~=testLabel)/nTest;
% f1=plot(trainError);
% title('Cross-Entropy Error over Iteration');
% xlabel('Iteration');
% ylabel('Cross-Entropy Error');
% % saveas(f1,'CE.jpg');
% 
% f2=figure;
% plot(accuracyClassification);
% title('Classification Accuracy with Cross-Entropy Error');
% xlabel('Iteration');
% ylabel('Classification Accuracy');
% % saveas(f2,'CE_accu.jpg');
