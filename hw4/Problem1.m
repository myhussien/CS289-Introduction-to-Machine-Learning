%%
%CS 289 Homework 4
%Problem1
%Jiaying Shi
%SID: 24978491
%shijy07@berkeley.edu
%%
clear all;
clc;
%%
lambda=0.07;
beta0=[-2;1;0];
Y=[1;1;0;0];
% X=[1 0 3;1 1 3;1 0 1 ;1 1 1];
X=[0 3 1;1 3 1;0 1 1 ;1 1 1];
mu0=(1./(1+exp(-beta0'*X')))';
beta1=newtonMethod(beta0,X,Y,lambda);
mu1=(1./(1+exp(-beta1'*X')))';
beta2=newtonMethod(beta1,X,Y,lambda);
mu2=(1./(1+exp(-beta2'*X')))';
beta3=newtonMethod(beta2,X,Y,lambda);
mu3=(1./(1+exp(-beta3'*X')))';
beta4=newtonMethod(beta3,X,Y,lambda);
mu4=(1./(1+exp(-beta4'*X')))';
beta5=newtonMethod(beta4,X,Y,lambda);
mu5=(1./(1+exp(-beta5'*X')))';
beta6=newtonMethod(beta5,X,Y,lambda);
mu6=(1./(1+exp(-beta6'*X')))';