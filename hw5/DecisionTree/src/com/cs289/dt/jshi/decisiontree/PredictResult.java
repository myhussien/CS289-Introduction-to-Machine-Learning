package com.cs289.dt.jshi.decisiontree;

import java.util.ArrayList;

/**
 * Created by Jiaying Shi on 4/5/2015.
 * shijy07@gmail.com
 * Copyright ? All Rights Reserved
 */
public class PredictResult {
    private double errorRate=1.0;
    private ArrayList<Integer> predictedLabel=new ArrayList<Integer>();

    public double getErrorRate() {
        return errorRate;
    }

    public void setErrorRate(double errorRate) {
        this.errorRate = errorRate;
    }

    public ArrayList<Integer> getPredictedLabel() {
        return predictedLabel;
    }

    public void setPredictedLabel(ArrayList<Integer> predictedLabel) {
        this.predictedLabel = predictedLabel;
    }
}
