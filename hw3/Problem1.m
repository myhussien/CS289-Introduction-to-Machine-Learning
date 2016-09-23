%%
%CS 289
%HW3,Problem 1
%Jiaying Shi
%shijy07@gmail.com
%%
clear all;
clc;
mu1=3;
sigma1=3;
mu2=4;
sigma2=2;
N=100;
%%
%Part a
X1_std=randn(N,1);
X1=X1_std*sigma1+mu1;
X2_std=randn(N,1);
X2=0.5*X1+X2_std*sigma2+mu2;
mean_X1=mean(X1);
mean_X2=mean(X2);
display('----------Part a-------------');
mean_X1
mean_X2
%%
%Part b
cov_X1_X2=cov(X1,X2);
display('----------Part b-------------');
cov_X1_X2

%%Part c
[eig_Vec,D]=eig(cov_X1_X2);
eig_Val=diag(D);
display('----------Part c-------------');
display('Eigen values:');
eig_Val
display('Eigen vectors:');
eig_Vec

%%
%Part d
hd=figure(1);
scatter(X1,X2,'linewidth',2);
axis([-15,15,-15 15]);
axis square;
xlabel('X1');
ylabel('X2');
title('Problem 1 part (d)');
hold on;
normed_eigVec1=eig_Vec(:,1)*abs(eig_Val(1));
normed_eigVec2=eig_Vec(:,2)*abs(eig_Val(2));
quiver(mean_X1, mean_X2, normed_eigVec1(1),normed_eigVec1(2),'r','linewidth',2,'maxheadsize',0.5)
quiver(mean_X1, mean_X2, normed_eigVec2(1),normed_eigVec2(2),'r','linewidth',2,'maxheadsize',0.5)
hold off;
saveas(hd,'p1pd.jpg');
%%
%Part e
X=[X1 X2];
mu=ones(N,2)*diag([mean_X1,mean_X2]);
Xstd=X-mu;
[eig_Val, indx]=sort(eig_Val,'descend');
eig_Vec=eig_Vec(indx,:);
Xstd=Xstd*eig_Vec';
Xstd1=Xstd(:,1);
Xstd2=Xstd(:,2);
he=figure(2);
scatter(Xstd1,Xstd2,'linewidth',2);
axis([-15,15,-15 15]);
axis square;
xlabel('X1rotated');
ylabel('X2rotated');
title('Problem 1 part (e)');
hold on;
normed_eigVec1=(eig_Vec')*eig_Vec(:,1)*abs(eig_Val(1));
normed_eigVec2=(eig_Vec')*eig_Vec(:,2)*abs(eig_Val(2));
quiver(mean(Xstd1), mean(Xstd2), normed_eigVec1(1),normed_eigVec1(2),'r','linewidth',2,'maxheadsize',0.5)
quiver(mean(Xstd1), mean(Xstd2), normed_eigVec2(1),normed_eigVec2(2),'r','linewidth',2,'maxheadsize',0.5)
hold off;
saveas(he,'p1pe.jpg');