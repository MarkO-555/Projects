NeuralNetwork nn;
//CounterThread CT;
//MainThread MT;

float Size = 25;
float Distance = 100;

int TrainCount = 0;
int TrainMax = 100;

double[][] resulted;
double[][] lastResult;
double error = 100;//stand in (temp, needs to be high number!!!)
double scale = 1;

float Xscale =1;
float Yscale =1;

double thresh = 0.01;

boolean debug = false;
boolean Counting = false;
boolean limit = false;
boolean Running = true;

PVector mousePos;
PVector pos;
PVector prevPos;
boolean mouseDown = false;

int inputlen = 0;
int outputlen = 0;
int errorlen = 0;

double[][][] dataset = {
  
  //{{0.25, 0.00}, {0.90}},
  //{{0.00, 0.25}, {1.00}},
  //{{0.25, 0.25}, {0.00}},
  
  //{{0.50, 0.00}, {0.50}},
  //{{0.00, 0.50}, {0.10}},
  //{{0.50, 0.50}, {0.70}},
  
  //{{0.00, 0.00}, {1.00}},
  //{{0.75, 0.00}, {0.05}},
  //{{0.00, 0.75}, {0.50}},
  //{{0.75, 0.75}, {0.00}},
  
  //{{0, 0}, {1}},
  //{{0, 1}, {0}}, 
  //{{1, 0}, {0}}, 
  //{{1, 1}, {1}}
  
  {{0},{0}},
  {{1},{1}}
};

//double[][][] dataset = {
  
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

//double[][][] dataset = {
//  {{0, 0}, {1}},
//  {{0, 1}, {0}}, 
//  {{1, 0}, {1}},
//  {{1, 1}, {1}}
//};

void setup() {
  
  //println("val:", (long)4.5); 
  
  size(800, 800);
  //fullScreen();
  
  mousePos = new PVector();
  //pos = new PVector(Distance*2, height/2);
  pos = new PVector(width/2, height/2);
  nn = new NeuralNetwork(dataset[0][0].length, 1, 2, dataset[0][1].length, false);
  //nn = new NeuralNetwork(true);
  
  //if(Counting)
  //  CT = new CounterThread();
  //MT = new MainThread();

  resulted = new double[dataset.length][dataset[0][1].length];
  lastResult = new double[dataset.length][dataset[0][1].length];
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
  
  double Xoff = (1 + nn.Hiddens.length)*Distance;
  double Yoff = height/2;
  
  
  for(int i=0; i<nn.Neurons.length; i++){
    Neuron n =  nn.Neurons[i];
    
    fill(255);
    ellipse((float)(n.getX() - Xoff)/Xscale, (float)(n.getY() - Yoff)/Yscale, Size/((Xscale+Yscale)/2), Size/((Xscale+Yscale)/2));
    
    for(int j=0; j<n.dendrites.size(); j++){
      Neuron tn = n.dendrites.get(j);
      double weight = n.weights.get(j);
      //fill(weight);
      fill(0);
      line((float)(n.getX()-Xoff)/Xscale, (float)(n.getY()-Yoff)/Yscale, (float)(tn.getX()-Xoff)/Xscale, (float)(tn.getY()-Yoff)/Yscale);
      
      //println();
      
      double scaler = 1.2;
      
      double x = n.getX() - (n.getX() - tn.getX())/scaler;
      double y = n.getY() - (n.getY() - tn.getY())/scaler;
      
      text((float)weight, (float)(x-Xoff)/Xscale, (float)(y-Yoff)/Yscale);
    }
  }
  
  String str = "";
  
  String inputstr = "";
  String outputstr = "";
  String errorstr = "";
  
  
  
  for(int i=0; i<dataset.length; i++){
    errorstr = "";
    outputstr = "";
    //inputstr = "";
    
    double[] inputs = dataset[i][0];
    double[] expected = dataset[i][1];
    for(int v=0; v<inputs.length; v++){
      inputstr = "";
      
      for(int k = 0; k<dataset[i][0].length; k++){
        if(inputstr != "")
          inputstr += ", ";
        int len = (dataset[i][0][k]+"").length();
        inputstr += dataset[i][0][k];
        
        if(inputlen<len)
          inputlen = len;
        while(inputlen > len){
          inputstr+="0";
          len+=1;
        }
      }
    }
    
    //for(int v=0; v<expected.length; v++){
    //  if(expectedstr != "")
    //    expectedstr += ", ";
    //  expectedstr += expected[v];
    //}
    //println(expectedstr);
    
      for(int v=0; v<resulted[i].length; v++){
        if(outputstr != "")
          outputstr += ", ";
        
        outputstr += resulted[i][0];
        String tempoutputstr = resulted[i][0]+"";
        
        int Olen = tempoutputstr.length();
        if(outputlen < Olen)
          outputlen = Olen;
        while(outputlen > Olen){
          outputstr+="0";
          Olen+=1;
        }
        
      }
    
    str = " "+inputstr+" | "  + outputstr +" ";
    
    pop();
      fill(0);
      translate(0, 0);
      //text(str, width-100 - 50 -2*(expected.length) -2*(inputstr.length()), 30+i*10);
      text(str, width -5 * (str.length()+4), 30+i*10);
    push();
  }
  pop();
  
  text("Input",  width -5 * (str.length()+2.5), 17);
  text("Ouput(s)",  width -5 * (str.length() - inputlen*dataset[0][0].length - (dataset[0][1].length-1)*(outputlen)), 17);
  
  String errorString = error+"";
  int Elen = errorString.length();
  if(errorlen<Elen)
    errorlen = Elen;
  while(errorlen>Elen){
    errorString+="0"; 
    Elen+=1;
  }
  
  text("Average Error", width-(6*errorlen) ,30 + dataset[0][1].length*10 + 100);
  text(errorString    , width-(6*errorlen) ,30 + dataset[0][1].length*10 + 112.5);
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
  double delta = (double)event.getCount()/10;
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
