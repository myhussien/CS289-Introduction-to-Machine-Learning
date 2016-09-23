clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%Code for Problem 3
%%
%Load Data
cd '.\data\digit-dataset';
load 'train.mat'
load 'test.mat'
cd '..\..';
np=size(train_images,1)*size(train_images,2);
n=size(train_labels,1);
ns=10000;
k=10;
indx=randsample(n,2*ns);
train_dataraw=train_images(:,:,indx);
train_dataProcessed=zeros(ns*2,144);
for i=1:(2*ns)
    grayImage=train_dataraw(:,:,i);
    lvl = graythresh(grayImage);
    processedImage = im2bw(grayImage,lvl);
    train_dataraw(:,:,i)=processedImage;
    train_dataProcessed(i,:)=hog_feature_vector(processedImage);
end
test_matrix=zeros(ns,144);
for i=1:ns
    grayImage=test_images(:,:,i);
    lvl = graythresh(grayImage);
    processedImage = im2bw(grayImage,lvl);
    test_images(:,:,i)=processedImage;
    test_matrix(i,:)=hog_feature_vector(processedImage);
end
%%
%reshape data
% train_dataT=reshape(train_dataraw,np,ns*2);
% train_data=train_dataT(:,indx)';
% train_data=train_dataT';
train_matrix=sparse(train_dataProcessed(1:ns,:));
train_labelall=train_labels(indx);
train_label=train_labelall(1:ns);
validation_matrix=sparse(train_dataProcessed((ns+1):(2*ns),:));
validation_label=train_labelall((ns+1):(ns*2));
nV=ns/k;
XX=reshape(test_images,np,10000)';
%%
C=0.1:0.1:10;
% C=[1 2];
nC=length(C);
accuracy=[];
for i=1:nC
    %Cross Validation
    accuracyC=[];
    for j=1:k
        validationCV_matrix=train_matrix((nV*(j-1)+1):(nV*j),:);
        validationCV_label=train_label((nV*(j-1)+1):(nV*j));
        trainTemp_matrix=train_matrix;
        trainTemp_label=train_label;
        trainTemp_matrix((nV*(j-1)+1):(nV*j),:)=[];
        trainTemp_label((nV*(j-1)+1):(nV*j))=[];
        trainCV_matrix=trainTemp_matrix;
        trainCV_label=trainTemp_label;
        modelCV=train(trainCV_label,trainCV_matrix,[['-c ' num2str(C(i))]]);
        [predictedCV_label, accuracyCV, prob_estimatesCV] = ...
            predict(validationCV_label,...
            validationCV_matrix, modelCV);
        accuracyC=[accuracyC,accuracyCV(1)/100];
    end
    accuracyResult=[C(i);mean(accuracyC)];
    accuracy=[accuracy accuracyResult];
end
[bestAccuracy,indxMax]=max(accuracy(2,:));
bestC=accuracy(1,indxMax);
modelTest=train(train_label,train_matrix,[['-c ' num2str(bestC)]]);
[predictedTest_label, accuracyTest, prob_estimatesTest] = ...
    predict(validation_label,...
    validation_matrix, modelTest);
testdata=sparse(test_matrix);
vali=0:9999;
vali=vali';
[predictedLabel,accuracyR,probest]=predict(vali,testdata,modelTest);