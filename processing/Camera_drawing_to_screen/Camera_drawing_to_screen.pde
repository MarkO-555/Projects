import processing.video.*;

Capture cam;

void setup() {
  size(1280, 480);
  
  cam = new Capture(this, Capture.list()[1]);
  cam.start();
}

void draw() {
  if (cam.available()) {
    cam.read();
  }
  //image(cam, 0, 0);
  
  
  for(int x=cam.width-1; x>0; x--){
    for(int y=cam.height-1; y>0; y--){
      int index = (y)*cam.width+(cam.width-x);
      
      int blaw = cam.pixels[index];
      set(x,y,blaw);
    } 
  }
  
  
  for(int x=0; x<cam.width; x++){
    for(int y=0; y<cam.height; y++){
      int index = y*cam.width+x;
      
      int blaw = cam.pixels[index];
      set(x+width/2,y,blaw);
    } 
  }
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}
