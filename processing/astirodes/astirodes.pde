Ship ship;

Asteroid[] asteroids = new Asteroid[0];
bullet[] b = new bullet[0];



boolean down = false;
boolean forward = false;

float turn;
float propel;

void setup() {
  size(600, 400);
  ship = new Ship();
  for(int i=0; i<random(5, 20); i++){
    Asteroid_Push(new Asteroid(new PVector(random(width), random(height))));
  }
}

void draw() {
  background(0);
  ship.edges();
  
  for(int i=0; i<asteroids.length; i++){
     asteroids[i].show();
     asteroids[i].update();
     asteroids[i].edges();
  }
  
  if(forward)
    ship.propel(0.5);
  
  for(int i=0; i<b.length; i++){
    b[i].show();
    b[i].update();
    if(b[i].checkHit())
      bullet_Slice(i);
  }
  if (down) {
    if(key == 'a'){
      ship.turn(-0.1); 
    }
    if(key == 'd'){
      ship.turn(+0.1); 
    }
  }

  ship.show();
  ship.update();
}



void mousePressed(){
  forward = true;
}

void mouseReleased(){
  forward = false;
}

void keyPressed() {
  if(!down){
    if(key == 'e'){
      bullet_Push(new bullet(ship.pos.copy(), ship.vel.copy()));
    } 
  }
  down = true;
}
void keyReleased() {
  down = false;
}
