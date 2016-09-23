function error=OBJ_Error(predictLabels,trainLabels,nOut,objType)
%OBJ_ERROR calculate error rate of different objective functions
%objType=1 MSE
%objType=2 Cross Entropy
nData=size(predictLabels,1);
J=zeros(nData,1);
for i=1:nData
    label=zeros(1,nOut);
    if(trainLabels(i)==0)
        label(10)=1;
    else
        label(trainLabels(i))=1;
    end
    if(objType==1)
        J(i)=0.5*(predictLabels(i,:)-label)*((predictLabels(i,:)-label)');
    end
    if(objType==2)
        J(i)=0;
        for j=1:nOut
            if(label(j)==0)
                J(i)=J(i)-log(1-predictLabels(i,j));
            end
            if(label(j)==1)
                J(i)=J(i)-log(predictLabels(i,j));
            end
        end
    end
end
error=mean(J);
end