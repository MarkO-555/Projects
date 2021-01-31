NeuralNetwork nn;
CounterThread CT;
ResultThead RT;
MainThread MT;

float Size = 25;
float Distance = 100;

int TrainCount = 0;
int TrainMax = 2;
float[][] result;
float[][] lastResult;

boolean debug = false;
boolean Counting = false;

float[][][] dataset = {
  {{0.05, 0}, {0}}, 
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
  
  MT.start();
}

void keyPressed() {
  if (key == 's')
    nn.saveWeights();
}


boolean started = false;
void draw() {
  background(200);
  //text("test",10, 10);
  for(int i=0; i<nn.Neurons.length; i++){
    fill(255);
    Neuron n =  nn.Neurons[i];
    
    ellipse(n.getX(), n.getY(), Size, Size);
    
    for(int j=0; j<n.dendrites.size(); j++){
      Neuron tn = n.dendrites.get(j);
      float weight = n.weights.get(j);
      fill(0);
      line(n.getX(), n.getY(), tn.getX(), tn.getY());
      
      //println();
      
      float scaler = 1.2;
      
      float x = n.getX() - (n.getX() - tn.getX())/scaler;
      float y = n.getY() - (n.getY() - tn.getY())/scaler;
      
      text(weight, x, y);
    }
  }
  
  
  //text("inputs", width-100, 80);
  String str = "";
  
  String inputstr = "";
  String outputstr = "";
  String expectedstr = "";
  
  int inputlen = 0;
  int outputlen = 0;
  
  for(int i=0; i<dataset.length; i++){
    inputstr = "";
    expectedstr = "";
    outputstr = "";
    
    float[] inputs = dataset[i][0];
    float[] expected = dataset[i][1];
    for(int v=0; v<inputs.length; v++){
      if(inputstr != "")
        inputstr += ", ";
        
      int Ilen = inputstr.length();
      
      inputstr += inputs[v];
      
      Ilen = inputstr.length() - Ilen;
      if(inputlen < Ilen){
        inputlen = Ilen;        
      }
      else if(inputlen > Ilen){
        inputstr+="0";
      }
    }
    
    for(int v=0; v<expected.length; v++){
      if(expectedstr != "")
        expectedstr += ", ";
      expectedstr += expected[v];
    }
    
    outputstr += result[i][0];
    
    int Olen = outputstr.length();
    
    if(outputlen < Olen){
      outputlen = Olen;        
    }
    else if(outputlen > Olen){
      outputstr+="0";
    }
    
    str = " "+inputstr+"  "  + outputstr +" ";
    
    //7 length of characters!!!
    text(str, width-100 - 50, 30+i*10);
  }
  
  
  text("Input", width-100- 50 +15, 17);
  text("Ouput", width-100 - 50 +inputstr.length()*6.5, 17);
  //text("Expected", width-100 - (str.length()*4)+(inputstr.length()*6.5), 20);
  
}

void mousePressed(){
  RT.run();
}
