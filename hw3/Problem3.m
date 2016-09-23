%%
%CS 289
%HW3,Problem 3
%Jiaying Shi
%shijy07@gmail.com
%%
clear all;
clc;
N=1000;
%%
%Part a
mu=[1 1];
Sigma=[2 0;0 1];
[X1,X2] = meshgrid(linspace(-3,5,N)', linspace(-3,5,N)');
X = [X1(:) X2(:)];
p = mvnpdf(X, mu, Sigma);
ha=figure(1);
contour(X1,X2,reshape(p,N,N));
axis square;
title('Problem 3 Part (a)');
xlabel('X1');
ylabel('X2');
saveas(ha,'p2pa.jpg')
%%
%Part b
mu=[-1 2];
Sigma=[3 1;1 2];
[X1,X2] = meshgrid(linspace(-5,3,N)', linspace(-2,6,N)');
X = [X1(:) X2(:)];
p = mvnpdf(X, mu, Sigma);
hb=figure(2);
contour(X1,X2,reshape(p,N,N));
axis square;
title('Problem 3 Part (b)');
xlabel('X1');
ylabel('X2');
saveas(hb,'p3pb.jpg')
%%
%Part c
mu1=[0 2];
mu2=[2 0];
Sigma=[1 1;1 2];
[X1,X2] = meshgrid(linspace(-3,5,N)', linspace(-3,5,N)');
X = [X1(:) X2(:)];
p1= mvnpdf(X, mu1, Sigma);
p2= mvnpdf(X, mu2, Sigma);
p=p1-p2;
hc=figure(3);
contour(X1,X2,reshape(p,N,N));
axis square;
title('Problem 3 Part (c)');
xlabel('X1');
ylabel('X2');
saveas(hc,'p3pc.jpg')
%%
%Part d
mu1=[0 2];
mu2=[2 0];
Sigma1=[1 1;1 2];
Sigma2=[3 1; 1 2];
[X1,X2] = meshgrid(linspace(-4,6,N)', linspace(-4,6,N)');
X = [X1(:) X2(:)];
p1= mvnpdf(X, mu1, Sigma1);
p2= mvnpdf(X, mu2, Sigma2);
p=p1-p2;
hd=figure(4);
contour(X1,X2,reshape(p,N,N));
axis square;
title('Problem 3 Part (d)');
xlabel('X1');
ylabel('X2');
saveas(hd,'p3pd.jpg')
%%
%Part e
mu1=[1 1];
mu2=[-1 -1];
Sigma1=[1 0;0 2];
Sigma2=[2 1; 1 2];
[X1,X2] = meshgrid(linspace(-10,10,N)', linspace(-10,10,N)');
X = [X1(:) X2(:)];
p1= mvnpdf(X, mu1, Sigma1);
p2= mvnpdf(X, mu2, Sigma2);
p=p1-p2;
he=figure(5);
contour(X1,X2,reshape(p,N,N));
axis square;
title('Problem 3 Part (e)');
xlabel('X1');
ylabel('X2');
saveas(he,'p3pe.jpg')