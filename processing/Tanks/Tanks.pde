Tank tank;
boolean left, right, up, down;

void setup() {
  size(800, 800);

  left = false;
  right = false;
  up = false;
  down = false;

  tank = new Tank();
}

void draw() {
  background(0);
  
  float it =50;
  
  for(int x=0; x<width; x+=it){
    for(int y=0; y<height; y+=it){
      rect(x, y, it, it);
    } 
  }

  PVector vec = new PVector(0, 0);
  float num = 5;
  if (up)
    vec.set(vec.x, -num);
  if (down)
    vec.set(vec.x, num);
  if (left)
    vec.set(-num, vec.y);
  if (right)
    vec.set(num, vec.y);


  tank.applyForce(vec); 

  tank.update();
}

void keyPressed() {
  if (key=='a')
    left = true;
  if (key=='d')
    right = true;
  if (key=='w')
    up = true;
  if (key=='s')
    down = true;
}

void keyReleased() {
  if (key=='a')
    left = false;
  if (key=='d')
    right = false;
  if (key=='w')
    up = false;
  if (key=='s')
    down = false;
}
