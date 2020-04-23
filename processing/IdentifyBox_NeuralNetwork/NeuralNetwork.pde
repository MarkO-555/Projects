class NeuralNetwork{
  private int Input, HiddenX, HiddenY, Output, WeightCount;
  private float[] weights;
  
  private Neuron[] Inputs, Outputs;
  private Neuron[][] Hiddens;
  
  void NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading){
    WeightCount = Input*HiddenX + HiddenX*HiddenY*HiddenY + HiddenY*Output;
    float[] weights = new float[WeightCount];
    
    if(loading){
      //load weights
    }
    else{
      for(int i=0; i<weights.length; i++)
        weights[i] = random(-1, 1);
    }
    
    this.NeuralNetwork(Input, HiddenX, HiddenY, Output, weights);
  }
  
  void NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, float[] weights){
    this.Inputs = new Neuron[Input];
    this.Hiddens = new Neuron[HiddenX][HiddenY];
    this.Outputs = new Neuron[Output];
    
    for(int i=0; i<this.Inputs.length; i++){
       this.Inputs[i] = new Neuron();
    }
    
    for(int i=0; i<this.Hiddens.length; i++){
      for(int j=0; j<this.Hiddens[i].length; j++){
        this.Hiddens[i][j] = new Neuron();
      }
    }
    
    for(int i=0; i<this.Outputs.length; i++){
       this.Outputs[i] = new Neuron();
    }
    
    int count =0;
    
    for(int i=0; i<Hiddens.length; i++){
      for(int j=0; j<Hiddens[i].length; j++){
        if(i==0){
          for(int k=0; k<Inputs.length; k++){
            Hiddens[i][j].addDendrite(Inputs[k], weights[count]);
            count++;
          }
        }
        else{
          for(int k=0; k<Hiddens[i-1].length; k++){
            Hiddens[i][j].addDendrite(Inputs[k], weights[count]);
            count++;
          }
        }
      }
    }
    
    for(int i=0; i<Outputs.length; i++){
      for(int j=0; j<Hiddens[Hiddens.length-1].length; j++){
        Outputs[i].addDendrite(Hiddens[Hiddens.length-1][j], weights[count]);
        count++;
      }
    }
  }
  
  public float[] feedForward(float[] inputs){
    float[] results = new float[Outputs.length];
    for(int i=0; i<inputs.length; i++){
      this.Inputs[i].axonValue = inputs[i];
    }
    for(int i=0; i<Hiddens.length; i++){
      for(int j=0; j<Hiddens[i].length; j++){
        Hiddens[i][j].process();
      }
    }
    for(int i=0; i<Outputs.length; i++){
      Outputs[i].process();
      results[i] = Outputs[i].axonValue;
    }
    return results;
  }
  
}
