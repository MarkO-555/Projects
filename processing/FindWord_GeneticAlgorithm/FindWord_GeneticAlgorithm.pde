String expected = "cool name dude";
//String expected = "abcdefghijklmnopqrstuvwxyz";
//ArrayList<String> population = new ArrayList<String>();
ArrayList<String> matingPool = new ArrayList<String>();
float bestScore =0;
String bestString = "";


int count = 1000;
void setup(){
  //size(600, 500);
  println("Generating inital population");
  println("____________________________");
  
  Thread pre = new preThread();
  pre.start();
  
  //int pre=-1;
  while(matingPool.size() < count){
    //if(pre < (100*matingPool.size()/count)){
    //  pre = 100*matingPool.size()/count;
    //  println(pre+"%");
    //}
    makeGuess();
  }
    
  println("end");
  println("");
   
}

void draw(){
  if(bestScore != (expected.length()))
    breed();
  else{
    println("found string ", "\""+bestString+"\"");
    noLoop();
  }
    
  while(matingPool.size() >2*count)
    matingPool.remove(0);
}

class preThread extends Thread{
  int pre=-1;
  void run(){
    while(pre<100){
      for(int i=0; i<2; i++){
        if(i==0){
          int num = 100*matingPool.size()/count;
          if(pre < num){
            println(pre+"%");
            pre = num;
          }
        }
      }
    }
  }
}

float grade(String current){
  //population.add(current);
  float score =0;
  //println(current,bestString, matingPool.size());
  for(int j=1; j<current.length()+1; j++){
    if(current.substring(j-1,j).equals(expected.substring(j-1, j)))
      score++; 
    else{
      score-=0.5;
      //score/=10;
    }
  }
  for(int j=0; j<score; j++)
    matingPool.add(current);
  if(score > bestScore){
    bestString = current;
    bestScore = score;
    
    println(score, current);
  }
  
  for(int i=0; i<score; i++){
    matingPool.add(current);
  }
  
  return score;
}

void breed(){
  String[] parents = {matingPool.get((int)Math.floor(random(matingPool.size()))), matingPool.get((int)Math.floor(random(matingPool.size())))};
  int count=0;
  
  while(parents[0].equals(parents[1])){
    parents[1] = matingPool.get((int)Math.floor(random(matingPool.size())));
    if(count==1000){
      println("loop in breed overrun to "+count);
      break;
    }
    count++;
  }
  
  String result = "";
  for(int i=1; i<parents[0].length()+1; i++){
    if(random(1)>0.01)
      result += parents[(int)random(2)].substring(i-1, i);
    else{
      result += randomCharacter();
    }
  }
  
  grade(result);
}

void makeGuess(){
  String guess = new String();
  for(int i=0; i<expected.length(); i++){
    guess+=randomCharacter();
  }
  
  grade(guess);
}

String randomCharacter(){
    int ran =floor(random(97, 124));
    String c = "";
    if(ran==123)
      c += " ";
    else
      c += char(byte(ran));
      
  return c;
}
