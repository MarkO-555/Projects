ParticleSystem p;
PVector orgin = new PVector(width/2, height/2);

void setup(){
  size(600, 600);
  
  p = new ParticleSystem(100, orgin);
}

void draw(){
  background(0);
  //PVector mouse = new PVector(mouseX, mouseY);
  
  p.update();
  p.addParticle();
  //p.applyForce(orgin.copy().sub(mouse).setMag(5));
}

class Particle{
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float lifeSpan = -1;
  float iterator = 2.5;
  
  Particle(PVector pos, float lifeSpan){
    this.pos = pos.copy();
    this.lifeSpan = lifeSpan;
  }
  
  void update(){
    lifeSpan -= iterator;
    pos.add(vel);
    vel.add(acc);
    
    acc.set(0, 0);
    
    Draw();
  }
  
  void applyForce(PVector vec){
   acc.add(vec);  
  }
  
  void Draw(){
    noStroke();
    fill(255, lifeSpan);
    ellipse(pos.x, pos.y, 1, 1); 
  }
  
  boolean isDead(){
    if(lifeSpan <= 0)
      return true;
    return false;
  }
}

class ParticleSystem{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector orgin = new PVector(0, 0);
  int num;
  PImage img;
  
  ParticleSystem(int num, PVector orgin){
    this.num = num;
    this.orgin = orgin;
    
    for(int i=0; i<num; i++)
      particles.add(new Particle(orgin, 100));
  }
  
  void update(){
    for(int i=0; i<particles.size(); i++){
      Particle particle = particles.get(i);
      if(particle.isDead())
        particles.remove(i);
      particle.update();
    }
  }
  
  void applyForce(PVector vec){
    for(int i=0; i<particles.size(); i++){
      particles.get(i).applyForce(vec);
    }
  }
  
  void addParticle(){
    particles.add(new Particle(orgin, 100));
  }
}
