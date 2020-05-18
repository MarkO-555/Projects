ArrayList<ParticleSystem> particleSystems;
PVector mouse;
PVector pos;
PVector dir; 

void setup(){
  size(600, 600);
  particleSystems = new ArrayList<ParticleSystem>();
  pos = new PVector(width/2, height/2);
}

void draw(){
  background(100);
  
  
  mouse = new PVector(mouseX, mouseY);
  dir = pos.copy().sub(mouse).mult(-1).add(pos);
  
  //line(pos.x, pos.y, dir.x, dir.y);
  
  //println(dir.heading(), "||", atan(dir.y/dir.x));
  //text(dir.heading() + " || " + atan(dir.y/dir.x) +" || " + (dir.heading() == (atan(dir.y/dir.x))) , 50, 50);
  
  //line(width/2, height/2, dir.x, dir.y);
  
  for(int i=0; i<particleSystems.size(); i++){
    ParticleSystem particle = particleSystems.get(i);
    particle.update();
    if(particle.isDead())
      particleSystems.remove(i);
  }
  
  stroke(1);
  fill(255);
  ellipse(pos.x, pos.y, 5, 5);
}

void mousePressed(){
  particleSystems.add(new ParticleSystem(10, pos.copy(), dir.copy(), 45*0.45));
}
