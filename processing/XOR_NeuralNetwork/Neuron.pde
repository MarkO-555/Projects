class Neuron{
  private ArrayList<Float> weights = new ArrayList<Float>();
  private ArrayList<Float> errors = new ArrayList<Float>();
  private ArrayList<Neuron> dendrites = new ArrayList<Neuron>();
  private float axonValue, nonProcessed;
  
  private float error;
  private float axonDerivative;
  
  private float xPos = 0;
  private float yPos = 0;
  
  void process(){
    axonValue = 0;
    for(int i=0; i<dendrites.size(); i++)
      axonValue += dendrites.get(i).axonValue * weights.get(i);
      
    nonProcessed = axonValue;
    axonValue = sigmoid(axonValue);
    axonDerivative = axonValue * (1-axonValue);
  }
  
  float getDerivitive(){
    return axonDerivative; 
  }
  
  void setX(float xPos){
    this.xPos = xPos; 
  }
  void setY(float yPos){
    this.yPos = yPos; 
  }
  
  float getX(){
    return xPos; 
  }
  
  float getY(){
    return yPos; 
  }
  
  void setError(float error){
    this.error = error; 
  }
  
  void addError(float error){
    errors.add(error); 
  }
  
  void processErrors(){
    this.error = 0;
    for(int i=0; i<this.errors.size(); i++){
      this.error += this.errors.get(i); 
    }
    this.error /= errors.size();
    errors = new ArrayList<Float>();
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
