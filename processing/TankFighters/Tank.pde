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
  private float RED, GREEN, BLUE;
  
  Tank(){
    this(true, 0, 1, 0); 
  }
  
  Tank(boolean player, float RED, float GREEN, float BLUE){
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
    return;
  }

  void fire(){
    if(!menuWasUp){
      particlesystem.add(new ParticleSystem(20, pos.copy().sub(barrel.copy().setMag(Width-10)), pos.copy().sub(barrel), 45, 2, 2, 2));
      
      bullets.add(new bullet(this));
      applyForce(barrel.copy().setMag(2));
    }
    mouseDown = false;
    
    menuWasUp = false;
    return;
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
    if(mouseDown)
      fire();
      
      
    applyForce(vec);
    return;
  }
  
  void AI(){
    for(int i=0; i<tanks.size(); i++){
      if(tanks.get(i).player)
        target = tanks.get(i).pos;
    }
    return;
  }
  
  void hit(){
    //particlesystem.add(new ParticleSystem(10, pos, RED*100, GREEN*100, BLUE*100));
    Health -= 1; 
    
    return;
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
        
      barrel = pos.copy().sub(target);
      
      rotate(barrel.heading() + 2*PI/4);
      strokeWeight(0);
        
      fill(140*RED, 140*GREEN, 140*BLUE);
      
      ellipse(0, Width*13/40, Width/8, Width);
      
      //30*26/30
      ellipse(0, 0, Height*26/30, Height*26/30);
      //line(0, 0, 25, 25);
    pop();
    return;
  }
  
  boolean isDead(){
    if(Health<=0){
      particlesystem.add(new ParticleSystem(50,pos.copy().add(pos.copy().sub(pos).setMag(20)), vel.copy().mult(-1), 360, RED, GREEN, BLUE));
      return true;
    }
    return false; 
  }
}
