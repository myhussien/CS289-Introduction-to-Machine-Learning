clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%%
%Load Data
load 'train.mat'
load 'test.mat'
nIn=size(train_images,1)*size(train_images,2);
nHid=200;
nOut=10;
n=size(train_labels,1);
nTest=size(test_images,3);
%%
%Preprocess
indx=randsample(n,n);
train_dataraw=train_images(:,:,indx);
train_label=train_labels(indx);
train_dataProcessed=[];
for i=1:n
    grayImage=train_dataraw(:,:,i);
    lvl = graythresh(grayImage);
    processedImage = im2bw(grayImage,lvl);
    train_dataraw(:,:,i)=processedImage;
end
for i=1:nTest
    grayImage=test_images(:,:,i);
    lvl = graythresh(grayImage);
    processedImage = im2bw(grayImage,lvl);
    test_images(:,:,i)=processedImage;
end
%%
%reshape data
train_dataT=reshape(train_dataraw,nIn,n);
train_data=train_dataT';
meanTrain=mean(train_data);
stdTrain=std(train_data);
test_dataT=reshape(test_images,nIn,nTest);
test_data=test_dataT';
meanTest=mean(test_data);
stdTest=std(test_data);
for i=1:size(train_data,2);
    if(stdTrain(i)~=0)
        train_data(:,i)=(train_data(:,i)-meanTrain(i))/stdTrain(i);
    end
    if(stdTest(i)~=0)
        test_data(:,i)=(test_data(:,i)-meanTest(i))/stdTest(i);
    end
end
%%
%get validation data
nValidation=6000;
trainData=train_data((nValidation+1):n,:);
trainLabel=train_label((nValidation+1):n);
validationData=train_data(1:nValidation,:);
validationLabel=train_label(1:nValidation);

%%
%
maxIter=2000;
stepSize=0.005;
nAvg=500;
tic;
[W1,W2,accuracyClassification,trainError]=trainNN(trainData,trainLabel,nHid,nOut,1,maxIter,stepSize,nAvg);
toc;
[errorRate,predictLabel,nnOutput]= predictNN(W1,W2,validationData,validationLabel);
% plot the results
F1=figure;
plot(1:maxIter, trainError);
title('Training Error(MSE)');
xlabel('Iteration');
ylabel('MSE');
saveas(F1,'MSE.jpg');

F2=figure;
plot(1:maxIter, accuracyClassification);
title('Classification Accuracy(MSE)');
xlabel('Iteration');
ylim([0,1]);
ylabel('Classification Accuracy Rate');
saveas(F2,'MSE_accu.jpg');

