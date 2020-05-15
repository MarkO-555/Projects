class Tank{
  PVector pos = new PVector(width/2, height/2);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PVector apos = new PVector(0, 0);
  
  float maxVel = 20;
  float maxAcc = 1;
  
  void update(){
    acc.set(constrain(acc.x,-maxAcc, maxAcc), constrain(acc.y,-maxAcc, maxAcc));
    
    vel.add(acc);
    vel.set(constrain(vel.x,-maxVel, maxVel), constrain(vel.y,-maxVel, maxVel));
    
    pos.add(vel);
    acc.set(0, 0);
    
    vel.mult(0.9);
    
    float theta = (vel.heading());
    fill(0);
    stroke(200);
    strokeWeight(1);
    
    push();
      translate(pos.x, pos.y);
      
      rotate(theta);
      
      line(-20, -15, 20, -15);
      line(-20, 15, 20, 15);
      line(-20, -15, -20, 15);
      line(20, -15, 20, 15);
      
    pop();
    
    push();
      translate(pos.x, pos.y);
      PVector mouse = new PVector(mouseX, mouseY);
      PVector distance = pos.copy().sub(mouse);
      
      rotate(distance.heading()+3*PI/4);
      line(0, 0, 25, 25);
    pop();
    apos = pos.copy();
  }
  
  void applyForce(PVector vec){
     acc.add(vec);
     //vel.set(vel);
  }
}
