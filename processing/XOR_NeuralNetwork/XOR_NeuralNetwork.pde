NeuralNetwork nn;
CounterThread CT;
ResultThead RT;

int TrainCount = 0;
int TrainMax = 10000;
float[][] result;

boolean debug = false;
boolean Counting = true;

//boolean running = true;

  float[][][] dataset = {
    {{0, 0}, {0}}, 
    {{0, 1}, {1}}, 
    {{1, 0}, {1}}, 
    {{1, 1}, {0}}
  };

void setup() {
  nn = new NeuralNetwork(dataset[0][0].length, 1, 5, dataset[0][1].length, false);
  if(Counting)
    CT = new CounterThread();
  RT = new ResultThead();

  result = new float[dataset.length][dataset[0][1].length];// = nn.feedForward(inputs);

  println("Begining");
  RT.run();
  
  for(int i=0; i<TrainMax; i++){
    if(Counting)
      CT.run();

    nn.train(dataset);

    if(debug)
      RT.run();
    
    TrainCount = i;
  }

  for(int v=0; v<dataset.length; v++){
    result[v] = nn.feedForward(dataset[v][0]);
  }
  
  println("");
  println("after");
  RT.run();
}

void keyPressed() {
  if (key == 's')
    nn.saveWeights();
}

void draw() {
  //if(TrainCount < TrainMax){
  //  if(Counting)
  //    CT.run();
  //  nn.train(dataset);
    
  //  if(debug)
  //    RT.run();
  //  TrainCount++;
  //}
  //else if(running){
  //  RT.run();
  //  running = false;
  //}
}
