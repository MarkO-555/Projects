class NeuralNetwork{
  private float Weightrange = 10;
  
  private Neuron[] Neurons;
  
  private int[] Inputs;
  private int[][] Hiddens;
  private int[] Outputs;
  
  private float[] weights;
  private int[] weightsmap;
  private int[] weightsHXmap;
  private int[] weightsHYmap;
  
  private float learningrate = 0.1;
  
  NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading){
    Inputs = new int[Input];
    Hiddens = new int[HiddenX][HiddenY];
    Outputs = new int[Output];
    Neurons = new Neuron[Input+HiddenX*HiddenY+Output];
    
    int weightCount = 0;
    if(HiddenX>0)
      weightCount = Input*HiddenY + (HiddenX - 1)*HiddenY*HiddenY + HiddenY*Output;
    else
      weightCount = Input*HiddenY+HiddenY*Output;
    
    weights = new float[weightCount];
    weightsmap = new int[weightCount];
    weightsHXmap = new int[weightCount - Input*HiddenY - HiddenY*Output];
    weightsHYmap = new int[weightCount - Input*HiddenY - HiddenY*Output];
    
    initWeights(loading);
    
    int y = 0;
    int Count = 0;
    
    for(int i=0; i<Input; i++){
      Inputs[i] = y;
      Neurons[y] = new Neuron();
      y++;
    }
    
    for(int i=0; i<HiddenX; i++){
      for(int v=0; v<HiddenY; v++){
        Hiddens[i][v] = y;
        Neurons[y] = new Neuron();
            
        if(i==0){
          for(int j=0; j<Input; j++){
            Neurons[y].addDendrite(new Neuron(), weights[Count]);
            Count++;
          }
        }
        else{
          for(int j=0; j<HiddenY; j++){
            Neurons[y].addDendrite(Neurons[Hiddens[i-1][j]], weights[Count]);
            Count++;
          }
          Count -= HiddenY;
        }
        y++;
      }
    }
    
    
    for(int i=0; i<Output; i++){
      Outputs[i] = y;
      Neurons[y] = new Neuron();
      
      for(int j=0; j<HiddenY; j++){
        Neurons[y].addDendrite(Neurons[Hiddens[HiddenX-1][j]], weights[Count]);
        Count++;
      }
         
      y++;
    }
  }
  
  private void initWeights(boolean loading){
    int count =0;
    int xcount =0;
    int ycount =0;
    
    if(loading)
      weights = loadWeights(weights.length);
    else{
      for(int i=0; i<weights.length; i++){
        //weights[i] = 1;
        weights[i] = random(-Weightrange, Weightrange);
        
        if(i<=Inputs.length * Hiddens[0].length-1)//IH
          weightsmap[i] = 0;
        else if(i<=Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length,2)-1){//HH
          weightsmap[i] = 1;
          
          if(ycount >= Hiddens[0].length){
            xcount++;
            ycount=0;
          }
          
          weightsHXmap[count]=xcount;
          weightsHYmap[count]=ycount;
          ycount++;
          count++;
        }
        else if(i<=Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length,2) + Hiddens[0].length*Outputs.length-1)//HO
          weightsmap[i] = 2;
      }
    }
  }
  
  public float[] feedForward(float[] Inputs){
    int len = this.Inputs.length;
    
    if(len != Inputs.length){
      println("The inputs length is not expected value");
    }
    
    for(int i=0; i<Neurons.length-len; i++){
      Neurons[len+i].process();
    }
      
    len = this.Outputs.length;
    float[] Outputs = new float[len];
    
    for(int i=0; i<len; i++)
      Outputs[i] = Neurons[this.Outputs[i]].axonValue;
      
    return Outputs;
  }
  
  public void train(float[] inputs, float[] expected){
    int len = expected.length;
    float[] result = feedForward(inputs);
    float[] error = new float[len];
    float avr = 0;
    
    //Neuron[][] hiddens = new Neuron[Hiddens.length][Hiddens[0].length];
    float[][] hiddens = new float[Hiddens.length][Hiddens[0].length];
    
    
    for(int x=0; x<Hiddens.length; x++){
      for(int y=0; y<Hiddens[x].length; y++){
        hiddens[x][y] = Neurons[Hiddens[x][y]].axonValue;
      }
    }
    
    for(int i=0; i<len; i++){
       error[i] = (float)Math.pow(expected[i] - result[i], 2);
       avr+= error[i];
    }
    
    //avr /= len;
    
    len = weights.length;
    
    //println(weightsmap);
        
    for(int i=0; i<len; i++){
      float nonproc = 1;
      
      //println(weightsmap[i], i%2);
      
      if(weightsmap[i] == 0){//Connected Hiddens, Inputs
        nonproc = inputs[i%inputs.length];
      }
      else if(weightsmap[i] == 1){//Connected Hiddens, Hiddens
        nonproc = 0; 
      }
      else{//Connected to Outputs, Hiddens
        nonproc = result[i%result.length];
      }
      
      nonproc = dSigmoid(nonproc);
      weights[i] += learningrate * avr * nonproc;//delta = LearningRate * AverageError *
    }
    
    updateWeights();
  }
  
  
  
  private void updateWeights(){
    //println("");
    
    ArrayList<Float> ls = new ArrayList();  
      
    int Count = 0;
    for(int i=0; i<Neurons.length; i++){
      ArrayList<Float> nW = new ArrayList<Float>(); 
      Neuron n = Neurons[i];
      
      for(int v=0; v<n.weights.size(); v++){
        ls.add(weights[Count]);
        nW.add(weights[Count]);
        Count++;
      }
      
      //println(nW, n.weights, nW.equals(n.weights));
      
      n.setWeights(nW);
    }
    
    //println("");
    //for(int i=0; i<weights.length; i++){
    //  println(weights[i], ls.get(i), weights[i] == ls.get(i));
    //}
    
  }
  
  private void saveWeights(){
    PrintWriter weightLog;
    
    weightLog = createWriter("Weights.txt");
    
    for(int i=0; i<weights.length; i++){
      weightLog.println(weights[i]); 
    }
    weightLog.flush();
    
    println("saved Network");
  }
  
  private float[] loadWeights(int weightCount){
    BufferedReader weightsLog = createReader("Weights.txt");
    
    float[] weights_ = new float[weightCount];
    String line = null;
    int i=0;
    
    try {
      while ((line = weightsLog.readLine()) != null) {
        weights_[i] = float(line);
        i++;
      }
      weightsLog.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    
    return weights_;
  }
}
