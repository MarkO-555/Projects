float[] numbs;
float temp;
boolean sorted = false;
void setup(){
  size(600, 500);
  numbs = new float[width];
  for(int i=0; i<numbs.length; i++){
    numbs[i] = random(height); 
  }
}

void draw(){
  background(0);
  for(int i=0; i<numbs.length-1; i++){
    stroke(255);
    line(i, height, i, height-numbs[i]);
    if(!sorted && i>1){
      if(numbs[i-1] > numbs[i]){
        temp = numbs[i-1];
        numbs[i-1] = numbs[i];
        numbs[i] = temp;
      }
    }
  }

}
