NeuralNetwork nn;

void setup(){    
  
  
  //float[][][] dataset = {
  //  {{0, 0}, {0}},
  //  {{0, 1}, {1}},
  //  {{1, 0}, {1}},
  //  {{1, 1}, {0}}
  //};

 float[][][] dataset = {
    {{0, 0}, {0}},
    {{1, 1}, {1}}
  };
  
  nn = new NeuralNetwork(dataset[0][0].length, 2, 2, dataset[0][1].length, false);
  
  //float[] inputs = {1, 1};
  //float[] expected = {1, 1};
  
  float[][] result = new float[dataset.length][dataset[0][1].length];// = nn.feedForward(inputs);
  
  //result = nn.feedForward(inputs);
  
  for(int v=0; v<dataset.length; v++){
    result[v] = nn.feedForward(dataset[v][0]);
  }
  
  
  println("");
  println("before");
  for(int v=0; v<result.length; v++){
    for(int j=0; j<result[v].length; j++){
      println("["+v+"]"+"["+j+"]", result[v][j]);
    }
  }
  println("");
  
  boolean debug = true;
  
  int num = 100;
  for(int i=0; i<num; i++){
    if(debug){
      println("");
      println("Pass "+i+" has started");
    }
    //nn.train(inputs, expected);
    nn.train(dataset);
    
    //result = nn.feedForward(inputs);
    //result = nn.feedForward(dataset[0][0]);
    for(int v=0; v<dataset.length; v++){
      result[v] = nn.feedForward(dataset[v][0]);
    }
      
    if(debug){
      for(int v=0; v<result.length; v++){
        for(int j=0; j<result[v].length; j++){
          println("["+v+"]"+"["+j+"]", result[v][j]);
        }
      }
    }
  }
  
  //nn.train(inputs, expected);
  //result = nn.feedForward(inputs);
  //result = nn.feedForward(dataset[0][0]);
  for(int v=0; v<dataset.length; v++){
    result[v] = nn.feedForward(dataset[v][0]);
  }
  
  
  println("");
  println("after");
  //println(result);
  for(int v=0; v<result.length; v++){
    for(int j=0; j<result[v].length; j++){
      println("["+v+"]"+"["+j+"]", result[v][j]);
    }
  }
}

void keyPressed(){
  if(key == 's')
    nn.saveWeights();
}

void draw(){
  
}
