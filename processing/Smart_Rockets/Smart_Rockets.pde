GA g;

int maxTime = 200;
int Time = 0;

void setup(){
  size(600, 600);
  g = new GA();
}

void draw(){  
  background(0);
  g.run();
  
  println(Time);
  if(Time < maxTime-1){
    Time++;
  }
  else{
    g.breed();
    Time = 0;
  }
}
