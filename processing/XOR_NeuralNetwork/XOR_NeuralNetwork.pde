NeuralNetwork nn = new NeuralNetwork(2, 1, 2, 2, false);

void setup(){
  float[] inputs = {0, 0};
  float[] expected = {1, 1};
  
  float[] result = nn.feedForward(inputs);
  
  println("");
  println("before");
  println(result);
  
  int num = 100;
  for(int i=0; i<num; i++){
    println("");
    println("Pass "+i+" has started");
    nn.train(inputs, expected);
    
    result = nn.feedForward(inputs);
    
    println(result);
  }
  
  //nn.train(inputs, expected);
}

void draw(){
  
}
