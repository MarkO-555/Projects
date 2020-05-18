class bullet{
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 1);
  float maxVel = 10;
  float r = 5;
  Tank tank;
  
  bullet(Tank tank){
     this.tank = tank;
     
     pos = tank.pos.copy();
     vel = tank.barrel.copy();
     
     vel.setMag(-maxVel);
  }
  
  void update(){
    //vel.set(constrain(vel.x, -maxVel, maxVel), constrain(vel.y, -maxVel, maxVel));
    pos.add(vel);
    
    Draw();
    return;
  }
  
  boolean checkhit(){
    if(pos.x>width || pos.x<0 || pos.y>height || pos.y<0)//Out of bounds
      return true;
      
    for(int i=0; i<tanks.size(); i++){
      Tank tank = tanks.get(i);
      if(tank.player != this.tank.player){
        if(dist(pos.x, pos.y, tank.pos.x, tank.pos.y) <= (r+tank.r)){
          particlesystem.add(new ParticleSystem(10,pos.copy().add(tank.pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 45, tank.RED, tank.GREEN, tank.BLUE));
          //particlesystem.get(particlesystem.size()-1).RED = tank.RED;
          //particlesystem.get(particlesystem.size()-1).GREEN = tank.GREEN;
          //particlesystem.get(particlesystem.size()-1).BLUE = tank.BLUE;
          
          tank.hit();
          tank.applyForce(vel.copy().setMag(2));
          return true;
        }
      }
    }
    return false;
  }
  
  void Draw(){
    fill(255);
    strokeWeight(1);
    ellipse(pos.x, pos.y, r, r); 
    return;
  }
}
