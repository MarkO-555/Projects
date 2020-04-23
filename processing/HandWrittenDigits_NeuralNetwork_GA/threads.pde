class GeneticThread extends Thread{
  public void run(){
    ga = new GA(false);
  }
}

class initpopulation extends Thread{
  public initpopulation(){
    
  }
  
  public void run(){
    for (int i=0; i<ga.initSize; i++) {
      Network net = new Network(ga.InputNodes, ga.HiddenXNodes, ga.HiddenYNodes, ga.OutputNodes, ga.weightlen, false);
            
      for(int j=0; j<ga.grade(net); j++){
        ga.nets.add(net);
      }
    }
  }
}

class trainingThread extends Thread{
  public trainingThread(){
    td = new trainingData();
  }
  
  public void run(){
    td.nextNum();
    td.display();
    //for(int i=0; i<28; i++){
    //  for(int j=0; j<28; j++){
    //    fill(td.getCurrentPixs()[i*28 +j]); //the first 16 bits are meta data
    //    rect(cellSize*j, cellSize*i, cellSize, cellSize);
    //  }
    //}
    
    //fill(255, 0, 0);
    //text(int(td.labelSet[td.current +8]), 30, 30); //the first 8 bits are meta data
  }
}

public class breedThread extends Thread{
  public void run(){
    ga.breed();
  }
}

public class presentThread extends Thread{
  private String present = "";
  private String prev = "";
  private int numbAmt;
  private int breedAmt;
  private int q=0, c=0;
  
  
  public presentThread(int numbAmt, int breedAmt){
    this.numbAmt = numbAmt;
    this.breedAmt = breedAmt;
  }
  public void run(){
    if(q==numbAmt){
      q=0;
      c++;
    }
    if(c<=breedAmt){
      present = 100*(c*(numbAmt-1)+q)/(numbAmt*breedAmt)+"%";
      if(!prev.equals(present))
        println(present);
      prev = present;
    }
    //println("test",100*(c*(numbAmt-1)+q)/(numbAmt*breedAmt));
    
    q++;
  }
}

//class FeedForwardThread extends Thread{
//  int index;
//  float[] Result;
//  public FeedForwardThread(Network net, Neuron[] inputs_){
    
//    Result = new float[net.Outputs.length];
//    if(net.Inputs.length != net.Inputs.length){
//      println("inputs must have the same length");
//    }
    
//    for(int i=0; i<net.Inputs.length; i++){
//      net.Inputs[i].axonValue = net.Inputs[i].axonValue;
//    }
//    for(int i=0; i<net.HiddenXNodes; i++){
//      for(int j=0; j<net.HiddenYNodes; j++){
//        net.Hiddens[i][j].process();
//      } 
//    }
//    for(int i=0; i<net.Outputs.length; i++){
//      net.Outputs[i].process(); 
//    }
//    for(int i=0; i<Result.length; i++){
//      Result[i] = net.Outputs[i].axonValue;
//    }
    
//    //return Result;
//  }
  
//  public void run(){
//    if(ga != null){
//      ga.nets.get(index).feedForward(float(td.getCurrentPixs()));
//      ga.grade(ga.nets.get(index));
//    }
//  }
//}}
