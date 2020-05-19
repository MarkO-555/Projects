ArrayList<Tank> tanks;
ArrayList<bullet> bullets;
ArrayList<ParticleSystem> particlesystem;
ArrayList<Block> blocks;
boolean mouseDown, openMenu;
boolean menuWasUp = true;
int count = 0;
int pauseCount = 0;

float it =80; // 20px X 20px
MainMenu mainMenu;

void setup() {
  size(800, 800);
  tanks = new ArrayList<Tank>();
  bullets = new ArrayList<bullet>();
  particlesystem = new ArrayList<ParticleSystem>();
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();

  tanks.add(new Tank(true, 0, 1, 0));
  tanks.add(new Tank(false, 1, 0, 0));
  
  blocks.add(new Block(5, 5, 1, 1, 150, 150, 150, 0));
}

void draw() {
    
  if(mainMenu.open){
    mainMenu.update(); 
  }
  else{
    background(0);
    
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
    
    for(int i=0; i<particlesystem.size(); i++){
      ParticleSystem system = particlesystem.get(i);
      system.update();
      if(system.isDead())
        particlesystem.remove(i);
    }
    
    for(int i=0; i<blocks.size(); i++){
      blocks.get(i).update(); 
      for(int t=0; t<tanks.size(); t++){
        blocks.get(i).isColliding(tanks.get(t)); 
      }
    }
    
    count++;
  }
}

void mousePressed(){
  mouseDown = true;
}

void mouseReleased(){
  mouseDown = false; 
  buttonDown = false;
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
  if(key=='z'){
    mainMenu.open = true;
    mainMenu.state = -1;
    menuWasUp = true;
  }
    
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
  //if(key=='z')
  //  visual = false;
}
