class rocket {
  PVector pos = new PVector(width/2, 0);
  PVector vel;
  
  boolean hit = false;
  
  float fitness = 0;
  
  PVector[] genes = new PVector[maxTime];

  rocket() {
    for(int i=0; i<maxTime; i++){
      genes[i] = PVector.random2D(); 
    }
  }
  
  rocket(PVector[] genes){
    this.genes = genes;
  }
  
  public void show(){
    ellipse(pos.x, pos.y, 4, 4); 
  }
  
  public void grade(){
    this.fitness = this.pos.y/200; 
  }
  
  public void update() {
    if(!hit){
      vel = genes[Time];
      //println(vel);
      
      pos.add(vel);
      vel.mult(0);
    }
  }
  
  void walls(){
    if((pos.x <= 0 || pos.x >= width) || (pos.y <= 0 || pos.y >= height))
      hit = true;
  }
}
