class Snowflake {
  PVector pos = new PVector(random(width), random(-100, -10));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float r= random(1,8);
  


  void update() {
    vel.add(acc);
    vel.limit(r*.2);
    pos.add(vel);
    acc.set(0,0);
  }
  
  void applyForce(PVector force){
    //Parallax effect
    PVector f = force.copy();
    f.mult(r);
    
    
    //force.copy().div(mass);
    acc.add(f); 
  }
  
  void render() {
    stroke(255);
    ellipse(pos.x, pos.y, r, r);
  }
  
  Boolean offScreen(){
      return (pos.y > height+r);
  }
  
  
}

int snowLength =0;
void Snowflake_Push(Snowflake flake) {
  Snowflake[] temp = snow;
  snow = new Snowflake[snow.length+1];

  for (int i=0; i<temp.length; i++) {
    snow[i] = temp[i];
  }
  snow[snow.length-1] = new Snowflake();
}

void Snowflake_Slice(int index) {
  Snowflake[] temp = snow;
  snow = new Snowflake[snow.length-1];

  int v=0;
  for (int i=0; i<temp.length; i++) {
    if(i==index)
      i++;
    snow[v] = temp[i];
    v++;
  }
}
