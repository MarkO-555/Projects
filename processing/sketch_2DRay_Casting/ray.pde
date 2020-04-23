class Ray{
  PVector pos;
  PVector dir = new PVector(1, 0);
  Ray(PVector pos_, float angle){
    pos = pos_;
    dir = PVector.fromAngle(angle);
    
  }
  
  void show(){
    stroke(255, 125);
    push();
    translate(pos.x, pos.y);
    line(0, 0, dir.x *10 , dir.y*10);
    pop();
  }
  
  void setDir(float x, float y){
    dir.x = x-pos.x;
    dir.y = y-pos.y;
    dir.normalize();
  }
  
  PVector cast(Boundary b){
    //PVector p1 = wall.a.copy();
    //PVector p2 = wall.b.copy();
    //PVector p3 = pos.copy();
    //PVector p4 = dir.copy().add(pos);
    
    float x1 = b.a.x;
    float y1 = b.a.y;
    float x2 = b.b.x;
    float y2 = b.b.y;
    
    float x3 = pos.x;
    float y3 = pos.y;
    float x4 = pos.x + dir.x;
    float y4 = pos.y + dir.y;
    
    float den = (x1 - x2)*(y3-y4)-(y1-y2)*(x3-x4);
    
    if(den ==0){
      return null; 
    }
    
    float t =  ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/den;
    float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/den;
    
    if(t>0 && t<1 && u>0){
      PVector pt = new PVector(x1+t*(x2-x1), y1+t*(y2-y1));
      return pt; 
    }
    else{
     return null; 
    }
  }
}
