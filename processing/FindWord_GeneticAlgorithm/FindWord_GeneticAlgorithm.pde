String expected = "tim helland";
//String expected = "abcdefghijklmnopqrstuvwxyz";
//ArrayList<String> population = new ArrayList<String>();
ArrayList<String> matingPool = new ArrayList<String>();
float bestScore =0;
String bestString = "";


int count = 500;
void setup(){
  //size(600, 500);
  
  while(matingPool.size() < count)
    makeGuess();
    
  //println("end");
   
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
