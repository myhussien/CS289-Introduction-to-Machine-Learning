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
%%
% Indicator function of data
XtrainI=processTrainData(Xtrain,3);
XtrainI=[ones(length(ytrain),1) XtrainI];
lambdaI=0.01;
alphaI=5;
beta=ones(size(XtrainI,2),1);
betaPrev=beta;
muI=[];
betaIterI=[];
epsilon=0.0000001;
prevMu=zeros(length(ytrain),1);
lossI=[];
M=length(ytrain);
prevLossI=1;
for iter=1:M
    [mui,beta]=stochGradDescentIterStep(XtrainI,ytrain,beta,alphaI,lambdaI,iter);
    muI=[muI mui];
    betaIterI=[betaIterI beta];
    lossIter=lambdaI*norm(beta)^2-1/M*ytrain'*log(mui+0.000001)-1/M*(1-ytrain)'*log(1-mui+0.000001);
    diff=prevLossI-lossIter;
    prevLossI=lossIter;
    lossI=[lossI;lossIter];
    if(abs(diff)<epsilon)
        break;
    end
end
P3I=plot(1:length(lossI),lossI);
title('Stothascic Gradient Descent Method with updated step size iii)');
xlabel('Iteration');
ylabel('Loss');
saveas(P3I,'p3istochStep.jpg');
