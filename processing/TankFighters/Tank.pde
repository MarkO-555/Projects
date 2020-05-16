boolean left, right, up, down, firing, ring;

class Tank{
  PVector pos = new PVector(random(width), random(height));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float r;
  
  private PVector target = new PVector(0, 0);
  private PVector barrel = new PVector(0, 0);
  
  
  private float Health = 10;
  private float maxHealth = 10;
  
  private float scale = 1;
  private float Width = 40;
  private float Height = 30;
  private float maxVel = 5;
  private float maxAcc = 1;
  private boolean player;
  private int RED, GREEN, BLUE;
  
  
  
  Tank(){
    this(true, 0, 1, 0); 
  }
  
  Tank(boolean player, int RED, int GREEN, int BLUE){
    this.player = player;
    
    this.RED = RED;
    this.BLUE = BLUE;
    this.GREEN = GREEN;
    
    Width *= scale;
    Height *= scale;
    
    //r = Width + 35;
    r = Width;
    
    left = false;
    right = false;
    up = false;
    down = false; 
  }
  
  void update(){
    if(player)
      controls();
    else
      AI();
    
    Draw();
    
    if(Health > maxHealth)
      Health = maxHealth;
    
    acc.set(constrain(acc.x,-maxAcc, maxAcc), constrain(acc.y,-maxAcc, maxAcc));
    
    vel.add(acc);
    vel.set(constrain(vel.x,-maxVel, maxVel), constrain(vel.y,-maxVel, maxVel));
    
    pos.add(vel);
    acc.set(0, 0);
    
    vel.mult(0.9);
  }
  
  void applyForce(PVector vec){
    acc.add(vec);
  }

  void fire(){
    int id = Math.round(random(100000));
    
    for(int i=0; i<bullets.size(); i++){
      if(id == bullets.get(i).ID){
        fire();
        return;
      }
    }
    
    bullets.add(new bullet(this, id));
    applyForce(barrel.copy().setMag(2));
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
  
  void AI(){
    for(int i=0; i<tanks.size(); i++){
      if(tanks.get(i).player)
        target = tanks.get(i).pos;
    }
  }
  
  void hit(){
    Health -= 1; 
  }
  
  void Draw(){
    float theta = (vel.heading());
    
    push();
      translate(pos.x, pos.y);
      
      rotate(theta);
      if(ring){
        noFill();
        float val = map(Health, 0, maxHealth, 0, 255);
        
        stroke(RED*val, GREEN*val, BLUE*val);
        strokeWeight(3);
        ellipse(0, 0, r, r);
      }
      
      stroke(0);
      strokeWeight(2);
      fill(RED*100, GREEN*100, BLUE*100);
      rect(-Width/2, -Height/2, Width, Height);
      
    pop();
    
    push();
      translate(pos.x, pos.y);
      
      
      if(player)
        target = new PVector(mouseX, mouseY);
      //float it = 10;
      
      //if(actual.x < target.x)
      //  actual.x += it;
      //else if(actual.x > target.x)
      //  actual.x -= it;
      //if(actual.y < target.y)
      //  actual.y += it;
      //else if(actual.y > target.y)
      //  actual.y -= it;
      
      barrel = pos.copy().sub(target);
      
      rotate(barrel.heading() + 2*PI/4);
      strokeWeight(0);
        
      fill(140*RED, 140*GREEN, 140*BLUE);
      
      ellipse(0, Width*13/40, Width/8, Width);
      
      //30*26/30
      ellipse(0, 0, Height*26/30, Height*26/30);
      //line(0, 0, 25, 25);
    pop();
  }
  
  void collisions(){
    
  }
  
  boolean isDead(){
    if(Health<=0)
      return true;
    return false; 
  }
}

void mousePressed(){
  firing=true;
}

void mouseReleased(){
  firing=false; 
}

void keyPressed() {
  if (key=='a'){
    left = true;
    right = false;
  }
  if (key=='d'){
    right = true;
    left = false;
  }
  if (key=='w'){
    up = true;
    down = false;
  }
  if (key=='s'){
    down = true;
    up = false;
  }
  if(key=='q')
    ring = true;
  if(key=='z')
    visual = true;
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
  if(key=='q')
    ring = false;
  if(key=='z')
    visual = false;
}
