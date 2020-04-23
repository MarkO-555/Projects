class NeuralNetwork{
  private float range = 1;
  
  private Neuron[] Neurons;
  
  private int[] Inputs;
  private int[][] Hiddens;
  private int[] Outputs;
  private float[] weights;
  private int[] weightsdef;
  
  private float learningrate =0.1;
  
  NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading){
    
    Inputs = new int[Input];
    Hiddens = new int[HiddenX][HiddenY];
    Outputs = new int[Output];
    Neurons = new Neuron[Input+HiddenX*HiddenY+Output];
    
    int weightCount = 0;
    if(HiddenX>0)
      weightCount = Input*HiddenY+ (int)Math.pow(HiddenY,HiddenX-1)+HiddenY*Output;
    else
      weightCount = Input*HiddenY+HiddenY*Output;
    
    weights = new float[weightCount];
    weightsdef = new int[weightCount];
    
    initWeights(loading);
    println(weightsdef);
    
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
          }
        }
        else{
          for(int j=0; j<HiddenY; j++){
            Neurons[y].addDendrite(Neurons[Hiddens[i-1][j]], weights[Count]);
            
          } 
        }
        Count++;
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
  
  void initWeights(boolean loading){
    if(loading)
      weights = loadWeights(weights.length);
    else{
      for(int i=0; i<weights.length; i++){
        weights[i] = 1;//random(-range, range);
        
        println("IH",Inputs.length * Hiddens[0].length);
        println("HH",Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length,2));
        println("HO",Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length,2) + Hiddens[0].length*Outputs.length);
        if(i<=Inputs.length*Hiddens[0].length-1)
          weightsdef[i] = 0;
        else if(i<=Inputs.length*Hiddens[0].length)
          weightsdef[i] = 1;
        else if(i<=2)
          weightsdef[i] = 2;
        
        //Inputs, Hiddens, Outputs
        // Inputs * HiddenY + (HiddenX-1) * HiddenY^2 + HiddenY * Outputs  Weights!!!
      }
    }
  }
  
  float[] feedForward(float[] Inputs){
    int len = this.Inputs.length;
    
    if(len != Inputs.length){
      println("fed Inputs length is not expected value");
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
  
  void train(float[] inputs, float[] expected){
    int len = expected.length;
    float[] result = feedForward(inputs);
    float[] error = new float[len];
    float avr = 0;
    
    for(int i=0; i<len; i++){
       error[i] = (float)Math.pow(expected[i] - result[i], 2);
       avr+= error[i];
    }
    
    avr/=len;
    
    len = weights.length;
    
    for(int i=0; i<len; i++){
       //weights[i] += learningrate * avr * connectedValue;
    }
  }
  
  public void saveWeights(){
    PrintWriter weightLog;
    
    weightLog = createWriter("Weights.txt");
    
    for(int i=0; i<weights.length; i++){
      weightLog.println(weights[i]); 
    }
    weightLog.flush();
  }
  
  
  public float[] loadWeights(int weightCount){
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
