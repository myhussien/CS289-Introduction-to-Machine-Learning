package com.cs289.dt.jshi.decisiontree;

import com.cs289.dt.jshi.DataPoint;
import com.cs289.dt.jshi.Properties;
import com.cs289.dt.jshi.preprocess.ObtainSpamData;
import com.sun.org.apache.xml.internal.dtm.ref.DTMDefaultBaseIterators;

import javax.xml.crypto.Data;
import java.util.*;

/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class DecitionTree {

    public ArrayList<DataPoint> trainData=new ArrayList<DataPoint>();
    public Tree initialTree=new Tree();
    public void initializeTree(){
        Node iniNode=new Node();
        iniNode.setNodeData(trainData);
    }
    public Tree trainDecisionTree(Tree tree,boolean randomFeature){
        int nNodes=tree.getNodeList().size();
        if(nNodes==58){
            System.out.println("");
        }
        boolean stop=false;
        for(int i=0;i<nNodes;i++){
            if(!tree.getNode(i).isBranched()){
                stop=(!stop)&&tree.getNode(i).isStopBranch();
            }
        }
        if(stop){
            return tree;
        }
        if(nNodes>Properties.MAX_NODE_NUMBER){
            return tree;
        }
        boolean finish=true;
        for(int i=0;i<nNodes;i++){
            finish=finish&&((!tree.getNode(i).isBranched())&&tree.getNode(i).isStopBranch());
        }
        if(finish){
            return tree;
        }
        for(int i=0;i<nNodes;i++){
            if((!tree.getNode(i).isBranched())&&(!tree.getNode(i).isStopBranch())){
                //Check whether should stop branch
                if(tree.getNode(i).getDepth()>=Properties.MAX_BRANCH_DEPTH){
                    tree.getNode(i).setStopBranch(true);
                    ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                    leafData=tree.getNode(i).getNodeData();
                    int leafDataLength=leafData.size();
                    int nSpamMain=0;
                    for(int mm=0;mm<leafDataLength;mm++){
                        if(leafData.get(mm).getLabel()==Properties.SPAM_LABEL){
                            nSpamMain++;
                        }
                    }
                    if(Double.valueOf(nSpamMain)>=Double.valueOf(leafDataLength)/2.0){
                        tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                    }else{
                        tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                    }
                    tree.getNode(i).getNodeData().clear();
                    leafData.clear();
                    break;
                }
                ArrayList<DataPoint> data=tree.getNode(i).getNodeData();
                int dataLength=data.size();
                if(dataLength<Properties.MIN_DATA_POINTS){
                    tree.getNode(i).setStopBranch(true);
                    ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                    leafData=tree.getNode(i).getNodeData();
                    int leafDataLength=leafData.size();
                    int nSpamMain=0;
                    for(int mm=0;mm<leafDataLength;mm++){
                        if(leafData.get(mm).getLabel()==Properties.SPAM_LABEL){
                            nSpamMain++;
                        }
                    }
                    if(Double.valueOf(nSpamMain)>=Double.valueOf(leafDataLength)/2.0){
                        tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                    }else{
                        tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                    }
                    tree.getNode(i).getNodeData().clear();
                    leafData.clear();
                    break;
                }
                int lLable=data.get(0).getLabel();
                boolean stop2=true;
                for(int k=0;k<dataLength;k++){
                    stop2=stop2&&(data.get(k).getLabel()==lLable);
                }
                if(stop2){
                    tree.getNode(i).setStopBranch(true);
                    ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                    leafData=tree.getNode(i).getNodeData();
                    int leafDataLength=leafData.size();
                    int nSpamMain=0;
                    for(int mm=0;mm<leafDataLength;mm++){
                        if(leafData.get(mm).getLabel()==Properties.SPAM_LABEL){
                            nSpamMain++;
                        }
                    }
                    if(Double.valueOf(nSpamMain)>=Double.valueOf(leafDataLength)/2.0){
                        tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                    }else{
                        tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                    }
                    tree.getNode(i).getNodeData().clear();
                    leafData.clear();
                    break;
                }
                int [] infoNode=new int[2];
                infoNode=selectFeature(tree.getNode(i),randomFeature);
                tree.getNode(i).setFeatureNumber(infoNode[0]);
                tree.getNode(i).setSplitCriteria(infoNode[1]);
                tree.getNode(i).setBranched(true);
                ArrayList<DataPoint> dataG=new ArrayList<DataPoint>();
                ArrayList<DataPoint> dataL=new ArrayList<DataPoint>();
                int gNSpam=0;
                for(int j=0;j<dataLength;j++){
                    if(data.get(j).getFeatures().get(tree.getNode(i).getFeatureNumber())>=
                            tree.getNode(i).getSplitCriteria()){
                        dataG.add(data.get(j));
                        if(data.get(j).getLabel()==Properties.SPAM_LABEL){
                            gNSpam++;
                        }
                    }
                    else{
                        dataL.add(data.get(j));
                    }
                }
                if(gNSpam>=(dataLength/2)){
                    tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                }else{
                    tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                }
                Node gNode=new Node();
                Node lNode=new Node();
                gNode.setParentNodeNumber(i);
                lNode.setParentNodeNumber(i);
                gNode.setNodeData(dataG);
                lNode.setNodeData(dataL);
                gNode.setDepth(tree.getNode(i).getDepth() + 1);
                lNode.setDepth(tree.getNode(i).getDepth()+1);
                gNode.setNodeNumber(nNodes);
                lNode.setNodeNumber(nNodes+1);
                int[] child={nNodes,nNodes+1};
                tree.getNode(i).setChildNode(child);
                tree.addNode(gNode);
                tree.addNode(lNode);
                tree.getNode(i).getNodeData().clear();
                System .out.println("New Node: " + String.valueOf(nNodes));
                System.out.println("New Node: "+String.valueOf(nNodes+1));
                data.clear();
                break;
            }
        }
        return this.trainDecisionTree(tree,randomFeature);
    }
    public Tree trainDTree(Tree tree, boolean  randomFeature){

        boolean stopCriteria=false;
        while(!stopCriteria){
            int nNodes=tree.getNodeList().size();
            boolean stop=false;
            for(int i=0;i<nNodes;i++){
                if(!tree.getNode(i).isBranched()){
                    stop=(!stop)&&tree.getNode(i).isStopBranch();
                }
            }
            if(stop){
                stopCriteria=true;
                break;
            }
            if(nNodes>Properties.MAX_NODE_NUMBER){
                stopCriteria=true;
                break;
            }
            boolean finish=true;
            for(int i=0;i<nNodes;i++){
                boolean b=(tree.getNode(i).isBranched())||(tree.getNode(i).isStopBranch());
                finish=finish&&(b);
            }
            if(finish){
                stopCriteria=true;
                break;
            }
            for(int i=0;i<nNodes;i++){
                if((!tree.getNode(i).isBranched())&&(!tree.getNode(i).isStopBranch())){
                    //Check whether should stop branch
                    if(tree.getNode(i).getDepth()>=Properties.MAX_BRANCH_DEPTH){
                        tree.getNode(i).setStopBranch(true);
                        ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                        leafData=tree.getNode(i).getNodeData();
                        int parNodeNum=tree.getNode(i).getParentNodeNumber();
                        int[] parChild=tree.getNode(parNodeNum).getChildNode();
                        if(parChild[0]==i){
                            tree.getNode(i).setLargerLabel(tree.getNode(parNodeNum).getLargerLabel());
                        } else{
                            tree.getNode(i).setLargerLabel(1-tree.getNode(parNodeNum).getLargerLabel());
                        }
                        tree.getNode(i).getNodeData().clear();
                        leafData.clear();
                        break;
                    }
                    ArrayList<DataPoint> data=tree.getNode(i).getNodeData();
                    int dataLength=data.size();
                    if(dataLength<Properties.MIN_DATA_POINTS){
                        tree.getNode(i).setStopBranch(true);
                        ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                        leafData=tree.getNode(i).getNodeData();
                        int parNodeNum=tree.getNode(i).getParentNodeNumber();
                        int[] parChild=tree.getNode(parNodeNum).getChildNode();
                        if(parChild[0]==i){
                            tree.getNode(i).setLargerLabel(tree.getNode(parNodeNum).getLargerLabel());
                        } else{
                            tree.getNode(i).setLargerLabel(1-tree.getNode(parNodeNum).getLargerLabel());
                        }
                        leafData.clear();
                        break;
                    }
                    int lLable=data.get(0).getLabel();
                    boolean stop2=true;
                    for(int k=0;k<dataLength;k++){
                        stop2=stop2&&(data.get(k).getLabel()==lLable);
                    }
                    if(stop2){
                        tree.getNode(i).setStopBranch(true);
                        ArrayList<DataPoint> leafData=new ArrayList<DataPoint>();
                        leafData=tree.getNode(i).getNodeData();
                        int parNodeNum=tree.getNode(i).getParentNodeNumber();
                        int[] parChild=tree.getNode(parNodeNum).getChildNode();
                        if(parChild[0]==i){
                            tree.getNode(i).setLargerLabel(tree.getNode(parNodeNum).getLargerLabel());
                        } else{
                            tree.getNode(i).setLargerLabel(1-tree.getNode(parNodeNum).getLargerLabel());
                        };
                        leafData.clear();
                        break;
                    }

                    int labelsum=0;
                    for(int ll=0;ll<dataLength;ll++){
                        labelsum=labelsum+data.get(ll).getLabel();
                    }
                    int l=tree.getNode(i).getNodeData().size();
                    if((Double.valueOf(labelsum)>0.98*Double.valueOf(l))){
                        tree.getNode(i).setStopBranch(true);
                        tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                        data.clear();
                        break;
                    }
                    if((Double.valueOf(labelsum)<0.02*Double.valueOf(l))){
                        tree.getNode(i).setStopBranch(true);
                        tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                        data.clear();
                        break;
                    }
                    int [] infoNode=new int[2];
                    infoNode=selectFeature(tree.getNode(i),randomFeature);
                    tree.getNode(i).setFeatureNumber(infoNode[0]);
                    tree.getNode(i).setSplitCriteria(infoNode[1]);

                    tree.getNode(i).setBranched(true);
                    ArrayList<DataPoint> dataG=new ArrayList<DataPoint>();
                    ArrayList<DataPoint> dataL=new ArrayList<DataPoint>();
                    int gNSpam=0;
                    int selFeature=tree.getNode(i).getFeatureNumber();
                    int splitC= tree.getNode(i).getSplitCriteria();
                    if(selFeature>=0){
                        for(int j=0;j<dataLength;j++){

                            if(data.get(j).getFeatures().get(selFeature)>= splitC){
                                dataG.add(data.get(j));
                                if(data.get(j).getLabel()==Properties.SPAM_LABEL){
                                    gNSpam++;
                                }
                            }
                            else{
                                dataL.add(data.get(j));
                            }
                        }

                        if(gNSpam>=(Double.valueOf(dataG.size())/2.0)){
                            tree.getNode(i).setLargerLabel(Properties.SPAM_LABEL);
                        }else{
                            tree.getNode(i).setLargerLabel(Properties.HAM_LABEL);
                        }
                        Node gNode=new Node();
                        Node lNode=new Node();
                        gNode.setParentNodeNumber(i);
                        lNode.setParentNodeNumber(i);
                        gNode.setNodeData(dataG);
                        lNode.setNodeData(dataL);
                        gNode.setDepth(tree.getNode(i).getDepth() + 1);
                        lNode.setDepth(tree.getNode(i).getDepth()+1);
                        gNode.setNodeNumber(nNodes);
                        lNode.setNodeNumber(nNodes+1);
                        int[] child={nNodes,nNodes+1};
                        tree.getNode(i).setChildNode(child);
                        tree.addNode(gNode);
                        tree.addNode(lNode);
                        tree.getNode(i).getNodeData().clear();
//                        System .out.println("New Node: " + String.valueOf(nNodes)+"<-- "
//                                +"Parent Node"+String.valueOf(gNode.getParentNodeNumber()));
//                        System.out.println("New Node: "+String.valueOf(nNodes+1)+"<-- "
//                                +"Parent Node"+String.valueOf(lNode.getParentNodeNumber()));
                        data.clear();
                    }
                    else{
                        tree.getNode(i).setStopBranch(true);
                        int parNodeNum=tree.getNode(i).getParentNodeNumber();
                        int[] parChild=tree.getNode(parNodeNum).getChildNode();
                        if(parChild[0]==i){
                            tree.getNode(i).setLargerLabel(tree.getNode(parNodeNum).getLargerLabel());
                        } else{
                            tree.getNode(i).setLargerLabel(1-tree.getNode(parNodeNum).getLargerLabel());
                        }
                        data.clear();
                    }
                    break;
                }
            }
        }
        return tree;
    }


    public int[] selectFeature(Node node, boolean randomFeature ){
        int [] result=new int[2];
        ArrayList<DataPoint> dp=node.getNodeData();
        if(dp.size()==0||dp==null){
            return null;
        }
        else{
            int nFeatures=dp.get(0).getFeatures().size();
            int nData=dp.size();
            double informationGain=-1.0;
            int featureNum=-1;
            int boundaryValue=0;
            Random rand=new Random();
            HashSet<Integer> randFeatureSet=new HashSet<Integer>();
            for(int j=0;j<nFeatures/Properties.FEATURE_SET_NUM;j++){
                    int fn=rand.nextInt(nFeatures-1);
                    randFeatureSet.add(fn);


            }
            for(int i=0;i<nFeatures;i++){
                double informationGainFi=-1.0;
                int bValue=0;
                if(!randomFeature){
                    ArrayList<Integer> featureValues=new ArrayList<Integer>();
                    for(int j=0;j<nData;j++){
                        int fv=dp.get(j).getFeatures().get(i);
                        if((fv!=0)&&(!featureValues.contains(fv))){
                            featureValues.add(fv);
                        }
                    }
                    int nFeatureValues=featureValues.size();
                    for(int k=0;k<nFeatureValues;k++){
                        double infoGain=InformationGain(dp,i,featureValues.get(k));
                        if(infoGain>=informationGainFi){
                            informationGainFi=infoGain;
                            bValue=featureValues.get(k);
                        }
                    }
                    if(informationGainFi>=informationGain){
                        informationGain=informationGainFi;
                        featureNum=i;
                        boundaryValue=bValue;
                    }
                }
                else{
                    if(randFeatureSet.contains(i)){
                        ArrayList<Integer> featureValues=new ArrayList<Integer>();
                        for(int j=0;j<nData;j++){
                            int fv=dp.get(j).getFeatures().get(i);
                            if((fv!=0)&&(!featureValues.contains(fv))){
                                featureValues.add(fv);
                            }
                        }
                        int nFeatureValues=featureValues.size();
                        for(int k=0;k<nFeatureValues;k++){
                            double infoGain=InformationGain(dp,i,featureValues.get(k));
                            if(infoGain>=informationGainFi){
                                informationGainFi=infoGain;
                                bValue=featureValues.get(k);
                            }
                        }
                        if(informationGainFi>=informationGain){
                            informationGain=informationGainFi;
                            featureNum=i;
                            boundaryValue=bValue;
                        }
                    }
                }
            }
            result[0]=featureNum;
            result[1]=boundaryValue;
            return result;
        }

    }

    public double InformationGain(ArrayList<DataPoint> data,int featureNum,int boundrayValue){
        double infoGain=0.0;
        double entropyParNode=Entropy(data);
        infoGain=infoGain+entropyParNode;
        ArrayList<DataPoint> dataG=new ArrayList<DataPoint>();
        ArrayList<DataPoint> dataL=new ArrayList<DataPoint>();
        int nData=data.size();
        for(int i=0;i<nData;i++){
            int featureValue=data.get(i).getFeatures().get(featureNum);
            if(featureValue>=boundrayValue){
                dataG.add(data.get(i));
            }
            else{
                dataL.add(data.get(i));
            }
        }
        double probabilityG=Double.valueOf(dataG.size())/Double.valueOf(nData);
        double probabilityL=Double.valueOf(dataL.size())/Double.valueOf(nData);
        if((dataG.size()!=0)&&(dataL.size()!=0)) {
            infoGain = infoGain - probabilityG * Entropy(dataG) - probabilityL * Entropy(dataL);
        }
        if((probabilityG<=0.05)||(probabilityL<=0.05)){
            infoGain = 0;
        }
        return infoGain;
    }
    public double Entropy(ArrayList<DataPoint> data){
        double entropy=0.0;
        double probabilitySpam;
        int nData=data.size();
        int nSpam=0;
        for(int j=0;j<nData;j++){
            if(data.get(j).getLabel()== Properties.SPAM_LABEL){
                nSpam++;
            }
        }
        probabilitySpam=Double.valueOf(nSpam)/Double.valueOf(nData);
        entropy = -1 * probabilitySpam * Math.log(probabilitySpam) / Math.log(2);
        return entropy;
    }

    public PredictResult randomForest(ArrayList<DataPoint> trainData,ArrayList<DataPoint> testData){
        PredictResult prForest=new PredictResult();
        ArrayList<PredictResult> pr=new ArrayList<PredictResult>();
        ArrayList<Integer> prLabel=new ArrayList<Integer>();
        for(int nT=0;nT<Properties.TREE_NUMBER;nT++){
            Tree result=new Tree();
            Random rand=new Random();
            ArrayList<Integer> trainDp=new ArrayList<Integer>();
            for(int k=0;k<Properties.TREE_SIZE;k++){
                   trainDp.add(rand.nextInt(trainData.size()-1));
            }
            ArrayList<DataPoint> forestTrain=new ArrayList<DataPoint>();
            for(int k=0;k<trainData.size();k++){
                if(trainDp.contains(k)){
                    DataPoint dp=new DataPoint();
                    dp.setLabel(trainData.get(k).getLabel());
                    dp.setFeatures(trainData.get(k).getFeatures());
                    forestTrain.add(dp);
                }
            }
            Node iniNode=new Node();
            iniNode.setNodeData(forestTrain);
            Tree dTree=new Tree();
            dTree.addNode(iniNode);
            result=trainDTree(dTree,true);
            System.out.println(result.getNode(0).getFeatureNumber());
            PredictResult prt=new PredictResult();
            prt= predict(testData,result);
            pr.add(prt);
        }
        double er=0;
        ArrayList<Double> meanPredict=new ArrayList<Double>();
        int nTest=testData.size();
        for(int j=0;j<nTest;j++){
            meanPredict.add(0.0);
        }

        for(int i=0;i<Properties.TREE_NUMBER;i++){
//             er=er+pr.get(i).getErrorRate()/Double.valueOf(Properties.TREE_NUMBER);
             ArrayList<Integer>pli=new ArrayList<Integer>();
            pli=pr.get(i).getPredictedLabel();
            for(int j=0;j<nTest;j++){
                double meanJ=meanPredict.get(j);
                meanJ=meanJ+Double.valueOf(pli.get(j))/Double.valueOf(Properties.TREE_NUMBER);

                meanPredict.set(j,meanJ);
            }
        }
        for(int i=0;i<nTest;i++){
            if(meanPredict.get(i)>=0.5){
                prLabel.add(1);
            }else{
                prLabel.add(0);
            }
//            System.out.println(String.valueOf(prLabel.get(i)));
        }
        for(int i=0;i<nTest;i++){
            if(prLabel.get(i)!=testData.get(i).getLabel()){
                     er=er+1.0/Double.valueOf(nTest);
            }
        }
        prForest.setErrorRate(er);
//        System.out.println(er);
        prForest.setPredictedLabel(prLabel);
        return prForest;
    }
    public PredictResult predict(ArrayList<DataPoint>testData,Tree tree){
        double errorRate=0.0;
        ArrayList<Integer> predictedLabel=new ArrayList<Integer>();
        PredictResult predictResult=new PredictResult();
        int nTestData=testData.size();
        if(nTestData==0){
            return null;
        }
        int errorPredict=0;
        for(int i=0;i<nTestData;i++){
            int nodeNum=0;
            boolean stopB=false;
            while(!stopB){
                int featureNum=tree.getNode(nodeNum).getFeatureNumber();
                int splitCriteria=tree.getNode(nodeNum).getSplitCriteria();
                if(tree.getNode(nodeNum).isStopBranch()){
                    int pLabel= tree.getNode(nodeNum).largerLabel;
                    if(testData.get(i).getFeatures().get(featureNum)>=splitCriteria){
                        predictedLabel.add(i,pLabel);
                    }else{
                        predictedLabel.add(i,1-pLabel);
                    }
//                    System.out.println("Test Data"+String.valueOf(i)+"---- Predicted Label: "+
//                            String.valueOf(predictedLabel.get(i))+
//                            " Actual Label: " +String.valueOf(testData.get(i).getLabel()));
//                    System.out.println(
//                            String.valueOf(predictedLabel.get(i)));
                    if(predictedLabel.get(i)!=testData.get(i).getLabel()){
                        errorPredict++;
                    }
                    stopB=true;
                    break;
                } else{
                    if(testData.get(i).getFeatures().get(featureNum)>=splitCriteria){
                        nodeNum=tree.getNode(nodeNum).getChildNode()[0];
                    }else{
                        nodeNum=tree.getNode(nodeNum).getChildNode()[1];
                    }
                }
            }

        }
        errorRate=Double.valueOf(errorPredict)/Double.valueOf(nTestData);
//        System.out.println("ErrorRate: "+String.valueOf(errorRate));
        predictResult.setErrorRate(errorRate);
        predictResult.setPredictedLabel(predictedLabel);
        return predictResult;
    }
    public ArrayList<DataPoint> getTrainData() {
        return trainData;
    }

    public void setTrainData(ArrayList<DataPoint> trainData) {
        this.trainData = trainData;
    }
    public static void main(String[] args) throws Exception{
//        ObtainSpamData sd=new ObtainSpamData();
//        sd.obtainTrainData();
//        ArrayList<DataPoint> train=new ArrayList<DataPoint>();
//        train=sd.getTrainData();
//        Node iniNode=new Node();
//        iniNode.setNodeData(train);
//        Tree dTree=new Tree();
//        dTree.addNode(iniNode);
//        Tree results=new Tree();
//        DecitionTree dt=new DecitionTree();
//        results=dt.trainDTree(dTree,false);
////        ArrayList<DataPoint> testD=new ArrayList<DataPoint>();
////        train.clear();
////        sd.obtainTestData();
////        testD=sd.getTestData();
////        PredictResult pr=new PredictResult();
////        pr=dt.predict(testD,results);
////        testD.clear();
//        sd.obtainKaggleData();
//        ArrayList<DataPoint> kaggleD=new ArrayList<DataPoint>();
//        kaggleD=sd.getKaggleTestData();
//        PredictResult prKaggle=new PredictResult();
//        DecitionTree dt2=new DecitionTree();
//        prKaggle=dt2.predict(kaggleD, results);
        ////////////////////////////////////////////////
        //Random Forest
        ObtainSpamData sd=new ObtainSpamData();
        sd.obtainTrainData();
        ArrayList<DataPoint> train=new ArrayList<DataPoint>();
        train=sd.getTrainData();

        ArrayList<DataPoint> testD=new ArrayList<DataPoint>();
        sd.obtainKaggleData();
        testD=sd.getKaggleTestData();
        PredictResult prRF=new PredictResult();
        DecitionTree dtRF=new DecitionTree();
        prRF=dtRF.randomForest(train,testD);
        System.out.println();
    }

}
