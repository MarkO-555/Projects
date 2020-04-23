class Network{
  int InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes;
  int weightsCount =0;
  
  Neuron[] Inputs, Hiddens[], Outputs;
  
  float[] weights;
  float fitness = 0;
  
  Network(int InputNodes_, int HiddenXNodes_, int HiddenYNodes_, int OutputNodes_, int weightCount, boolean loading){
    if(loading)
      init(InputNodes_, HiddenXNodes_, HiddenYNodes_, OutputNodes_, loadWeights(weightCount));
    else{
     float[] weights = new float[weightCount];
        
      for (int j=0; j<weights.length; j++) {
        weights[j] = random(-1, 1);
      }
      init(InputNodes_, HiddenXNodes_, HiddenYNodes_, OutputNodes_, weights);
    }
  }
  
  Network(int InputNodes_, int HiddenXNodes_, int HiddenYNodes_, int OutputNodes_, float[] weights_){
    init(InputNodes_, HiddenXNodes_, HiddenYNodes_, OutputNodes_, weights_);
  }
  
  private void init(int InputNodes_, int HiddenXNodes_, int HiddenYNodes_, int OutputNodes_, float[] weights_){
     
    InputNodes = InputNodes_;
    HiddenXNodes = HiddenXNodes_;
    HiddenYNodes = HiddenYNodes_;
    OutputNodes = OutputNodes_;
    weights = weights_;
    
    Inputs = new  Neuron[InputNodes];
    Hiddens = new Neuron[HiddenXNodes][HiddenYNodes];//bug??
    Outputs = new Neuron[OutputNodes];
    
    for(int i=0; i<InputNodes; i++){
      Inputs[i] = new Neuron();
    }
    
    for(int i=0; i<HiddenXNodes; i++){
      for(int v=0; v<HiddenYNodes; v++){
         Hiddens[i][v] = new Neuron();
         float[] w = new float[Inputs.length];
         if(i==0){
           for(int j=0; j<Inputs.length; j++){
             w[j] = weights[weightsCount];
             weightsCount++;
           }
           Hiddens[i][v].addDendrite(Inputs, w);
         }
         else{
           for(int j=0; j<HiddenYNodes; j++){
             w[j] = weights[weightsCount];
             weightsCount++;
           }
           Hiddens[i][v].addDendrite(Hiddens[i-1], w);
         }
      }
    }
    
    for(int i=0; i<OutputNodes; i++){
      float[] w = new float[Inputs.length];
      Outputs[i] = new Neuron();
      for(int j=0; j<HiddenYNodes; j++){
        w[j] = weights[weightsCount];
        weightsCount++; 
      }
      
      Outputs[i].addDendrite(Hiddens[HiddenXNodes-1], w);
    }
    
  }
  
  //public Thread FeedForward = new FeedForwardThread(this, Inputs);
  
  //public float[] feedForward(float[] Inputs_){
  //  FeedForward.start();
  //  float[] result = new float[Outputs.length];
  //  for(int i=0; i<result.length; i++){
  //    result[i] = Outputs[i].axonValue; 
  //  }
  //  return result;
  //}
  
  public float[] feedForward(float[] Inputs_){
    float[] Result = new float[Outputs.length];
    
    if(Inputs.length != Inputs_.length){
      println("inputs must have the same length");
      return Result;
    }
    
    for(int i=0; i<Inputs_.length; i++){
      Inputs[i].axonValue = Inputs_[i];
    }
    for(int i=0; i<HiddenXNodes; i++){
      for(int j=0; j<HiddenYNodes; j++){
        Hiddens[i][j].process();
      } 
    }
    for(int i=0; i<Outputs.length; i++){
      Outputs[i].process(); 
    }
    for(int i=0; i<Result.length; i++){
      Result[i] = Outputs[i].axonValue;
    }
    
    return Result;
  }
  
  public Network Copy(){
    return new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights);
  }
  
  public void saveWeights(){
    PrintWriter weightLog;
    
    weightLog = createWriter("Weights.txt");
    
    for(int i=0; i<weights.length; i++){
      weightLog.println(weights[i]); 
    }
    weightLog.flush();
    //PrintWriter hiddenLog, outputLog;
    
    //hiddenLog = createWriter("Hiddens.txt");
    //outputLog = createWriter("Outputs.txt");
    
    //for(int i=0; i<Hiddens.length; i++){
    //  for(int j=0; j<Hiddens[i].length; j++){
    //    for(int k=0; k<Hiddens[i][j].weights[k]; k++){
    //      hiddenLog.println(Hiddens[i][j].weights[j]);
    //      println(Hiddens[i][j].weights[k]);
    //    }
    //  }
    //}
    //hiddenLog.flush(); 
    
    //for(int i=0; i<Outputs.length; i++){
    //  for(int j=0; j<Outputs[i].weights.length; j++){
    //    outputLog.println(Outputs[i].weights[j]);
    //  }
    //}
    //outputLog.flush();
  }
  
  
  public float[] loadWeights(int weightCount){
    //BufferedReader hiddenLog = createReader("Hiddens.txt");
    //BufferedReader outputLog = createReader("Outputs.txt");
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
      
      //while ((line = hiddenLog.readLine()) != null) {
      //  weights_[i] = float(line);
      //  i++;
      //}
      //hiddenLog.close();
      
      //while((line = outputLog.readLine()) != null){
      //  weights_[i] = float(line);
      //  i++;
      //}
      //outputLog.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    
    return weights_;
  }
  
  public boolean equals(Network net){
    for(int i=0; i<net.weights.length; i++)
      if(weights[i] != net.weights[i])
        return false;
    return true;
  }
}
