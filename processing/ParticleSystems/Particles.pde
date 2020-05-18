class ParticleSystem{
  PVector pos;
  ArrayList<Particle> particles;
  
  ParticleSystem(int num, PVector pos, PVector direction, float angle){
    particles = new ArrayList<Particle>();
    this.pos = pos;
    
    //cos
    
    PVector vec = direction.sub(pos);
    
    for(int i=0; i<num; i++){
      //float ranAngle = random(-angle/2, angle/2);
      
      //float x = 1;
      //float y = 1;
      
      //newVec.x += x;
      //newVec.y += y;
      
      particles.add(new Particle(pos.copy(), vec));
    }
  }
  
  void update(){
    for(int i=0; i<particles.size(); i++)
      particles.get(i).update();
    return;
  }
  
  void applyForce(PVector vec){
    for(int i=0; i<particles.size(); i++)
      particles.get(i).applyForce(vec);
    return;
  }
  
  void chanceRadius(float radius){
    for(int i=0; i<particles.size(); i++)
      particles.get(i).r = radius;
    return;
  }
  
  boolean isDead(){
    for(int i=0; i<particles.size(); i++){
      if(particles.get(i).isDead())
        return true;
    }
    return false;
  }
}

class Particle{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float lifeSpan = 200;
  float it = 2.5;
  float r = 4;
  
  Particle(PVector pos, PVector vel){
    this.pos = pos;
    this.vel = new PVector(random(-5, 5), random(-5, 5));
    //this.vel = vel;
    this.acc = new PVector(0, 0);
    
    acc = new PVector(0, 0);
  }
  
  void update(){
    vel.add(acc);
    pos.add(vel);
    acc.set(0, 0);
    lifeSpan -= it;
    
    vel.mult(0.9);
    
    Draw();
    return;
  }
  
  void Draw(){
    noStroke();
    fill(0, lifeSpan);//color
    ellipse(pos.x, pos.y, 4, 4); 
    return;
  }
  
  void applyForce(PVector vec){
    acc.add(vec); 
    return;
  }
  
  boolean isDead(){
     return (lifeSpan <= 0);
  }
}
