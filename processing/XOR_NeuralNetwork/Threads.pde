boolean changeDebug = true;

//public class MainThread extends Thread {
//  public void run() {
//    //UpdateResult();
//    int i=0;
    
//    while (true || (error > 0.001) || (limit && i<TrainMax)) {
//      error = 100;
      
//      for (int j=0; j<dataset.length; j++) {
//        for (int v =0; v<resulted[0].length; v++) {
//          if (error == 100)
//            error=Math.abs(resulted[j][v] - dataset[j][1][v]);
//          else
//            error+= Math.abs(resulted[j][v] - dataset[j][1][v]);
//        }
//      }
      
//      error /= dataset.length * resulted[0].length;

//      TrainCount = i;

//      if (Counting)
//        CT.run();

//      nn.train(dataset);
//      i++;
//    }
//  }
//}

//public class CounterThread extends Thread {
//  int lastPresent = -1;
//  int currentPresent = 0;

//  public void run() {
//    currentPresent = (int)Math.floor(100*TrainCount/TrainMax);
//    if (currentPresent >lastPresent) {
//      lastPresent = currentPresent;
//      println(lastPresent+"%");
//    }
//  }
//}

public boolean mainThread() {
  int i=0;
  if((error >= thresh) || (limit && i<TrainMax)){
  //while (true || (error > 0.001) || (limit && i<TrainMax)) {
    error = 100;
    
    for (int j=0; j<dataset.length; j++) {
      for (int v =0; v<resulted[0].length; v++) {
        if (error == 100)
          error=Math.abs(resulted[j][v] - dataset[j][1][v]);
        else
          error+= Math.abs(resulted[j][v] - dataset[j][1][v]);
      }
    }
    
    error /= dataset.length * resulted[0].length;

    TrainCount = i;

    //if (Counting)
    //  CT.run();
    if(!nn.loading)
      nn.train(dataset);
    i++;
  }
  else
    return true;
  return false;
  
  //return !((error > 0.001) || (limit && i<TrainMax));
}


void UpdateResult(){
   if (TrainCount+1 == TrainMax && debug) {
    println("");
    println("Trained Results");
  }
  for (int v=0; v<dataset.length; v++) {
    if (changeDebug) {
      for (int j=0; j<resulted[v].length; j++) {
        lastResult[v][j] = resulted[v][j];
      }
    }
    resulted[v] = nn.feedForward(dataset[v][0]);
    
    
    if(resulted[v] == null)
      resulted = lastResult;
  }
  
  //if(lastResult == null)
  //  lastResult = resulted;
      
  if (debug) {
    println("Pass "+TrainCount);
    for (int v=0; v<resulted.length; v++) {
      for (int j=0; j<resulted[v].length; j++) {
        println("["+v+"]"+"["+j+"]", resulted[v][j]);
      }
    }
    println("");
  
    if (changeDebug && (TrainCount < TrainMax)) {
      println("Change of:");
      for (int v=0; v<resulted.length; v++) {
        for (int j=0; j<resulted[v].length; j++) {
          println("["+v+"]"+"["+j+"]", (lastResult[v][j] - resulted[v][j]));
        }
      }
      println("");
    }
  } 
}
