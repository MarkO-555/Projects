ArrayList<Tank> tanks;

float it =80; // 20px X 20px

void setup() {
  size(800, 800);
  tanks = new ArrayList<Tank>();

  tanks.add(new Tank(true));
  
  tanks.add(new Tank(false));
  
}

void draw() {
  background(0);
  
  strokeWeight(1);
  if(visual){
    //println(2*(width/it));
    
    for(int x=0; x<width; x+=it){
      for(int y=0; y<height; y+=it){
        rect(x, y, it, it);
      } 
    }
  }


  for(int i=0; i<tanks.size(); i++){
    tanks.get(i).update();
  }
  //tank.update();
}
