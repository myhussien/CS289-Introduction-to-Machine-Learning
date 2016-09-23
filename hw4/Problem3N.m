%%
%CS 289 Homework 4
%Problem 3
%Jiaying Shi
%SID: 24978491
%shijy07@berkeley.edu
%%
clear all;
clc;
%%
load 'spam.mat';
ytrain=double(ytrain);
% Normalize data
XtrainN=processTrainData(Xtrain,1);
XtrainN=[ones(length(ytrain),1) XtrainN];
lambdaN=0.01;
alphaN=0.35;
beta=zeros(size(XtrainN,2),1);
betaPrev=beta;
muN=[];
betaIterN=[];
epsilon=0.0001;
prevMu=zeros(length(ytrain),1);
lossN=[];
M=length(ytrain);
prevLossN=1;
for iter=1:200
    [mui,beta]=gradientDescentIter(XtrainN,ytrain,beta,alphaN,lambdaN);
    muN=[muN mui];
    betaIterN=[betaIterN beta];
    lossIter=lambdaN*norm(beta)^2-1/M*ytrain'*log(mui+0.000001)-1/M*(1-ytrain)'*log(1-mui+0.000001);
    dprevLossN=lossIter;
    diff=prevLossN-lossIter;
    lossN=[lossN;lossIter];
    if(abs(diff)<epsilon)
        break;
    end
end
P3N=plot(1:length(lossN),lossN);
title('Batch Gradient Descent Method using data preprocessed using i)');
xlabel('Iteration');
ylabel('Loss');
saveas(P3N,'p3N.jpg');
