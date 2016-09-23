package com.cs289.dt.jshi.preprocess;

import com.cs289.dt.jshi.DataPoint;
import com.cs289.dt.jshi.Properties;

import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class ObtainSpamData {
    private String hamTrainFolder= Properties.HAM_TRAIN_FOLDER;
    private String spamTrainFolder=Properties.SPAM_TRAIN_FOLDER;
    private String hamTestFolder=Properties.HAM_TEST_FOLDER;
    private String spamTestFolder=Properties.SPAM_TEST_FOLDER;
    private String kaggleTestFolder=Properties.TEST_FOLDER;

    private ArrayList<DataPoint> trainData=new ArrayList<DataPoint>();
    private ArrayList<DataPoint> testData=new ArrayList<DataPoint>();
    private ArrayList<DataPoint> kaggleTestData=new ArrayList<DataPoint>();

    private static ArrayList<String> bagOfWords=new ArrayList<String>();

    public ArrayList<DataPoint> getData (ArrayList<String> folders,int nFT)throws Exception {
        ArrayList<DataPoint> data = new ArrayList<DataPoint>();
        int indx = 0;
        for (int i = 0; i < folders.size(); i++) {
            File fileDir = null;
            fileDir = new File(folders.get(i));
            File[] files = fileDir.listFiles();
            int nF = files.length;
            for (int j = 0; j < nF; j++) {
                DataPoint dp = new DataPoint();
                dp.setLabel(i);
                ArrayList<Integer> freqWords = new ArrayList<Integer>(nFT);
                for (int k = 0; k < nFT; k++) {
                    freqWords.add(k, 0);
                }
                BufferedReader reader = new BufferedReader(new FileReader(files[j]));
                Scanner in = new Scanner(reader);
                while (in.hasNext()) {
                    String temp = in.next().toLowerCase();
                    if (bagOfWords.contains(temp)) {
                        int indxW = bagOfWords.indexOf(temp);
                        int freqTemp = freqWords.get(indxW);
                        freqWords.set(indxW, freqTemp + 1);
                    }
                }
                in.close();
                reader.close();
                dp.setFeatures(freqWords);
                data.add(indx, dp);
                indx++;
            }
        }
        return data;
    }

    public void obtainTrainData()throws Exception{
        ArrayList<String> trainFolders=new ArrayList<String>();
        trainFolders.add(hamTrainFolder);
        trainFolders.add(spamTrainFolder);
        BagofWords bw=new BagofWords();
        bw.setTraingFolders(trainFolders);
        bw.generateBagOfWords();
        bagOfWords=bw.getBagOfWords();
        int nFeatures=bagOfWords.size();
        trainData=getData(trainFolders,nFeatures);
        System.out.println("Finish generating features for train data...");
        System.out.println("Finish Reading Data...");
        bw.getBagOfWords().clear();
    }
    public void obtainTestData()throws Exception{
        ArrayList<String> trainFolders=new ArrayList<String>();
        trainFolders.add(hamTrainFolder);
        trainFolders.add(spamTrainFolder);
        ArrayList<String> testFolders=new ArrayList<String>();
        testFolders.add(hamTestFolder);
        testFolders.add(spamTestFolder);
        BagofWords bw=new BagofWords();
        bw.setTraingFolders(trainFolders);
        bw.generateBagOfWords();
        bagOfWords=bw.getBagOfWords();
        int nFeatures=bagOfWords.size();
        testData=getData(testFolders,nFeatures);
        bw.getBagOfWords().clear();
        System.out.println("Finish generating features for test data...");

    }
    public void obtainKaggleData()throws Exception{
        ArrayList<String> trainFolders=new ArrayList<String>();
        trainFolders.add(hamTrainFolder);
        trainFolders.add(spamTrainFolder);
        ArrayList<String> kaggleFolders=new ArrayList<String>();
        kaggleFolders.add(kaggleTestFolder);
        BagofWords bw=new BagofWords();
        bw.setTraingFolders(trainFolders);
        bw.generateBagOfWords();
        bagOfWords=bw.getBagOfWords();
        int nFeatures=bagOfWords.size();
        kaggleTestData=getData(kaggleFolders,nFeatures);
        bw.getBagOfWords().clear();
        System.out.println("Finish generating features for kaggle data...");

    }
    public static void main(String[] args) throws Exception{
        ObtainSpamData sd=new ObtainSpamData();
        sd.obtainTrainData();
        sd.obtainKaggleData();
        sd.obtainTestData();
        System.out.println();
    }

    public ArrayList<DataPoint> getTrainData() {
        return trainData;
    }

    public void setTrainData(ArrayList<DataPoint> trainData) {
        this.trainData = trainData;
    }

    public ArrayList<DataPoint> getTestData() {
        return testData;
    }

    public void setTestData(ArrayList<DataPoint> testData) {
        this.testData = testData;
    }

    public ArrayList<DataPoint> getKaggleTestData() {
        return kaggleTestData;
    }

    public void setKaggleTestData(ArrayList<DataPoint> kaggleTestData) {
        this.kaggleTestData = kaggleTestData;
    }

    public ArrayList<String> getBagOfWords() {
        return bagOfWords;
    }

    public void setBagOfWords(ArrayList<String> bagOfWords) {
        this.bagOfWords = bagOfWords;
    }
}
