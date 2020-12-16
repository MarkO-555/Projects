NeuralNetwork nn;
  
void setup(){    
  
  nn = new NeuralNetwork(2, 1, 2, 2, false);
  
  float[] inputs = {1, 1};
  float[] expected = {0, 0, 0};
  
  float[] result = new float[2];// = nn.feedForward(inputs);
  
  result = nn.feedForward(inputs);
  
  println("");
  println("before");
  println(result);
  println("");
  
  boolean debug = false;
  
  int num = 1;
  for(int i=0; i<num; i++){
    if(debug){
      println("");
      println("Pass "+i+" has started");
    }
    nn.train(inputs, expected);
    
    result = nn.feedForward(inputs);
    
    if(debug)
      println(result);
  }
  
  //nn.train(inputs, expected);
  result = nn.feedForward(inputs);
  
  
  println("");
  println("after");
  println(result);
}

void keyPressed(){
  if(key == 's')
    nn.saveWeights();
}

void draw(){
  
}
