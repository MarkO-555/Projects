Ray ray;
Particle p;
Console console = new Console();

float sceneW = 400;
int wallCount = 4;
int amt = 5+wallCount;
int range = 46;
PVector[] uiClickable = new PVector[100];
int uiCount = 0;

Boundary[] walls = new Boundary[amt];
float[] scene = new float[range];

void setup() {

  if (range%2 !=0)
    range++;
  size(800, 400);

  if (wallCount == 4) {
    walls[0] = new Boundary(sceneW, 0, sceneW, height, 0);
    walls[1] = new Boundary(0, 0, sceneW, 0, 1);
    walls[2] = new Boundary(0, 0, 0, height, 2);
    walls[3] = new Boundary(0, height, sceneW, height, 3);
  }

  for (int i=wallCount; i<amt; i++) {
    PVector p1 = new PVector(random(sceneW), random(height));
    PVector p2 = new PVector(random(sceneW), random(height));
    walls[i] = new Boundary(p1.x, p1.y, p2.x, p2.y, i);
  }
  for (int i=0; i<console.output.length; i++) {
    console.output[i] = new String();
  }
  p = new Particle();
  p.rot(0);

  console.commandLine = "resume";
}
void draw() {
  background(0);



  for (int i=0; i<amt; i++) {
    walls[i].show();
  }

  float w = sceneW/scene.length;
  push();
  for (int i=0; i<scene.length; i++) {
    float sq = scene[i]*scene[i];
    float wSq = sceneW * sceneW;
    float b = map(sq, 0, wSq, 255, 0);
    float h = map(scene[i], 0, sceneW, height, 0);

    fill(b);
    //rect(i*w + sceneW, 0, w, height);
    noStroke();
    rectMode(CENTER);
    rect(i*w+sceneW+5, height/2, w+1, h);
  }
  pop();

  p.update();
  p.show();
  scene = p.look(walls);

  //ray.setDir(mouseX, mouseY);

  //PVector pt = ray.cast(wall);
  //println(pt);
  //if(pt != null){
  // fill(255);
  // ellipse(pt.x, pt.y, 8, 8);
  //}
  console.show();
}

boolean down = false;
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (down && ((e<0 && range+(2*e) >= 1) || (e>0 && range+(2*e) <= 360))) {
    range+=2*e;
    p.rot(0);
  } else
    p.rot(e/10);
}

void keyPressed() {
  if (key=='~') {
    console.toggle();
  }
  if (!console.open) {
    if (key=='q') {
      range=46;
      p.rot(0);
    }
    if (key=='0') {
      range=2;
      p.rot(0);
    }
  } else {
    if (keyCode == BACKSPACE && console.commandLine.length() > 0)
      console.commandLine = console.commandLine.substring(0, console.commandLine.length()-1);
    else if (keyCode == ENTER)
      console.run(console.commandLine);
    else if (keyCode != BACKSPACE && keyCode != SHIFT && key != '~')
      console.commandLine = console.commandLine+key;
  }
}

//uiClickable[uiCount] = new PVector(50, 10*id);//top left
//uiClickable[uiCount+1] = new PVector(width-100, 10*id+10);//top right

void mousePressed() {
  if (console.open) {
    
  }
  down=true;
}
void mouseReleased() {
  down = false;
}
