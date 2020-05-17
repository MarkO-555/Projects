ArrayList<Tank> tanks;
ArrayList<bullet> bullets;
ArrayList<ParticleSystem> particlesystem;
boolean visual = false;

float it =80; // 20px X 20px

void setup() {
  size(800, 800);
  tanks = new ArrayList<Tank>();
  bullets = new ArrayList<bullet>();
  particlesystem = new ArrayList<ParticleSystem>();

  tanks.add(new Tank(true, 0, 1, 0));
  tanks.add(new Tank(false, random(1), random(1), random(1)));
}

void draw() {
  background(0);
  //background(150);
  if(visual){
    for(int x=0; x<width; x+=it){
      for(int y=0; y<height; y+=it){
        fill(255);
        strokeWeight(1);
        stroke(0);
        rect(x, y, it, it);
      } 
    }
  }
  
  for(int i=0; i<particlesystem.size(); i++){
    ParticleSystem system = particlesystem.get(i);
    system.run();
    if(system.isDead())
      particlesystem.remove(i);
  }

  for(int i=0; i<bullets.size(); i++){
    bullets.get(i).update(); 
    if(bullets.get(i).checkhit())
      bullets.remove(i);
  }
  
  for(int i=0; i<tanks.size(); i++){
    tanks.get(i).update();
    if(tanks.get(i).isDead())
      tanks.remove(i);
  }
  
}
