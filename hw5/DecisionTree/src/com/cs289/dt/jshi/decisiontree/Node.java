package com.cs289.dt.jshi.decisiontree;

import com.cs289.dt.jshi.DataPoint;

import java.util.ArrayList;

/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class Node {
    int featureNumber;
    int nodeNumber=0;
    int parentNodeNumber=-1;
    int splitCriteria;
    int largerLabel;
    int predictedLabel=-1;
    int depth=0;
    boolean stopBranch=false;
    boolean branched=false;
    int[] childNode=new int [2];

    public int getPredictedLabel() {
        return predictedLabel;
    }

    public void setPredictedLabel(int predictedLabel) {
        this.predictedLabel = predictedLabel;
    }

    public int[] getChildNode() {
        return childNode;
    }

    public void setChildNode(int[] childNode) {
        this.childNode = childNode;
    }

    public boolean isBranched() {
        return branched;
    }

    public void setBranched(boolean branched) {
        this.branched = branched;
    }

    public boolean isStopBranch() {
        return stopBranch;
    }

    public void setStopBranch(boolean stopBranch) {
        this.stopBranch = stopBranch;
    }



    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    ArrayList<DataPoint> nodeData=new ArrayList<DataPoint>();

    public ArrayList<DataPoint> getNodeData() {
        return nodeData;
    }

    public void setNodeData(ArrayList<DataPoint> nodeData) {
        this.nodeData = nodeData;
    }

    public int getLargerLabel() {
        return largerLabel;
    }

    public void setLargerLabel(int largerLabel) {
        this.largerLabel = largerLabel;
    }

    public int getFeatureNumber() {
        return featureNumber;
    }

    public void setFeatureNumber(int featureNumber) {
        this.featureNumber = featureNumber;
    }

    public int getNodeNumber() {
        return nodeNumber;
    }

    public void setNodeNumber(int nodeNumber) {
        this.nodeNumber = nodeNumber;
    }

    public int getParentNodeNumber() {
        return parentNodeNumber;
    }

    public void setParentNodeNumber(int parentNodeNumber) {
        this.parentNodeNumber = parentNodeNumber;
    }

    public int getSplitCriteria() {
        return splitCriteria;
    }

    public void setSplitCriteria(int splitCriteria) {
        this.splitCriteria = splitCriteria;
    }
}
