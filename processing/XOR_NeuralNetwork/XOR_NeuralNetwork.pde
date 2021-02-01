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

float Xscale =1;
float Yscale =1;

float thresh = 0.0001;

boolean debug = false;
boolean Counting = false;
boolean limit = false;
boolean Running = true;

PVector mousePos;
PVector pos;
PVector prevPos;
boolean mouseDown = false;

float[][][] dataset = {
  
  {{0.25, 0.00}, {0.90}},
  {{0.00, 0.25}, {1.00}},
  {{0.25, 0.25}, {0.00}},
  
  {{0.50, 0.00}, {0.50}},
  {{0.00, 0.50}, {0.10}},
  {{0.50, 0.50}, {0.70}},
  
  {{0.75, 0.00}, {0.05}},
  {{0.00, 0.75}, {0.10}},
  {{0.75, 0.75}, {0.00}},
  
  {{0, 0}, {1}},
  {{0, 1}, {0}}, 
  {{1, 0}, {0}}, 
  {{1, 1}, {1}}
};

//float[][][] dataset = {
  
//  {{0.25, 0.00}, {0.00}},
//  {{0.00, 0.25}, {0.00}},
//  {{0.25, 0.25}, {1.00}},
  
//  {{0.50, 0.00}, {0.00}},
//  {{0.00, 0.50}, {0.00}},
//  {{0.50, 0.50}, {1.00}},
  
//  {{0.75, 0.00}, {0.00}},
//  {{0.00, 0.75}, {0.00}},
//  {{0.75, 0.75}, {1.00}},
  
//  {{0.00, 0.00}, {1.00}},
//  {{0.00, 1.00}, {0.00}}, 
//  {{1.00, 0.00}, {0.00}}, 
//  {{1.00, 1.00}, {1.00}}
//};

//float[][][] dataset = {
//  {{0, 0}, {1}},
//  {{0, 1}, {0}}, 
//  {{1, 0}, {1}},
//  {{1, 1}, {1}}
//};

void setup() {
  
  //size(800, 800);
  fullScreen();
  
  mousePos = new PVector();
  //pos = new PVector(Distance*2, height/2);
  pos = new PVector(width/2, height/2);
  nn = new NeuralNetwork(dataset[0][0].length, 1, 20, dataset[0][1].length, false);
  //nn = new NeuralNetwork(true);
  
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
  
  //ellipse(width/2, height/2, 5, 5);
  //ellipse(pos.x, pos.y, 5, 5);
  
  
  if(Running){
    UpdateResult();
    if(mainThread() && !nn.loading){
      println("Done!!!!");
      nn.saveNetwork();
      //nn.saveWeights();
      Running = false;
    }
  }
  if(mouseDown){
    pos.set(prevPos.copy().sub(mousePos.x-mouseX, mousePos.y-mouseY));
  }
  
  //text("test",10, 10);
  push();
  translate(pos.x, pos.y);
  
  float Xoff = (1 + nn.Hiddens.length)*Distance;
  float Yoff = height/2;
  
  
  for(int i=0; i<nn.Neurons.length; i++){
    Neuron n =  nn.Neurons[i];
    
    fill(255);
    ellipse((n.getX() - Xoff)/Xscale, (n.getY() - Yoff)/Yscale, Size/((Xscale+Yscale)/2), Size/((Xscale+Yscale)/2));
    
    for(int j=0; j<n.dendrites.size(); j++){
      Neuron tn = n.dendrites.get(j);
      float weight = n.weights.get(j);
      //fill(weight);
      fill(0);
      line((n.getX()-Xoff)/Xscale, (n.getY()-Yoff)/Yscale, (tn.getX()-Xoff)/Xscale, (tn.getY()-Yoff)/Yscale);
      
      //println();
      
      float scaler = 1.2;
      
      float x = n.getX() - (n.getX() - tn.getX())/scaler;
      float y = n.getY() - (n.getY() - tn.getY())/scaler;
      
      text(weight, (x-Xoff)/Xscale, (y-Yoff)/Yscale);
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
    str = " "+inputstr+" | "  + outputstr +" ";
    
    pop();
      fill(0);
      translate(0, 0);
      //text(str, width-100 - 50 -outputstr.length() -inputstr.length(), 30+i*10);
      text(str, width-100 - 50 -100*(expected.length-1) -2*(inputstr.length()), 30+i*10);
    push();
  }
  pop();
  
  text("Input", width-100- 70 +15, 17);
  text("Ouput", width-100 - 70 +inputstr.length()*8, 17);
  
  
  
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
  if(Xscale+delta > 0 && Yscale+delta > 0){
    if(mouseDown)
      Xscale+=delta;
    else{
      Xscale +=delta;
      Yscale += delta;
    }
    println(Xscale, Yscale);
  }
  
}
