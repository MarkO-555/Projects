boolean changeDebug = true;

public class MainThread extends Thread{
  public void run(){
    started = true;
    
    int i=0;
    
    //error ==0 || (!limit && i>TrainMax)
    while(error > 0.001 || (limit && i<TrainMax)){
      error = 100;
      
      for(int j=0; j<dataset.length; j++){
        for(int v =0; v<result[0].length; v++){
          if(error == 100)
            error=Math.abs(result[j][v] - dataset[j][1][v]);
          else
            error+= Math.abs(result[j][v] - dataset[j][1][v]);
        }
      }
      error /= dataset.length * result[0].length;
    
    
    
      TrainCount = i;
    
      if(Counting)
        CT.run();
  
      nn.train(dataset);
      
      if(debug || i==0 || (i+1==TrainMax && limit))
        RT.run();
      
      i++;
    }
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
    
    println("Pass "+TrainCount);
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
