class NeuralNetwork {
  private float Weightrange = 5;
  private float BiasValue = 1;

  private Neuron[] Neurons;
  //private double[] axons;

  private int[] Inputs;
  private int[][] Hiddens;
  private int[] Outputs;
  private int[] Bias;
  
  //private int[] Config;

  private double[] weights;
  private int[] weightsmap;
  public boolean loading;

  private double learningrate = 0.0005;
  
  NeuralNetwork(boolean loading){
    
    if(loading){
      int[] conf = loadNetwork();
      buildNetwork(conf[0], conf[1], conf[2], conf[3], loading, 1);
    }
    else
      buildNetwork(dataset[0][0].length, 1, 1, dataset[0][1].length, false, 1);
    
  }
  
  NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading) {
    buildNetwork(Input, HiddenX, HiddenY, Output, loading, 1);
  }
  
  private void buildNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading, int Bias){
    this.Bias = new int[Bias];
    
    int weightCount = 0;
    if (HiddenX>0)
      weightCount = Input*HiddenY + (HiddenX - 1)*HiddenY*HiddenY + HiddenY*Output;
    else if(HiddenX == 0 || HiddenY ==0)
      weightCount = Input *Output;
      
    weightCount+=Bias*(HiddenX*HiddenY+Output);
    
    Input+=Bias;
    HiddenY+=Bias;
    
    Inputs = new int[Input];
    Hiddens = new int[HiddenX][HiddenY];
    Outputs = new int[Output];
    Neurons = new Neuron[Input+HiddenX*HiddenY+Output];
    this.loading = loading;
    //axons = new double[Input+HiddenX*HiddenY+Output];


    weights = new double[weightCount];
    weightsmap = new int[weightCount];

    initWeights(loading);

    int y = 0;
    int Count = 0;
    double it;
    
    for (int i=0; i<Input; i++) {
      Inputs[i] = y;
      Neurons[y] = new Neuron();
      
      it = height/(Input);
      
      Neurons[y].setX(Distance);
      Neurons[y].setY(it*i + it/2);
      
      y++;
    }
    for (int i=0; i<HiddenX; i++) {
      for (int v=0; v<HiddenY; v++) {
        Hiddens[i][v] = y;
        Neurons[y] = new Neuron();
        
        //it = width/HiddenX;
        //Neurons[y].setX(it*(i+1));
        
        it = height/HiddenY;
        
        Neurons[y].setX(i*Distance+2*Distance);
        Neurons[y].setY(it*v + it/2);
        if(v < HiddenY-Bias){
          if (i==0) {
            for (int j=0; j<Input; j++) {
              Neurons[y].addDendrite(Neurons[j], weights[Count]);
              Count++;
            }
          } else{
            for (int j=0; j<HiddenY; j++) {
              Neurons[y].addDendrite(Neurons[Hiddens[i-1][j]], weights[Count]);
              Count++;
            }
            Count -= HiddenY;
          }
        }
        y++;
      }
    }


    for (int i=0; i<Output; i++) {
      Outputs[i] = y;
      Neurons[y] = new Neuron();
      
      it = height/Output;
      
      Neurons[y].setX(Hiddens.length*Distance+2*Distance);
      //Neurons[y].setX(width - (Hiddens.length*Distance+2*Distance));
      Neurons[y].setY(it*i + it/2);
      
      if(HiddenY ==0 || HiddenX ==0){
          for (int j=0; j<Input; j++) {
            Neurons[y].addDendrite(Neurons[j], 0);
            Count++;
          }
      }
      else{
        for (int j=0; j<HiddenY; j++) {
          Neurons[y].addDendrite(Neurons[Hiddens[HiddenX-1][j]], weights[Count]);
          Count++;
        }
      }

      y++;
    } 
  }

  private void initWeights(boolean loading) {
    if (loading)
      weights = loadWeights(weights.length);
    else {
      for (int i=0; i<weights.length; i++) {
        //weights[i] = 1;
        weights[i] = random(-Weightrange, Weightrange);
        if(Hiddens.length == 0){//IO
          weightsmap[i] = 2;
        }
        else{
          //println(this.Inputs.length * (Hiddens[0].length-Bias.length), (Hiddens.length-1)*Hiddens[0].length*(Hiddens[0].length-Bias.length), Hiddens[0].length*Outputs.length, this.Inputs.length * (Hiddens[0].length-Bias.length)+ (Hiddens.length-1)*Hiddens[0].length*(Hiddens[0].length-Bias.length)+ Hiddens[0].length*Outputs.length, weights.length);
          
          
          if (i<=this.Inputs.length * (Hiddens[0].length-Bias.length)-1)//IH
            weightsmap[i] = 0;
          else if (i<=this.Inputs.length * (Hiddens[0].length-Bias.length) + (Hiddens.length-1)*Hiddens[0].length*(Hiddens[0].length-Bias.length)-1) {//HH
            weightsmap[i] = 1;
          } else if (i<=this.Inputs.length * (Hiddens[0].length-Bias.length) + (Hiddens.length-1)*Hiddens[0].length*(Hiddens[0].length-Bias.length) + Hiddens[0].length*Outputs.length-1)//HO
            weightsmap[i] = 2;
            
        }
        //println(i, weightsmap[i]);
      }
    }
  }

  public double[] feedForward(double[] Inputs) {
    int len = Inputs.length;
    
    //println(Neurons.length);
    
    if (len != Inputs.length) {
      println("The inputs length is not expected value");
    }
    
    //println("inputs",Inputs.length);
    
    for(int i=0; i<Inputs.length; i++){
      Neurons[i].axonValue = Inputs[i]; 
    }
    
    for(int i=0; i<Bias.length; i++){
      Neurons[i+Inputs.length].axonValue = BiasValue; 
    }
    
    for(int i=0; i<Hiddens.length; i++){
      for(int j=0; j<Hiddens[i].length; j++){
        Neuron n = Neurons[Hiddens[i][j]];
        if(i==0){//Input Hidden
          for(int v=0; v<Inputs.length; v++){
            n.setDendrite(v, Neurons[v]);
          }
        }
        else{//Hidden Hidden
          for(int v=0; v<Hiddens[0].length; v++){
            n.setDendrite(v, Neurons[Hiddens[i-1][v]]); 
          }
        }
        n.process();
      }
    }
    
    for(int i=0; i<Outputs.length; i++){
      Neuron n =Neurons[Outputs[i]];
      if(Hiddens.length==0){
          for(int v=0; v<Inputs.length; v++){
            n.setDendrite(v, Neurons[v]);
          }
      }
      else{
        for(int v=0; v<Hiddens[0].length; v++){
           n.setDendrite(v, Neurons[Hiddens[Hiddens.length-1][v]]);
        }
      }
      n.process();
    }

    len = this.Outputs.length;
    double[] Outputs = new double[len];

    for (int i=0; i<len; i++)
      Outputs[i] = Neurons[this.Outputs[i]].axonValue;
    
    return Outputs;
  }
  
  public double[][] feedForward(double[][][] dataset){
    double[][] out = new double[dataset.length][dataset[0][1].length];
    for (int i=0; i<dataset.length; i++) {
      out[i] = feedForward(dataset[i][0]);
      if(out[i] == null)
        out[i] = lastResult[i];
    }
    
    return out;
  }

  public void train(double[] inputs, double[] expected) {
    int len = expected.length;
    double[] result = feedForward(inputs);
    
    
    if(result == null)
      return;
    
    //while(result==null)
    //  result = feedForward(inputs);
      
    double[] OutputErrors = new double[len];
    double[][] hiddenErrors;// = new double[Hiddens.length][Hiddens[0].length];
    double[][] hiddens;// = new double[Hiddens.length][Hiddens[0].length];

    if(Hiddens.length == 0){
      hiddenErrors = new double[0][0];
      hiddens = new double[0][0];
    }
    else{
      hiddenErrors = new double[Hiddens.length][Hiddens[0].length];
      hiddens = new double[Hiddens.length][Hiddens[0].length];
    }

    for (int i=0; i<result.length; i++) {
      OutputErrors[i] = expected[i] - result[i];
      Neurons[Outputs[i]].addError(OutputErrors[i]);
      Neurons[Outputs[i]].processErrors();
    }
    
    for (int x=0; x<Hiddens.length; x++) {
      for (int y=0; y<Hiddens[x].length; y++) {
        hiddens[x][y] = Neurons[Hiddens[x][y]].axonValue;
      }
    }

    for (int x=Hiddens.length-1; x>=0; x--) {
      for (int y=0; y<Hiddens[x].length; y++) {
        if (x==Hiddens.length-1) {//Hidden Outputs
          for (int i=0; i<Outputs.length; i++) {
            Neuron output = Neurons[Outputs[i]];
            Neurons[Hiddens[x][y]].addError(OutputErrors[i] * output.getWeight(y));//error * weight
          }
        }
        else {//Hidden Hidden
          for (int i=0; i<Hiddens[x].length-Bias.length; i++) {
            Neuron hidden = Neurons[Hiddens[x+1][i]];
            Neurons[Hiddens[x][y]].addError(hidden.getError() * hidden.getWeight(y));
            //Neurons[Hiddens[x][y]].addError(1);
          }
          for(int i=Hiddens[x].length-Bias.length; i<Hiddens[x].length; i++){
            Neuron hidden = Neurons[Hiddens[x+1][i]];
            Neurons[Hiddens[x][y]].addError(hidden.getError());
          }
        }
        Neurons[Hiddens[x][y]].processErrors();
        hiddenErrors[x][y] = Neurons[Hiddens[x][y]].getError();
      }
    }
    len = weights.length;
    
    for (int i=0; i<len; i++) {
      double nonproc = 0;
      double error = 0;
      
      //println(i, weightsmap[i]);
      
      //println(weights[i], weightsmap[i]);
      
      //println(weightsmap[i]);
      
      if (weightsmap[i] == 0) {//Connected Hiddens, Inputs
        
        //println(i, i%this.Inputs.length);
        //error = 1;

        error = Neurons[Hiddens[0][i/this.Inputs.length]].getError();
        if(i%this.Inputs.length >= inputs.length)
          nonproc = Bias[i%this.Inputs.length-inputs.length];
        else
          nonproc = inputs[i%this.Inputs.length];
      }
      else {
        //nonproc = nonproc *(1-nonproc);
        nonproc = dSigmoid(nonproc);
      }
      
      if (weightsmap[i] == 1) {//Connected Hiddens, Hiddens
        //int index = i - inputs.length*(hiddens[0].length-Bias.length);//index in current hidden hidden weights
        int index =0;
        
        index = i - (this.Inputs.length*(hiddens[0].length-Bias.length));
        

        //int x = index / (int)Math.pow(hiddens[0].length, 2);//BUG!!!
        int x = index/(hiddens[0].length*(hiddens[0].length-Bias.length));
        int y = index/(hiddens[0].length);
        
        if(x>0)
          y-=2*(x);
        
        
        println(i, index, x, y);
        
        //println(i, index, x+1, index%hiddens[0].length);
        
        nonproc = hiddens[x][index%hiddens[0].length];
        error = Neurons[Hiddens[x+1][y]].getError();
        //error = 1;
      }
      else if (weightsmap[i] == 2) {//Connected to Outputs, Hiddens
        int index =0;
        
        if(hiddens.length ==0){//input to output
          
          
          error = Neurons[Outputs[i/this.Inputs.length]].getError();
          nonproc = Neurons[Inputs[i%Outputs.length]].axonValue;
          //nonproc = 1;
          
          //error =1;
        }
        else{//hidden, output
          //index = i - inputs.length*hiddens[0].length - hiddens[0].length * hiddens[0].length*(hiddens.length-1);
          index = i - this.Inputs.length*(hiddens[0].length-Bias.length) - hiddens[0].length * (hiddens[0].length-Bias.length)*(hiddens.length-1);
          //println(i, index, index/Hiddens[0].length);
          //println(index, hiddens[0].length, index%hiddens[0].length);
          //println(i);
          
          error = Neurons[Outputs[index/Hiddens[0].length]].getError();//BUG!!!!
          nonproc = hiddens[hiddens.length-1][index%Outputs.length];
          
        }
      }      
      
      
      //println(i);
      
      //println(learningrate, error, nonproc);
      weights[i] += learningrate * error * nonproc;
    }

    updateWeights();
  }

  void train(double[][][] dataset) {
    for (int i=0; i<dataset.length; i++) {
      train(dataset[i][0], dataset[i][1]);
    }
  }

  private void updateWeights() {
    ArrayList<Double> ls = new ArrayList();  

    //println(weights);
    
    int Count = 0;
    for (int i=0; i<Neurons.length; i++) {
      ArrayList<Double> nW = new ArrayList<Double>(); 
      Neuron n = Neurons[i];

      for (int v=0; v<n.weights.size(); v++) {
        ls.add(weights[Count]);
        nW.add(weights[Count]);
        Count++;
      }
      n.setWeights(nW);
    }
  }
  
  private void saveNetwork(){
    PrintWriter NetworkLog;
    
    NetworkLog = createWriter("Network.txt");
    
    NetworkLog.println(Inputs.length);
    if(Hiddens.length != 0){
      NetworkLog.println(Hiddens.length);
      NetworkLog.println(Hiddens[0].length);
    }
    else{
       NetworkLog.println(0);
       NetworkLog.println(0);
    }
    NetworkLog.println(Outputs.length);
    
    NetworkLog.flush();

    println("saved Network");
    saveWeights();
  }
  
  private void saveWeights() {
    PrintWriter weightLog;

    weightLog = createWriter("Weights.txt");

    for (int i=0; i<weights.length; i++) {
      weightLog.println(weights[i]);
    }
    weightLog.flush();

    println("saved Weights");
  }
  
  private int[] loadNetwork(){
    BufferedReader NetworkLog = createReader("Network.txt");

    //double[] weights_ = new double[weightCount];
    int[] out = new int[4];
    
    String line = null;
    int i=0;

    try {
      while ((line = NetworkLog.readLine()) != null) {
        out[i] = int(line);
        i++;
      }
      NetworkLog.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    return out;
  }

  private double[] loadWeights(int weightCount) {
    BufferedReader weightsLog = createReader("Weights.txt");

    double[] weights_ = new double[weightCount];
    String line = null;
    int i=0;

    try {
      while ((line = weightsLog.readLine()) != null) {
        weights_[i] = float(line);
        i++;
      }
      weightsLog.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    return weights_;
  }
}
