class rocket {
  PVector pos = new PVector(width/2, height/2);
  PVector vel;

  int genesLength = 100;
  int count =0;
  PVector[] genes = new PVector[genesLength];

  rocket() {
    for (int i=0; i<genesLength; i++) {
      genes[i] = new PVector(random(1, -1), random(1, -1));
    }
  }
  rocket(PVector[] g) {
    for (int i=0; i<g.length; i++) {
      genes[i] = g[i];
    }
  }
  
  public void show(){
    ellipse(pos.x, pos.y, 4, 4); 
  }
  
  public void update() {
    vel = genes[count];
    println(vel);
    
    pos.add(vel);
    vel.mult(0);
    
    
    
    if(count != genes.length-1)
      count++;
  }
}
