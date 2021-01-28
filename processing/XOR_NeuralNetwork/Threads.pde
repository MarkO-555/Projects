boolean changeDebug = true;

public class MainThread extends Thread{
  public void run(){
    for(int i=0; i<TrainMax; i++){
      TrainCount = i;
    
      if(Counting)
        CT.run();
  
      nn.train(dataset);
      
      if(debug || i==0 || i+1==TrainMax)
        RT.run();
    }
    
    //println("");
    //println("Trained Results");
    //RT.run(); 
  }
}

public class CounterThread extends Thread{
  int lastPresent = -1;
  int currentPresent = 0;
  
  public void run(){
    currentPresent = (int)Math.floor(100*TrainCount/TrainMax);
    if(currentPresent >lastPresent){
       lastPresent = currentPresent;
       println(lastPresent+"%");
    }
  }
}

public class ResultThead extends Thread{
  public void run(){
    if(TrainCount+1 == TrainMax){
      println("");
      println("Trained Results");
    }
    for(int v=0; v<dataset.length; v++){
      if(changeDebug){
        for(int j=0; j<result[v].length; j++){
          lastResult[v][j] = result[v][j]; 
        }
      }
      result[v] = nn.feedForward(dataset[v][0]);
    }
    
    println("Pass "+TrainCount+" has started");
    for(int v=0; v<result.length; v++){
      for(int j=0; j<result[v].length; j++){
        println("["+v+"]"+"["+j+"]", result[v][j]);
      }
    }
    println("");
    
    if(changeDebug && debug && (TrainCount < TrainMax)){
      println("Change of:");
      for(int v=0; v<result.length; v++){
        for(int j=0; j<result[v].length; j++){
          println("["+v+"]"+"["+j+"]", (lastResult[v][j] - result[v][j]));
        }
      }
      println("");
    }
  }  
}
