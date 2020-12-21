class Neuron{
  private ArrayList<Float> weights = new ArrayList<Float>();
  private ArrayList<Neuron> dendrites = new ArrayList<Neuron>();
  private float axonValue, nonProcessed;
  
  private ArrayList<Float> errors = new ArrayList<Float>();
  private float error;
  
  void process(){
    axonValue = 0;
    for(int i=0; i<dendrites.size(); i++)
      axonValue += dendrites.get(i).axonValue * weights.get(i);
      
    nonProcessed = axonValue;
    axonValue = sigmoid(axonValue);
  }
  
  void setError(float error){
    this.error = error; 
  }
  
  void addError(float error){
    errors.add(error); 
  }
  
  void processErrors(){
    for(int i=0; i<errors.size(); i++){
      error += errors.get(i); 
    }
    error /= errors.size();
  }
  
  float getWeight(int index){
   return weights.get(index); 
  }
  
  int weightlen(){
    return weights.size(); 
  }
  
  float getError(){
    return this.error; 
  }
  
  void setWeights(ArrayList<Float> weights){
    this.weights = weights;
  }
  
  void setDendrite(int index, Neuron n){
    //println(index, dendrites.size());
    dendrites.set(index, n); 
  }
  
  void clearWeights(){
    this.weights = new ArrayList<Float>();
  }
  
  float getAxon(){
   return axonValue; 
  }
  
  float getNonProcessedAxon(){
   return nonProcessed;
  }
  
  void addDendrite(Neuron neuron, float weight){
    dendrites.add(neuron);
    weights.add(weight);
  }
}
