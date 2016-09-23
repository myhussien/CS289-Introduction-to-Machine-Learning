function [mu,sigma] = trainDigit(trainData,trainLabel,type)
%trainDigit Summary of this function goes here
%   Detailed explanation goes here
%type=1 part d i)
%type=2 part d ii)
np=784;
mu=zeros(np,10);
if(type==1)
    sigma=zeros(np,np);
    for d=0:9
        data_d=trainData(:,(trainLabel==d));
        mui=mean(data_d');
        sigmad=cov(data_d',1);
        mu(:,d+1)=mui';
        sigma=sigma+sigmad;
    end
    sigma=sigma/10;    
end
if(type==2)
    sigma=zeros(np,np,10);
    for d=0:9
        data_d=trainData(:,(trainLabel==d));
        mui=mean(data_d');
        sigmad=cov(data_d',1);
        mu(:,d+1)=mui';
        sigma(:,:,d+1)=sigmad;
    end
end
end

