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
