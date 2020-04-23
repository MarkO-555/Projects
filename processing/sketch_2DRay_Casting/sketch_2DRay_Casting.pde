int amt = 5+4;

Boundary[] walls = new Boundary[amt];
Ray ray;
Particle p;

void setup(){
  size(800, 800); 
  noCursor();
  for(int i=0; i<amt-4; i++){
    PVector p1 = new PVector(random(width), random(height));
    PVector p2 = new PVector(random(width), random(height));
    walls[i] = new Boundary(p1.x, p1.y, p2.x, p2.y); 
  }
  
  walls[5] = new Boundary(width, 0, width, height);
  walls[6] = new Boundary(0, 0, width, 0);
  walls[7] = new Boundary(0, 0, 0, height);
  walls[8] = new Boundary(0, height, width, height);
  //wall = new Boundary(300, 100, 180, 300);
  p = new Particle();
}
void draw(){
  background(0);
  for(int i=0; i<amt; i++){
    walls[i].show(); 
  }
  
  p.update();
  p.show();
  p.look(walls);
  
  //ray.setDir(mouseX, mouseY);
  
  //PVector pt = ray.cast(wall);
  //println(pt);
  //if(pt != null){
  // fill(255);
  // ellipse(pt.x, pt.y, 8, 8);
  //}
}
