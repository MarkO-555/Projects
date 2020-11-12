class GA {
  float bestfitness = -1000;
  Network bestNetwork;
  
  ArrayList<Network> nets = new ArrayList<Network>();
  
  private int InputNodes =28*28;
  private int HiddenXNodes = 2;
  private int HiddenYNodes = InputNodes;
  private int OutputNodes = 10;
  private int weightlen = -1;
  
  private int numbAmt =10;
  private int breedAmt =4000;
  private int c=-1, q=0;
  private int initSize = 100;
  private int maxPopulation = 300;
  
  private Thread preThread = new presentThread(numbAmt, breedAmt);
  
  GA(boolean loading) {
    // 1,237,152 weights
    weightlen = OutputNodes*HiddenYNodes + (HiddenXNodes-1)*HiddenYNodes*HiddenYNodes + HiddenYNodes*InputNodes;
    
    if(!loading){
      //int i=0;
      //while(nets.size() < initSize){
      //  Network net = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, false);
        
      //  for(int j=0; j<100*grade(net); j++){
      //    nets.add(net);
      //  }
      //}
      
      //Thread init  = new initpopulation();
      //init.start();
      while(nets.size()<initSize){
        //println(nets.size(), initSize);
        Network net = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, false);
        
        //float d = millis();
        float val = grade(net);
        //println("GradeTime", millis() - d);
        
        for(int j=1; j<val; j++){
          //println(j, val, initSize, nets.size());
          nets.add(net);
          //println(nets.size());
        }
      }
      //for (int i=0; i<initSize; i++) {
      //  Network net = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, false);
        
      //  for(int j=0; j<grade(net); j++){
      //    nets.add(net);
      //  }
        
      //  //nets.add(new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weights));
        
      ////  netCount++;
      ////  nets[i].feedForward(float(td.getCurrentPixs()));//things!!!
      ////  Thread t = new FeedForwardThread(i);
      ////  t.start();
      //}
      //breed();
    }
    else{
      nets.add(new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, weightlen, loading));
      bestNetwork = nets.get(0);
      //grade(nets.get(0));
      trained = true;
      
      println("100%");
    }
    //println(netCount);
    
    println("initSize hit");
  }
  
  Network breed(){
    Network parent1 = nets.get((int)Math.floor(random(nets.size())));
    Network parent2 = nets.get((int)Math.floor(random(nets.size())));
    
    //println("test");
    
    while(parent1.equals(parent2))
      parent2 = nets.get((int)Math.floor(random(nets.size())));
    
    //println("test");
    float[] w = new float[parent1.weights.length];//set weights
    for(int i=0; i<parent1.weights.length; i++){
      float ran = random(100);
      if(ran >= 50)
        w[i] = parent1.weights[i];
      else if(ran<=1)
        w[i] = random(-1, 1);
      else
        w[i] = parent2.weights[i];
    }
    
    Network child = new Network(InputNodes, HiddenXNodes, HiddenYNodes, OutputNodes, w);
    
    float val = grade(child);
    for(int i=0; i<val; i++)
      nets.add(child);
    //println(parent1.fitness, parent2.fitness, child.fitness);
    
    return child;
  }
   
  float grade(Network net_) { //work on grading meothod
    float avrfit =0;
    for(q=0; q<numbAmt; q++){
      float fit = 0;
      
      if(c>-1)
        preThread.run();
      
      float[] result = net_.feedForward(float(td.getCurrentPixs()));
      float[] errors = new float[net_.Outputs.length];
      float[] expected = td.getCurrentExpected();
      float avrerror = 0;

      for(int i=0; i<result.length; i++){
         errors[i] = Math.abs(expected[i] - result[i]);
         avrerror += errors[i];
      }
      avrerror /= errors.length;
      
      fit = map(avrerror, 0, 1, 2, 1);
      
      fit = (float)Math.pow(5d, (double)fit);


      float smallest = 1000;
      int index = 0;
      for(int i=0; i<errors.length; i++){
        if(errors[i] < smallest){
          smallest = errors[i];
          index = i;
        }
      }
      
      if(index == td.getCurrentnum())
        fit*=2;
      else
        fit-=10;
     
     avrfit += fit;
      //td.nextNum();
      tdT.run();
    }
    
    avrfit /= numbAmt;
    
    net_.fitness = avrfit;
    
    //println(net_.fitness, bestfitness);
    if(net_.fitness > bestfitness && net_.fitness >= 1){
      
      bestNetwork = net_;
      bestfitness = net_.fitness;
      println(bestNetwork.fitness, nets.size());
    }
    

    return net_.fitness;
  }
  
  Thread breeder = new breedThread();
  void update(){
    if(c<=breedAmt && nets.size()>=initSize){
      //println(breed().fitness, nets.size());
      //breed();
      breeder.run();
      //println(c);
      //if(c%20==0)
      //  println(c, nets.size());
      while(nets.size() > maxPopulation)
        nets.remove(0);
        
      c++;
      p=false;
    }
    else if(c>breedAmt || trained == true){
      trained = true;
      //bestNetwork.saveWeights();
    }
  }
  
}
