package com.cs289.dt.jshi.decisiontree;

import com.cs289.dt.jshi.DataPoint;

import java.util.ArrayList;

/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class Tree {
    private ArrayList<Node> nodeList=new ArrayList<Node>();
    public Tree(){

    }
    public Tree(ArrayList<DataPoint> iniData){
        Node iniNode=new Node();
        iniNode.setNodeData(iniData);
        nodeList.add(iniNode);

    }


    public Node getNode(int nodeNumber){
        return nodeList.get(nodeNumber);
    }
    public void setNode(int nodeNumber, Node newNode){
        nodeList.set(nodeNumber,newNode);
    }
    public void addNode(Node node){
       nodeList.add(node);
    }

    public ArrayList<Node> getNodeList() {
        return nodeList;
    }

    public void setNodeList(ArrayList<Node> nodeList) {
        this.nodeList = nodeList;
    }
}
