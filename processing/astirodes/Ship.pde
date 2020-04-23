class Ship {
  PVector pos = new PVector(width/2, height/2);
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float rotation = 0;
  float r = 5;
  
  void show(){
    float theta = (this.vel.heading()) + (2.5 * PI);
    fill(255);
    stroke(200);
    strokeWeight(1);
    
    push();
      translate(this.pos.x, this.pos.y);
      rotate(theta);
      beginShape();
      vertex(-this.r, this.r * 2);
      vertex(this.r, this.r * 2);
      vertex(0, -this.r * 2);
      endShape(CLOSE);
    pop();
  }

  void update() {
    vel.limit(10);
    
    if(vel.x == 0 && vel.y == 0){
      vel.set(0.1, 0.1); 
    }
    
    pos.add(vel);
    vel.add(acc);
    
    vel.mult(0.9);
    acc.mult(0);
  }
  
  void edges(){
   if(pos.x < 0){
     pos.x = width;
     pos.y = map(pos.y, 0, height, height, 0);
   }
   else if(pos.x > width){
     pos.x  = 0;
     pos.y = map(pos.y, 0, height, height, 0);
   }
   else if(pos.y < 0){
     pos.x = map(pos.x, 0, width, width, 0);
     pos.y  = height;
   }
   else if(pos.y > height){
     pos.x = map(pos.x, 0, width, width, 0);
     pos.y  = 0;
     
   }
  }
  void turn(float change) {
    vel.rotate(change);
  }
  
  void propel(float change){
    //applyForce(new PVector(change/cos(pos.heading()), change/tan(pos.heading())));
    vel.setMag(vel.mag()+change);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }
}
