clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%Code for Problem1 and Problem 2
%%
%Load Data
cd '.\data\digit-dataset';
load 'train.mat'
cd '..\..';
np=size(train_images,1)*size(train_images,2);
n=size(train_labels,1);
ns=20000;
nValidation=10000;
indx=randsample(n,ns);
%%
%reshape data
train_dataT=reshape(train_images,np,n);
train_data=train_dataT(:,indx)';
train_data=sparse(train_data);
train_label=train_labels(indx);
%%
%problem 1
validation_matrix=train_data((nValidation+1):ns,:);
validation_label=train_label((nValidation+1):ns,:);
sampleSize=[100, 200, 500, 1000, 2000, 5000, 10000];
nTest=length(sampleSize);
accuracy=[];
predicted_label=[];
for i=1:nTest
    trainTest_matrix=train_data(1:sampleSize(i),:);
    trainTest_label=train_label(1:sampleSize(i));
    modelTest=train(trainTest_label,trainTest_matrix);
    [predictedTest_label, accuracyTest, prob_estimates] = ...
        predict(validation_label,...
        validation_matrix, modelTest);
    accuracy=[accuracy,accuracyTest];
    predicted_label=[predicted_label,predictedTest_label];
    
    
    
end
accuracyPlot=accuracy(1,:)/100;
figure
stem(sampleSize,accuracyPlot,'*');

%%
%problem 2
confusion_matrix=[];
figure
for i=1:nTest
    confusion_matrix_test=zeros(10,10);
    for j=1:10
        numJ=ones(nValidation,1)*(j-1);
        predLabelNumJ=(predicted_label(:,i)==numJ);
        for k=1:10
            numK=ones(nValidation,1)*(k-1);
            valiLabelNumK=(validation_label==numK);
            confusion_matrix_test(k,j)=sum(valiLabelNumK&predLabelNumJ);
        end
    end
    subplot(3,3,i), imagesc(confusion_matrix_test);
    confusion_matrix=[confusion_matrix,confusion_matrix_test];
end
