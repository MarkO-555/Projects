ArrayList<Tank> tanks;
ArrayList<bullet> bullets;
ArrayList<ParticleSystem> particlesystem;
ArrayList<Block> blocks;
int count = 0;
int pauseCount = 0;

float it =80; // 20px X 20px
MainMenu mainMenu;

void setup() {
  size(800, 800);
  
  //for(int i=0; i<200; i++){
  //  println(i, char(i));
  //}
  
  tanks = new ArrayList<Tank>();
  bullets = new ArrayList<bullet>();
  particlesystem = new ArrayList<ParticleSystem>();
  mainMenu = new MainMenu();
  blocks = new ArrayList<Block>();

  tanks.add(new Tank(true, 0, 1, 0));
  tanks.add(new Tank(false, 1, 0, 0));
}

void draw() {
    
  //println(key, keyCode);
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
    
    //println(blocks.size());
    //ArrayList<Integer> badBlocks = new ArrayList<Integer>();
    for(int i=0; i<blocks.size(); i++){
      blocks.get(i).update(); 
      for(int t=0; t<tanks.size(); t++){
        blocks.get(i).isColliding(tanks.get(t)); 
      }
      
      for(int v=0; v<blocks.size(); v++){
        if(v != i){
          if(blocks.get(i).x == blocks.get(v).x && blocks.get(i).y == blocks.get(v).y)
            blocks.remove(v);
        }
      }
    }
    
    count++;
  }
}
