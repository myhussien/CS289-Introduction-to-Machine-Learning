%%
%CS289 Homework 7 Problem1
%Jiaying Shi
%SID: 24978491
%shijy07@berkeley.edu
%%
clear all;
clc;
cd '.\mnist_data';
load 'images.mat';
cd '..';
%%
nData=size(images,3);
nPixel=size(images,1);
data=reshape(images,nPixel^2,nData);
data=data';
k=[5,10,20];
nk=length(k);
nRun=3;
loss=zeros(nRun,nk);
epsilon=0.00001;
for i=1:nRun
    for j=1:nk
        muindx=randsample(nData,k(j));
        mu=data(muindx,:)';
        flag=1;
        label=zeros(nData,1);
        labelPrev=ones(nData,1)*(k(j)+1);
        while flag>0;
            %label data
            for t=1:nData
                dataT=data(t,:)'*ones(1,k(j));
                delta=dataT-mu;
                errorData=diag(delta'*delta);
                [minE,l]=min(errorData);
                label(t)=l(1);
            end
            %calculate mean
            error=0;
            for l=1:k(j);
                indxL=find(label==l);
                dataL=data(indxL,:)';
                mu(:,l)=mean(dataL')';
                muL=mu(:,l)*ones(1,length(indxL));
                errorL=norm(dataL-muL,'fro')^2;
                error=errorL+error;
            end
            if(norm(labelPrev-label)<epsilon)
                flag=0;
            else
                labelPrev=label;
            end
        end
        loss(i,j)=error;
        fij=figure;
        for pl=1:k(j)
            subplot(4,5,pl), imagesc(reshape(mu(:,pl),nPixel,nPixel))
        end
    end
end
