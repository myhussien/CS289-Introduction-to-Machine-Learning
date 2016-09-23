function newXtrain=processTrainData(Xtrain,type)
%%
%Process data for problem 3
%type=1,2,3 corresponding to different ways to process data in problem 3
nFeature=size(Xtrain,2);
n=size(Xtrain,1);
newXtrain=zeros(n,nFeature);
if(type==1)
    for i=1:nFeature
        newXtrain(:,i)=(Xtrain(:,i)-mean(Xtrain(:,i)))/std(Xtrain(:,i));
    end
end
if (type==2)
    newXtrain=log(Xtrain+0.1);
end
if(type==3)
    newXtrain=double(Xtrain>0);
end


end