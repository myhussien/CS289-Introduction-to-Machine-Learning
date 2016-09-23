function P = logMultiNormal(x,mu,inv_sigma,dtSigma,type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nn=size(mu,2);
P=zeros(nn,1);
if(type==1)
    for d=0:(nn-1)
        P(d+1)=-((x-mu(:,d+1))')*inv_sigma*(x-mu(:,d+1));
    end
end
if(type==2)
    if(dtSigma~=zeros(nn,1))
        for d=0:(nn-1)
            P(d+1)=-log(dtSigma(d+1))-((x-mu(:,d+1))')*inv_sigma(:,:,d+1)*(x-mu(:,d+1));
        end
    else
        for d=0:(nn-1)
            P(d+1)=-log(det(inv_sigma(:,:,d+1)))-((x-mu(:,d+1))')*inv_sigma(:,:,d+1)*(x-mu(:,d+1));
        end
    end
    
end

end

