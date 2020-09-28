class Neuron{
  private ArrayList<Float> weights = new ArrayList<Float>();
  private ArrayList<Neuron> dendrites = new ArrayList<Neuron>();
  private float axonValue, nonProcessed;
  
  void process(){
    axonValue = 0;
    for(int i=0; i<dendrites.size(); i++)
      axonValue += dendrites.get(i).axonValue * weights.get(i);
    nonProcessed = axonValue;
    axonValue = sigmoid(axonValue);
  }
  
  void setWeights(ArrayList<Float> weights){
    this.weights = weights;
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
