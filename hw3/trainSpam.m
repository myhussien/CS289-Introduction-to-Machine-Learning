function [mu,sigma] = trainSpam(trainData,trainLabel,type)
np=76;
mu=zeros(np,2);
if(type==1)
    sigma=zeros(np,np);
    for d=0:1
        data_d=trainData(:,(trainLabel==d));
        mui=mean(data_d');
        sigmad=cov(data_d',1);
        mu(:,d+1)=mui';
        sigma=sigma+sigmad;
    end
    sigma=sigma/2;    
end
if(type==2)
    sigma=zeros(np,np,2);
    for d=0:1
        data_d=trainData(:,(trainLabel==d));
        mui=mean(data_d');
        sigmad=cov(data_d',1);
        mu(:,d+1)=mui';
        sigma(:,:,d+1)=sigmad;
    end
end
end

