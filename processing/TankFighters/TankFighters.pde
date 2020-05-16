ArrayList<Tank> tanks;
ArrayList<bullet> bullets;
boolean visual = false;

float it =80; // 20px X 20px

void setup() {
  size(800, 800);
  tanks = new ArrayList<Tank>();
  bullets = new ArrayList<bullet>();

  tanks.add(new Tank(false, 1, 0, 0));
  tanks.add(new Tank(true, 0, 1, 0));
}

void draw() {
  background(0);
  
  //PVector target = new PVector(width/2-mouseX, height/2-mouseY);
  //float Width = 40;
  //float Height = 30;
  
  //push();
  //  translate(width/2, height/2);
  //  rotate(target.heading());
  //  rect(-Width/2, -Height/2, Width, Height);
  //pop();
  //push();
  //  translate(width/2, height/2);
  //  float angle = atan(target.y/target.x);
  //  //tan(angle) = y/x;
    
  //  ellipse(0, 0, 5, 5);
  //pop();
  
  strokeWeight(1);
  
  if(visual){
    for(int x=0; x<width; x+=it){
      for(int y=0; y<height; y+=it){
        rect(x, y, it, it);
      } 
    }
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
