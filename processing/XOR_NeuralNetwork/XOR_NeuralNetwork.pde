NeuralNetwork nn = new NeuralNetwork(2, 2, 2, 2, false);

void setup(){
  float[] inputs = {0, 0};
  float[] expected = {1,1};
  
  //nn.train(inputs,expected);
  
  float[] result = nn.feedForward(inputs);
  nn.train(inputs, expected);
  
  println("");
  println("before");
  println(result);
  
  result = nn.feedForward(inputs);
  
  println("");
  println("after");
  println(result);

}

void draw(){
  
}
