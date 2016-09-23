function cost=MSECost(U,V,lambda,train)
    indxM=1-isnan(train);
    cost=0;
    tData=train;
    tData(isnan(tData))=0;
    cost=cost+norm((U*V-tData).*indxM,'fro')^2+lambda*(norm(U,'fro')^2+norm(V,'fro')^2);
end