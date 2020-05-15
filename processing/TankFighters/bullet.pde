class bullet{
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 1);
  float maxVel = 5;
  Tank tank;
  
  bullet(Tank tank){
     this.tank = tank;
     pos = tank.pos.copy();
     vel = tank.barrel.copy();
     //vel = tank.vel.copy();
     
     vel.setMag(5);
     vel.mult(-1);
  }
  
  void update(){
    //vel.set(constrain(vel.x, -maxVel, maxVel), constrain(vel.y, -maxVel, maxVel));
    pos.add(vel);
    
    Draw();
  }
  
  boolean Recycle(){
    if(pos.x>width || pos.x<0 || pos.y>height || pos.y<0)
      return true;
    return false;
  }
  
  void Draw(){
    fill(255);
    strokeWeight(0);
    ellipse(pos.x, pos.y, 5, 5); 
  }
}
