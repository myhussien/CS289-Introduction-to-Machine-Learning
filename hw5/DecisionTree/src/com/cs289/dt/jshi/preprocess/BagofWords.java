package com.cs289.dt.jshi.preprocess;

import com.cs289.dt.jshi.Properties;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

/**
 * Created by Jiaying Shi on 4/2/2015.
 * shijy07@gmail.com
 * Copyright © All Rights Reserved
 */
public class BagofWords {
    private ArrayList<String> bagOfWords=new ArrayList<String>();
    private ArrayList<String> traingFolders=new ArrayList<String>();
    private HashMap<String,Integer> sparcity=new HashMap<String, Integer>();
    public void generateBagOfWords()throws IOException{
        int n=traingFolders.size();
        for (int i=0;i<n;i++){
            File fileDir = null;
            fileDir = new File(traingFolders.get(i));
            File[] files = fileDir.listFiles();
            int nF=files.length;
            for(int j=0;j<nF;j++){
                BufferedReader reader = new BufferedReader(new FileReader(files[j]));
                Scanner in=new Scanner(reader);
                HashSet<String> fileSet=new HashSet<String>();
                while(in.hasNext()){
                    String temp = in.next().toLowerCase();
                    temp=temp.replaceAll("[!?,.0123456789\"-+/*:()-^&#]","");
                    if(!bagOfWords.contains(temp)&&(temp.length()!=0)&&(temp!=null)) {
                        bagOfWords.add(temp);
                        int nContains=1;
                        sparcity.put(temp,nContains);

                    }
                    if(bagOfWords.contains(temp)){
                        int nContains=sparcity.get(temp);
                        if(!fileSet.contains(temp)){
                            nContains=nContains+1;
                            sparcity.put(temp,nContains);
                        }
                    }
                   fileSet.add(temp);
                }

                in.close();
                reader.close();
            }
        }
        for(String key : sparcity.keySet()){
            if(sparcity.get(key)<30){
                bagOfWords.remove(key);
            }
        }
    }

    public static void main(String[] args) throws Exception
    {
        ArrayList<String>fl=new ArrayList<String>();
        fl.add(Properties.HAM_TRAIN_FOLDER);
        fl.add(Properties.SPAM_TRAIN_FOLDER);
        BagofWords bw=new BagofWords();
        bw.setTraingFolders(fl);
        bw.generateBagOfWords();
        for(int i=0;i<bw.getBagOfWords().size(); i++){
            System.out.println(String.valueOf(i)+" "+bw.getBagOfWords().get(i));
        }
        System.out.println();
    }
    public ArrayList<String> getBagOfWords() {
        return bagOfWords;
    }

    public void setBagOfWords(ArrayList<String> bagOfWords) {
        this.bagOfWords = bagOfWords;
    }

    public ArrayList<String> getTraingFolders() {
        return traingFolders;
    }

    public void setTraingFolders(ArrayList<String> traingFolders) {
        this.traingFolders = traingFolders;
    }
}
