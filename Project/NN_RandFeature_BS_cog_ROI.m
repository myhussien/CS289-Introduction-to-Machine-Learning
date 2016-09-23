clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%%
%Load Data
% load 'sent_RoI_act_mean.mat'
load 'state_RoI_act_avg.mat'
nIn=24;
nHid=15;
nOut=3;
% trainDataRaw=[train_pic1;train_pic2;train_pic4;train_pic5];
% trainLabel=[train_pic_label1;train_pic_label2;train_pic_label4;train_pic_label5];
trainDataRaw=[];
trainLabel=[];

for i=1:50
    temp1=cell2mat(act_mean1(i));
    temp2=cell2mat(act_mean2(i));
    temp4=cell2mat(act_mean4(i));
    temp5=cell2mat(act_mean5(i));
    for j=1:size(temp1,1)
      trainDataRaw=[trainDataRaw;temp1(j,:)];
      trainLabel=[trainLabel;labels1(i)];
    end
    for j=1:size(temp2,1)
      trainDataRaw=[trainDataRaw;temp2(j,:)];
      trainLabel=[trainLabel;labels2(i)];
    end
    for j=1:size(temp4,1)
      trainDataRaw=[trainDataRaw;temp4(j,:)];
      trainLabel=[trainLabel;labels4(i)];
    end
    for j=1:size(temp5,1)
      trainDataRaw=[trainDataRaw;temp5(j,:)];
      trainLabel=[trainLabel;labels5(i)];
    end
%     trainDataRaw=[trainDataRaw;reshape(temp1(1:54,:),1,1296)];
%     trainDataRaw=[trainDataRaw;reshape(temp2(1:54,:),1,1296)];
%     trainDataRaw=[trainDataRaw;reshape(temp4(1:54,:),1,1296)];
%     trainDataRaw=[trainDataRaw;reshape(temp5(1:54,:),1,1296)];
%     trainLabel=[trainLabel;labels1(i);labels2(i);labels4(i);labels5(i);];
end
for i=1:49
    temp3=cell2mat(act_mean3(i));
    for j=1:size(temp3,1)
      trainDataRaw=[trainDataRaw;temp3(j,:)];
      trainLabel=[trainLabel;labels3(i)];
    end
%    trainDataRaw=[trainDataRaw;reshape(temp3(1:54,:),1,1296)];
%    trainLabel=[trainLabel;labels3(i)]; 
end

n=size(trainLabel,1);
nTest=1000;
%%
%Preprocess
indx=randsample(n,n);
trainData=trainDataRaw(indx,:);
trainLabel=trainLabel(indx);
%%
%reshape data
meanTrain=mean(trainData);
stdTrain=std(trainData);
for i=1:size(trainData,2);
    if(stdTrain(i)~=0)
        trainData(:,i)=(trainData(:,i)-meanTrain(i))/stdTrain(i);
    end
end
%%
%get validation data
train_Data=trainData((nTest+1):n,:);
train_Label=trainLabel((nTest+1):n);
test_Data=trainData(1:nTest,:);
test_Label=trainLabel(1:nTest);
nBS=1;
nTrain=length(train_Label);
%%
%
predictLabel=zeros(nTest,1);
nnOutput=zeros(nTest,nOut);
weight=[];
for bs=1:nBS
maxIter=5000;
stepSize=1;
nAvg=1000;
indxBS=randsample(nTrain,nTrain);
train_DataBS=train_Data(indxBS,:);
train_LabelBS=train_Label(indxBS);

indxF=randsample(24,24);
train_DataBS=train_DataBS(:,indxF);
test_DataBS=test_Data(:,indxF);
test_LabelBS=test_Label;
% validationData=[];
% validationLabel=[];
% for j=1:nTrain
%     if sum(indxBS==j)==0
%         validationData=[validationData;train_Data(j,indxF)];
%         validationLabel=[validationLabel;train_Label(j)];     
%     end
% end
tic;
[W1BS,W2BS,accuracyClassification,trainError]=trainNNcog(train_DataBS,train_LabelBS,nHid,nOut,2,maxIter,stepSize,nAvg);
toc;
% [errorRateV,predictLabelBSV,nnOutputBSV]= predictNNcog(W1BS,W2BS,validationData,validationLabel);
[errorRate,predictLabelBS,nnO]= predictNNcog(W1BS,W2BS,test_DataBS,test_LabelBS);
% weight=[weight;1/errorRateV];
% nnOutput(:,:,bs)=nnOutputBS;
end
[maxOut, predictLabel] = max(nnO, [], 2);
errorRate=sum(predictLabel~=test_Label)/nTest;
f1=plot(trainError);
title('Cross-Entropy Error over Iteration');
xlabel('Iteration');
ylabel('Cross-Entropy Error');
% saveas(f1,'CE.jpg');

f2=figure;
plot(accuracyClassification);
title('Classification Accuracy with Cross-Entropy Error');
xlabel('Iteration');
ylabel('Classification Accuracy');
% saveas(f2,'CE_accu.jpg');
