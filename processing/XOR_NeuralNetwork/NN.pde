class NeuralNetwork{
  private float range = 1;
  
  private Neuron[] Neurons;
  
  private int[] Inputs;
  private int[][] Hiddens;
  private int[] Outputs;
  
  private float[] weights;
  private int[] weightsmap;
  private int[] weightsHXmap;
  private int[] weightsHYmap;
  
  private float learningrate =0.1;
  
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
    
    //println(weightsmap);
    //println("X");
    //println(weightsHXmap);
    //println("Y");
    //println(weightsHYmap);
    
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
    int count =0;
    int xcount =0;
    int ycount =0;
    
    if(loading)
      weights = loadWeights(weights.length);
    else{
      for(int i=0; i<weights.length; i++){
        weights[i] = 1;//random(-range, range);
        
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
    
    println(weightsmap);
      
    for(int i=0; i<len; i++){
      float nonproc = 1;
      
      if(weightsmap[i] == 0){//Connected Hiddens, Inputs
        int count =0;
        int y=0;
        
        if(count>Hiddens[0].length){
          count=0;
          y++;
        }
        
        nonproc = Neurons[Hiddens[0][y]].getNonProcessedAxon();
        count++;
      }
      else if(weightsmap[i] == 1){//Connected Hiddens, Hiddens
        int count =0;
        int y=0;
        
        if(count>Hiddens[0].length){
          count=0;
          y++;
        }
        
        Neurons[Hiddens[weightsHXmap[i-inputs.length]][weightsHYmap[i-inputs.length]]].getNonProcessedAxon();
        
        nonproc=0;
        count++;
      }
      else{//Connected to Outputs, Hiddens
      
      }
        
      weights[i] += learningrate * avr * nonproc;
    }
  }
  
  private float dSigmoid(float x){
    return sigmoid(x) * (1 - sigmoid(x)); 
  }
  
  private float sigmoid(float x) {
    return (float)(1/( 1 + Math.pow(Math.E,(-1*x))));
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
