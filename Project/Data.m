clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%%
%Load Data
% load 'sent_RoI_act_mean.mat'
load 'state_RoI_avg.mat'
nIn=54*24;
nHid=250;
nOut=3;
trainDataRaw=[];
trainLabel=[];

for i=1:50
    temp1=cell2mat(data1(i));
    temp2=cell2mat(data2(i));
    temp4=cell2mat(data4(i));
    temp5=cell2mat(data5(i));
    trainDataRaw=[trainDataRaw;reshape(temp1(1:54,:),1,1296)];
    trainDataRaw=[trainDataRaw;reshape(temp2(1:54,:),1,1296)];
    trainDataRaw=[trainDataRaw;reshape(temp4(1:54,:),1,1296)];
    trainDataRaw=[trainDataRaw;reshape(temp5(1:54,:),1,1296)];
    trainLabel=[trainLabel;labels1(i);labels2(i);labels4(i);labels5(i);];
end
for i=1:49
    temp3=cell2mat(data3(i));
   trainDataRaw=[trainDataRaw;reshape(temp3(1:54,:),1,1296)];
   trainLabel=[trainLabel;labels3(i)]; 
end

n=size(trainLabel,1);
nTest=50;
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
nTrain=length(trainLabel);
for i=1:nTrain
    trainlabel(i,trainLabel(i))=1;
end
trainData=trainData';
trainlabel=trainlabel';

