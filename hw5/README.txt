Name: Jiaying Shi
SID: 24978491
Email: shijy07@berkeley.edu
======================================================================================================================
Folder structure:
DecisionTree
    resources                                   Put the data here
        spam-dataset
            ham
            spam
            ham-test
            spam-test
            test
    src                                         Source code
        com
            cs289
                dt
                    jshi
                        preprocess              code for preprocess
                            BagofWords.java     generate bag of words
                            ObtainSpamData.java generate train/test data
                        decisiontree
                            Node.java           define a node
                            Tree.java           define a tree
                            PredictResult.java  define a predict result
                            DecisionTree.java   decision tree and random forest implementation
                        DataPoint.java          define a data point: features and label, general interface for all kinds of problems
                        Properties.java         store folder locations, parametors, use this to avoid hard code
======================================================================================================================
To run the code:

No additional package is required as dependencies.
I used jdk1.7.
------------------------------------------------------------------------------------------------------------------------------------------------
Sample code for decision tree:
//obtain data
ObtainSpamData sd=new ObtainSpamData();
sd.obtainTrainData();
ArrayList<DataPoint> train=new ArrayList<DataPoint>();
//get train data
train=sd.getTrainData();
//initialize decision tree
Node iniNode=new Node();
iniNode.setNodeData(train);
Tree dTree=new Tree();
dTree.addNode(iniNode);
Tree results=new Tree();
//training of decision tree
DecitionTree dt=new DecitionTree();
results=dt.trainDTree(dTree,false);//second attribute indicate whether select a random subset of features when spliting data at a node
//obtain test data
ArrayList<DataPoint> testD=new ArrayList<DataPoint>();
sd.obtainTestData();
 testD=sd.getTestData();
//predicti
PredictResult pr=new PredictResult();
pr=dt.predict(testD,results);
--------------------------------------------------------------------------------------------------------------------------------------------------
Sample code for random forest:
ObtainSpamData sd=new ObtainSpamData();
sd.obtainTrainData();
ArrayList<DataPoint> train=new ArrayList<DataPoint>();
train=sd.getTrainData();
ArrayList<DataPoint> testD=new ArrayList<DataPoint>();
 sd.obtainKaggleData();
 testD=sd.getKaggleTestData();
//predict using random forest        
PredictResult prRF=new PredictResult();
DecitionTree dtRF=new DecitionTree();
prRF=dtRF.randomForest(train,testD);

