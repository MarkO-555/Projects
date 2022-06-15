int res = 100;
float xoff = 0;

void setup(){
  size(500, 500);
  //noiseDetail(100);
}

void draw(){
  background(255);
  fill(0);
  for(int i=0; i<width; i++){
    ellipse(i, height*noise((float)(xoff+i)/res), 1, 1);
  }
  xoff+=2;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  res+=10*e;
}
