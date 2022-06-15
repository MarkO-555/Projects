float res = 10;

void setup(){
  size(500, 500);
}

void draw(){
  background(255);
  for(int x=0; x<width; x++){
    for(int y=0; y<height; y++){
      float r = 255*noise((float)x/res, (float)y/res, 0);
      float g = 255*noise((float)x/res, (float)y/res, 1);
      float b = 255*noise((float)x/res, (float)y/res, 2);
      //float n = random(255);
      
      set(x, y, color(r, g, b));
    }
  }
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  res+=e;
}
