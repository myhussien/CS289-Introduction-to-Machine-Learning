%%
%CS 289 Homework 4
%Problem 2
%Jiaying Shi
%SID: 24978491
%shijy07@berkeley.edu
%%
clear all;
clc;
load 'YearPredictionMSD.mat';
%%
trainLabel=YearPredictionMSD(1:463715,1);
trainData=[ones(length(trainLabel),1) YearPredictionMSD(1:463715,2:91)];
testLabel=YearPredictionMSD(463716:515345,1);
testData=[ones(length(testLabel),1) YearPredictionMSD(463716:515345,2:91)];
%%
%linear regression
betta=trainData\trainLabel;
predictLabel=testData*betta;
RSS=(predictLabel-testLabel)'*(predictLabel-testLabel);
predictRange=range(predictLabel);
minPredictLabel=min(predictLabel);
maxPredictLabel=max(predictLabel);
display('Maximum value of the predicted label is');
maxPredictLabel
display('Minimum value of the predicted label is');
minPredictLabel
P2=scatter(1:90,betta(2:91),'.');
title('\beta Without the Constant Term')
ylabel('\beta');
xlabel('Feature NumbeLar');
saveas(P2,'P2.jpg');