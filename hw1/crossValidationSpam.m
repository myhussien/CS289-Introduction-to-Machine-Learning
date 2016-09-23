clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%Code for Problem 4
%%
%Load Data
cd '.\data\spam-dataset';
load 'spam_data.mat'
cd '..\..';
n=size(training_labels,2);
k=12;
nV=n/k;
train_matrix=sparse(training_data);
train_label=double(training_labels');
%%
C=0.1:0.05:4;
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
model=train(train_label,train_matrix,[['-c ' num2str(bestC)]]);
vali=ones(size(test_data,1),1);
test_matrix=sparse(test_data);
[predictedLabel,accuracyR,probest]=predict(vali,test_matrix,model);