package com.cs289.dt.jshi;
import java.util.ArrayList;
/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class DataPoint {
    private ArrayList<Integer> features=new ArrayList<Integer>();
    private int label;

    public ArrayList<Integer> getFeatures() {
        return features;
    }

    public void setFeatures(ArrayList<Integer> features) {
        this.features = features;
    }

    public int getLabel() {
        return label;
    }

    public void setLabel(int label) {
        this.label = label;
    }
}
