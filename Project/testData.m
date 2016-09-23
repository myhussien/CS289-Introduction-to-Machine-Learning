clear all;
clc;
%%
%Jiaying Shi
%shijy07@berkeley.edu
%%
%Load Data
% load 'sent_active_voxel_200.mat'
load 'sent_RoI_act_mean.mat';
fig1=figure;
bar(train_pic1(1:160,1));
fig2=figure;
bar(train_pic1(1:160,2));

