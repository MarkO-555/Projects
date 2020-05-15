Tank tank;
boolean left, right, up, down;

void setup(){
  size(600, 600);
  
  left = false;
  right = false;
  up = false;
  down = false;
  
  tank = new Tank();  
}

void draw(){
  background(0);
  
  PVector vec = new PVector(0, 0);
  
  if(up)
    vec.set(vec.x, -1);
  if(down)
    vec.set(vec.x, 1);
  if(left)
    vec.set(-1, vec.y);
  if(right)
    vec.set(1, vec.y);
  
  
  tank.applyForce(vec); 
  
  tank.update();
}

void keyPressed(){
  if(key=='a')
    left = true;
  if(key=='d')
    right = true;
  if(key=='w')
    up = true;
  if(key=='s')
    down = true;
}

void keyReleased(){
  if(key=='a')
    left = false;
  if(key=='d')
    right = false;
  if(key=='w')
    up = false;
  if(key=='s')
    down = false;
}
