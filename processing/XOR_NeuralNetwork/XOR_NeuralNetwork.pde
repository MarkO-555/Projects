NeuralNetwork nn;
//CounterThread CT;
//MainThread MT;

float Size = 25;
float Distance = 100;

int TrainCount = 0;
int TrainMax = 100;

float[][] resulted;
float[][] lastResult;
float error = 100;//stand in (temp, needs to be high number!!!)
float scale = 1;

boolean debug = false;
boolean Counting = false;
boolean limit = false;
boolean Running = true;

PVector mousePos;
PVector pos;
PVector prevPos;
boolean mouseDown = false;

float[][][] dataset = {
  {{0, 0}, {1}}, 
  {{0, 1}, {0}}, 
  {{1, 0}, {0}}, 
  {{1, 1}, {1}}
};

//float[][][] dataset = {
//  {{0, 1}, {1}},
//  {{1, 0}, {0}}
//};

void setup() {
  
  //size(800, 800);
  fullScreen();
  
  mousePos = new PVector();
  pos = new PVector(0, 0);
  nn = new NeuralNetwork(dataset[0][0].length, 1, 10, dataset[0][1].length, true);
  //if(Counting)
  //  CT = new CounterThread();
  //MT = new MainThread();

  resulted = new float[dataset.length][dataset[0][1].length];
  lastResult = new float[dataset.length][dataset[0][1].length];
  UpdateResult();
  
  //MT.start();
  //thread("mainThread");
}

void draw() {
  background(200);
  if(Running){
    UpdateResult();
    if(mainThread()){
      println("Done!!!!");
      nn.saveWeights();
      Running = false;
    }
  }
  if(mouseDown){
    pos.set(prevPos.copy().sub(mousePos.x-mouseX, mousePos.y-mouseY));
  }
  
  //text("test",10, 10);
  push();
  translate(pos.x, pos.y);
  for(int i=0; i<nn.Neurons.length; i++){
    fill(255);
    Neuron n =  nn.Neurons[i];
    
    ellipse(n.getX()/scale, n.getY()/scale, Size/scale, Size/scale);
    
    for(int j=0; j<n.dendrites.size(); j++){
      Neuron tn = n.dendrites.get(j);
      float weight = n.weights.get(j);
      //fill(weight);
      fill(0);
      line(n.getX()/scale, n.getY()/scale, tn.getX()/scale, tn.getY()/scale);
      
      //println();
      
      float scaler = 1.2;
      
      float x = n.getX() - (n.getX() - tn.getX())/scaler;
      float y = n.getY() - (n.getY() - tn.getY())/scaler;
      
      text(weight, x/scale, y/scale);
    }
  }
  
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
    //println(expected);
    
      for(int v=0; v<resulted[i].length; v++){
        if(outputstr != "")
          outputstr += ", ";
        outputstr += resulted[i][v];
      }
    
    int Olen = outputstr.length();
    
    if(outputlen < Olen){
      outputlen = Olen;        
    }
    else if(outputlen > Olen){
      outputstr+="0";
    }
    str = " "+inputstr+"  "  + outputstr +" ";
    
    pop();
      fill(0);
      translate(0, 0);
      //text(str, width-100 - 50 -outputstr.length() -inputstr.length(), 30+i*10);
      text(str, width-100 - 50 -100*(expected.length-1), 30+i*10);
    push();
  }
  pop();
  
  text("Input", width-100- 70 +15, 17);
  text("Ouput", width-100 - 70 +inputstr.length()*6.5, 17);
  
  
  
  text("Average Error", width-100, 30+ dataset.length*10 + 10);
  text(""+error, width-100 ,30 + dataset.length*10 + 22.5);
  //text("Expected", width-100 - (str.length()*4)+(inputstr.length()*6.5), 20);
  
  
  //println(resulted[0]);
}

void mousePressed(){
  mouseDown = true;
  prevPos = pos.copy();
  mousePos.set(mouseX, mouseY);
}
void mouseReleased(){
  mouseDown = false;
}

void mouseWheel(MouseEvent event) {
  float delta = (float)event.getCount()/10;
  if(scale + delta == 0)
    scale += delta;
  scale += delta;
}
