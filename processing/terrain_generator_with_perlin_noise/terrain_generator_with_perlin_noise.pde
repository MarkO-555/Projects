int cols, rows;
int scl = 20;
int w, h;
float[][] terrain;

float flying;

float deltaFlying;
float deltaXoff;
float deltaYoff;

void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);
  noCursor();
  w=2400;
  h=1800;
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  
  flying =0;
  deltaXoff = 0.1;
  deltaYoff = 0.1;
  deltaFlying = 0.05;
}

void draw() {
  
  float yoff =flying;
  
  for (int y=0; y<rows; y++) {
    float xoff =0;
    for (int x=0; x<cols; x++) {
      //terrain[x][y] = map(y, 0, rows/4, -10, 10);
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -50, 50);
      xoff+=deltaXoff;
    }
    yoff+=deltaYoff;
  }
  
  background(0);
  stroke(255);
  noFill();

  translate(width/2, height/2);
  rotateX(PI/3);

  translate(-w/2, -h/2);

  for (int y=0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y] );
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);

      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  flying -= deltaFlying;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(key=='f')
    deltaFlying += e/500;
  if(key=='x')
    deltaXoff +=e/200;
  if(key=='y')  
    deltaYoff +=e/200;
}
void keyPressed(){
  if(key=='q')
    setup();
}
