class Snowflake {
  PVector pos = new PVector(random(width), random(-100, -10));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float r= random(1,8);
  
  void update() {
    vel.add(acc);
    vel.limit(r*.2);
    pos.add(vel);
    acc.set(0,0);
  }
  
  void applyForce(PVector force){
    PVector f = force.copy();
    f.mult(r);
    
    
    //force.copy().div(mass);
    acc.add(f); 
  }
  
  void render() {
    stroke(255);
    ellipse(pos.x, pos.y, r, r);
  }
  
  Boolean offScreen(){
    return (pos.y > height+r);
  }
  
  
}
