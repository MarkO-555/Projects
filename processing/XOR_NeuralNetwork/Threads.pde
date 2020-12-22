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
    for(int v=0; v<dataset.length; v++){
      result[v] = nn.feedForward(dataset[v][0]);
    }
    println("Pass "+TrainCount+" has started");
    for(int v=0; v<result.length; v++){
      for(int j=0; j<result[v].length; j++){
        println("["+v+"]"+"["+j+"]", result[v][j]);
      }
    }
    println("");
  }
}
