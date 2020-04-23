class trainingData{
  byte[] trainSet, labelSet;
  private int[] indexs;
  public int count = 0;
  private int indexCount =0;
  int current;
  
  trainingData(){
    
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(30);
    
    trainSet = loadBytes("train-images.idx3-ubyte");
    labelSet = loadBytes("train-labels.idx1-ubyte");
  
    //current = int(random(getCount()));
    indexs = new int[getCount()];
    
    nextNum();
  }
  
  public int getNum(float[] outputs){
    int BestIndex =0;
    float bestNum =0;
    for(int i=0; i<outputs.length; i++){
       if(outputs[i] > bestNum){
         BestIndex = i;
         bestNum = outputs[i];
       }
    }
    return BestIndex;
  }
  
  
  public void nextNum(){
    int index = int(random(getCount()));
    
    while(index==current){
        index = int(random(getCount()));
    }
    
    current = index;
    
    //indexs[indexCount] = current;
    //indexCount++;
  }
  
  public int getCount(){
    return (trainSet.length-45)/784;
  }
  
  public int getCurrentnum(){
    return int(labelSet[current +8]); 
  }
  
  public int[] getCurrentPixs(){
    int[] pixs = new int[28*28];
    for (int i = 0; i < 28; i++) {
      for (int j = 0; j < 28; j++) {
        pixs[i*28 +j] = int(trainSet[784*current+28*i+j +16]);
      }
    }
    return pixs;
  }
  
  public float[] getCurrentExpected(){
   int[] expected = new int[10];
   int currentnum = int(labelSet[current +8]);
   
   for(int i=0; i<expected.length; i++){
     expected[i] = 0; 
   }
   
   expected[currentnum] = 1;
   
   return float(expected);
  }
  
  void display(){
    for(int i=0; i<28; i++){
      for(int j=0; j<28; j++){
        fill(getCurrentPixs()[i*28 +j]); //the first 16 bits are meta data
        rect(cellSize*j, cellSize*i, cellSize, cellSize);
      }
    }
    
    fill(255, 0, 0);
    text(int(labelSet[current +8]), 30, 30); //the first 8 bits are meta data
  }
  
}
