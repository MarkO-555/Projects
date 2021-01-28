NeuralNetwork nn;
CounterThread CT;
ResultThead RT;
MainThread MT;

float Size = 25;
float Distance = 100;

int TrainCount = 0;
int TrainMax = 1000;
float[][] result;
float[][] lastResult;

boolean debug = false;
boolean Counting = false;

float[][][] dataset = {
  {{0, 0}, {0}}, 
  {{0, 1}, {1}}, 
  {{1, 0}, {1}}, 
  {{1, 1}, {0}}
};

void setup() {
  size(800, 800);
  nn = new NeuralNetwork(dataset[0][0].length, 4, 3, dataset[0][1].length, false);
  if(Counting)
    CT = new CounterThread();
  RT = new ResultThead();
  MT = new MainThread();

  result = new float[dataset.length][dataset[0][1].length];
  lastResult = new float[dataset.length][dataset[0][1].length];
}

void keyPressed() {
  if (key == 's')
    nn.saveWeights();
}


boolean started = false;
void draw() {
  if(!started)
    MT.start();
  for(int i=0; i<nn.Neurons.length; i++){
    Neuron n =  nn.Neurons[i];
    
    ellipse(n.getX(), n.getY(), Size, Size);
    
    for(int j=0; j<n.dendrites.size(); j++){
      Neuron tn = n.dendrites.get(j);
      
      line(n.getX(), n.getY(), tn.getX(), tn.getY());
    }
  }
}

void mousePressed(){
  RT.run();
}
