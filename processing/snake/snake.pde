String[] Scene;
Player player;

int n=0;

void setup() {
  size(900, 900);
  Scene = new String[width/25*height/25]; 
  player = new Player();
  n = floor(random(width/25)) * floor(random(height/25));
  Scene[n] = "Apple";
}

void draw() {
  background(0);
  
  for (int x=0; x<width/25; x++) {
    for (int y=0; y<height/25-1; y++) {
      if (Scene[x*(width/25-1)+y] == null) {
        fill(255);
      }
      else if(Scene[x*(width/25-1)+y] == "Apple"){
        fill(255/2);
      }
      else{
         fill(0);
      }
    rect(25*x, 25*y, 25, 25);
    }
  }
}

void keyPressed(){
  if(key=='a'){
    player.move(-1,0); 
  }
  else if(key=='s'){
    player.move(+1, 0);
  }
}
