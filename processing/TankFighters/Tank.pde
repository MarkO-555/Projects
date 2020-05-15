boolean left, right, up, down, firing;

class Tank{
  PVector pos = new PVector(random(width), random(height));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  PVector barrel = new PVector(0, 0);
  
  boolean player;
  
  int RED, GREEN, BLUE;
  
  float maxVel = 5;
  float maxAcc = 1;
  
  
  Tank(){
    this(true, 0, 1, 0); 
  }
  
  Tank(boolean player, int RED, int GREEN, int BLUE){
    this.player = player;
    
    this.RED = RED;
    this.BLUE = BLUE;
    this.GREEN = GREEN;
    
    left = false;
    right = false;
    up = false;
    down = false; 
  }
  
  void update(){
    if(player){
      controls();
    }
    
    Draw();
    
    acc.set(constrain(acc.x,-maxAcc, maxAcc), constrain(acc.y,-maxAcc, maxAcc));
    
    vel.add(acc);
    vel.set(constrain(vel.x,-maxVel, maxVel), constrain(vel.y,-maxVel, maxVel));
    
    pos.add(vel);
    acc.set(0, 0);
    
    vel.mult(0.9);
  }
  
  void applyForce(PVector vec){
     acc.add(vec);
     //vel.set(vel);
  }

  void fire(){
    bullets.add(new bullet(this));
    firing = false;
  }

  void controls(){
    PVector vec = new PVector(0, 0);
    float num = 5;
    if (up)
      vec.set(vec.x, -num);
    if (down)
      vec.set(vec.x, num);
    if (left)
      vec.set(-num, vec.y);
    if (right)
      vec.set(num, vec.y);
    if(firing)
      fire();
      
    applyForce(vec);
  }
  
  void Draw(){
        float theta = (vel.heading());
    //fill(0);
    stroke(0);
    strokeWeight(2);
    
    push();
      translate(pos.x, pos.y);
      
      rotate(theta);
      
      //if(player)
      //  fill(0, 100, 0);
      //else
      //  fill(100, 0, 0);
        
      fill(RED*100, GREEN*100, BLUE*100);
      rect(-20, -15, 40, 30);
      
    pop();
    
    push();
      translate(pos.x, pos.y);
      
      PVector target = new PVector(0, 0);
      
      if(player)
        target = new PVector(mouseX, mouseY);
      else
        target = new PVector(0, 0);
      
      barrel = pos.copy().sub(target);
      
      
      
      rotate(barrel.heading() + 2*PI/4);
      strokeWeight(0);
      
      //if(player)
      //  fill(0, 140, 0);
      //else
      //  fill(140, 0, 0);
        
      fill(140*RED, 140*GREEN, 140*BLUE);
      
      ellipse(0, 13, 5, 40);
      
      //if(player)
      //  fill(0, 140, 0);
      //else
      //  fill(140, 0, 0);
      
      ellipse(0, 0, 26, 26);
      //line(0, 0, 25, 25);
    pop();
  }
}

void keyPressed() {
  if (key=='a')
    left = true;
  if (key=='d')
    right = true;
  if (key=='w')
    up = true;
  if (key=='s')
    down = true;
  if(key=='z')
    visual = true;
  if(key=='q')
    firing = true;
}

void keyReleased() {
  if (key=='a')
    left = false;
  if (key=='d')
    right = false;
  if (key=='w')
    up = false;
  if (key=='s')
    down = false;
  if(key=='z')
    visual = false;
  if(key=='q')
    firing = false;
}