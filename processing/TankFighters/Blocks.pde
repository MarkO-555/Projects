class Block{
  float x, y, w, h, RED, GREEN, BLUE;
  PImage texture;
  int type;
  Block(float x, float y, float w, float h, PImage texture, int type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texture = texture;
    this.type = type;
  }
   
  Block(float x, float y, float w, float h, float RED, float GREEN, float BLUE, int type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texture = null;
    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;
    this.type = type;
  }
  
  void update(){
    Draw();
  }
  
  
  void isColliding(Tank tank){
    if(tank.pos.x+tank.r/2 >= x*it && tank.pos.x-tank.r/2 <= (x+w)*it && tank.pos.y+tank.r/2 >= y*it && tank.pos.y-tank.r/2 <= (y+h)*it){
      tank.pos.add(tank.pos.copy().sub((x+w/2)*it, (y+h/2)*it).setMag(2)).sub(tank.vel);
      tank.vel.mult(-2);
    }

  }
  
  void Draw(){
    if(texture == null){
      fill(RED, GREEN, BLUE);
      rect(x*it, y*it, w*it, h*it);
    }
    else{
      image(texture, x*it + (w*it)/2, y*it + (h*it)/2);
    }
  }
}
