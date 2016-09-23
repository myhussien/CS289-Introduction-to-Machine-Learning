function [error,prediction] = testSpam(testData,testLabel,mu,inv_sigma,dtSigma,Prior,type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% type=1  Part d i)
% type=2 part d ii)
n=length(testLabel);
errorN=0;
prediction=zeros(n,1);
if(type==1)
    for dk=1:n
        x=testData(:,dk);
        PV=logMultiNormal(x,mu,inv_sigma,dtSigma,type);
        PV=PV+log(Prior);
        [pm,indxP]=max(PV);
        prediction(dk)=indxP-1;
        if (indxP~=testLabel(dk)+1)           
            errorN=errorN+1;
        end
    end
    error=errorN/n;
end
if(type==2)
    for dk=1:n
        x=testData(:,dk);
        PV=logMultiNormal(x,mu,inv_sigma,dtSigma,type);
        PV=PV+log(Prior);
        [pm,indxP]=max(PV);
        prediction(dk)=indxP-1;
        if (indxP~=testLabel(dk)+1)
            errorN=errorN+1;
        end
    end
    error=errorN/n;
    
end

end

