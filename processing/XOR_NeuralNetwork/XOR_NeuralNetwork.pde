NeuralNetwork nn;
CounterThread CT;
ResultThead RT;
MainThread MT;

int TrainCount = 0;
int TrainMax = 10;
float[][] result;
float[][] lastResult;

boolean debug = true;
boolean Counting = false;

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
  MT = new MainThread();

  result = new float[dataset.length][dataset[0][1].length];
  lastResult = new float[dataset.length][dataset[0][1].length];
  
  MT.run();
}

void keyPressed() {
  if (key == 's')
    nn.saveWeights();
}

void draw() {

}
