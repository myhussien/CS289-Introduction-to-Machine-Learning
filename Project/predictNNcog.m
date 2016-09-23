function  [errorRate,predictLabel,nnOutput]= predictNN(W1,W2,testData,testLabel)
%PREDICTNN predict using neural network
%   Detailed explanation goes here
nTest=size(testData,1);
oneVector=ones(nTest,1);
testData = [testData, oneVector];
hiddenIn = tanh(testData* W1);
hiddenData = [hiddenIn,oneVector];
nnOutput = sigmf(hiddenData*W2,[1,0]);
[maxOut, predictLabel] = max(nnOutput, [], 2);
errorRate=sum(predictLabel~=testLabel)/nTest;
end

