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
alphaN=0.1;
beta=ones(size(XtrainN,2),1);
betaPrev=beta;
muN=[];
betaIterN=[];
epsilon=0.000001;
prevMu=zeros(length(ytrain),1);
lossN=[];
M=length(ytrain);
prevLossN=1;
for iter=1:M
    [mui,beta]=stochGradDescentIter(XtrainN,ytrain,beta,alphaN,lambdaN,iter);
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
P3Nstoch=plot(1:length(lossN),lossN);
title('Stochastic Gradient Descent Method using data preprocessed using i)');
xlabel('Iteration');
ylabel('Loss');
saveas(P3Nstoch,'p3Nstoch.jpg');
