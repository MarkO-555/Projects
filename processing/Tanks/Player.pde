class Tank{
  PVector pos = new PVector(0, 0);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float maxVel =5;
  
  
  Tank(){
  }
  
  void update(){
    vel.add(acc);
    vel.set(constrain(vel.x,-maxVel, maxVel), constrain(vel.y,-maxVel, maxVel));
    
    pos.add(vel);
    acc.set(0, 0);
    
    vel.mult(0.9);
    
    rect(pos.x, pos.y, 10, 10);
  }
  
  void applyForce(PVector vec){
     acc.add(vec);
  }
}
