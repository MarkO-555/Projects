NeuralNetwork nn = new NeuralNetwork(2, 2, 2, 2, false);

void setup(){
  float[] inputs = {0};
  
  //nn.train(inputs,expected);
  
  float[] result = nn.feedForward(inputs);
  
  //println(result);
  

}

void draw(){
  
}
