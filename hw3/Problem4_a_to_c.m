%%
%CS289 Problem 4 Part a)- Part c)
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
%Part a
mu=[];
sigma=zeros(np,np,10);
ni=zeros(10,1);
epsilon=1;
for i=0:9
    data_i=train_data(:,(train_label==i));
    ni(i+1,1)=size(data_i,2);
    mui=mean(data_i');
    sigmai=cov(data_i',1);
    mu=[mu mui'];
    sigma(:,:,i+1)=sigmai+epsilon*eye(np);
end
ni=ni/nTrain;
%%
%Part c
sigma0=(sigma(:,:,1)-epsilon*eye(np));
fc=imagesc(sigma0);
title('Covariance Matrix of Digit 0');
saveas(fc,'p4pc.jpg')

