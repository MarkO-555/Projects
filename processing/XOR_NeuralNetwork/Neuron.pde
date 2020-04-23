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
  
  void updateWeights(ArrayList<Float> weights){
    this.weights = weights;
  }
  
  void clearWeights(){
    this.weights = new ArrayList<Float>();
  }
  
  float getAxon(){
   return axonValue; 
  }
  
  void addDendrite(Neuron neuron, float weight){
    dendrites.add(neuron);
    weights.add(weight);
  }
  
  private float sigmoid(float x) {
    return (float)(1/( 1 + Math.pow(Math.E,(-1*x))));
  }
  
  private int bianary(float x){
    float thesh = 0.5;
    if(x>=thesh)
      return 1;
    return 0;
  }
  private float linear(float x){
    float slope =1;
    float yint =0;
    
    return slope*x+yint;
  }
  
  private float relu(float x){
    float thesh =0;
    float lower =0;
    if(x<thesh)
      return lower;
    return x;  
  }
}
