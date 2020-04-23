class Asteroid{
  PVector pos = new PVector(0, 0);
  PVector vel = PVector.random2D().setMag(random(2));
  float r = random(50,100);
  boolean hit = false;
  
  Asteroid(PVector pos_){
     pos = pos_;
  }
  
  void update(){
    if(!hit)
      pos.add(vel);
  }
  
  void edges(){
   if(pos.x < -r){
     pos.x = width+r;
     pos.y = map(pos.y, -r, height+r, height+r, -r);
   }
   else if(pos.x > width+r){
     pos.x  = -r;
     pos.y = map(pos.y, -r, height+r, height+r, -r);
   }
   else if(pos.y < -r){
     pos.x = map(pos.x, -r, width+r, width+r, -r);
     pos.y  = height+r;
   }
   else if(pos.y > height+r){
     pos.x = map(pos.x, -r, width+r, width+r, -r);
     pos.y  = -r;
     
   }
  }
  
  void show(){
    if(!hit)
      ellipse(pos.x, pos.y, r, r); 
  }
}


void Asteroid_Push(Asteroid a) {
  Asteroid[] temp = asteroids;
  asteroids = new Asteroid[asteroids.length+1];

  for (int i=0; i<temp.length; i++) {
    asteroids[i] = temp[i];
  }
  asteroids[asteroids.length-1] = a;
}

void Asteroid_Slice(int index) {
  Asteroid[] temp = asteroids;
  asteroids = new Asteroid[asteroids.length-1];
  println(asteroids.length, temp.length);
  int v=0;
  for (int i=0; i<temp.length; i++) {
    if(i==index)
      i++;
    asteroids[v] = temp[i];
    v++;
  }
}
