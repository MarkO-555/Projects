NeuralNetwork nn;

void setup() {
  float[][][] dataset = {
    {{0, 0}, {0}}, 
    {{0, 1}, {1}}, 
    {{1, 0}, {0}}, 
    {{1, 1}, {0}}
  };

  nn = new NeuralNetwork(dataset[0][0].length, 2, 2, dataset[0][1].length, false);

  float[][] result = new float[dataset.length][dataset[0][1].length];// = nn.feedForward(inputs);

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

  boolean debug = false;

  int num = 1000;
  for(int i=0; i<num; i++){
    if(debug){
      println("");
      println("Pass "+i+" has started");
    }

    nn.train(dataset);

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

  for(int v=0; v<dataset.length; v++){
    result[v] = nn.feedForward(dataset[v][0]);
  }

  println("");
  println("after");
  for(int v=0; v<result.length; v++){
    for(int j=0; j<result[v].length; j++){
      println("["+v+"]"+"["+j+"]", result[v][j]);
    }
  }
}

void keyPressed() {
  if (key == 's')
    nn.saveWeights();
}

void draw() {
}
