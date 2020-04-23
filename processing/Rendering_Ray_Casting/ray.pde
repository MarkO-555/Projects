class Ray{
  PVector pos;
  PVector dir = new PVector(1, 0);
  
  public PVector p1,p2,p3,p4,pt;
  public float den,t,u;
  
  Ray(PVector pos_, float angle){
    pos = pos_;
    dir = PVector.fromAngle(angle);
    
  }
  
  void setAngle(float angle){
    dir = PVector.fromAngle(angle);
  }
  
  void show(){
    stroke(255);
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
  
  PVector cast(Boundary b){//bug when rays exceed 179
    p1 = b.a.copy();
    p2 = b.b.copy();
    
    p3 = pos.copy();
    p4 = dir.copy().add(pos);
    
    den = (p1.x - p2.x)*(p3.y-p4.y) - (p1.y-p2.y)*(p3.x-p4.x);
    
    if(den == 0){
      return null; 
    }
    
    t =  ((p1.x-p3.x)*(p3.y-p4.y)-(p1.y-p3.y)*(p3.x-p4.x))/den;
    u = -((p1.x-p2.x)*(p1.y-p3.y)-(p1.y-p2.y)*(p1.x-p3.x))/den;
    
    //  println("boundary:", p1, p2);
    //  println("bourndaryId:", b.id);
    //  println("pos:",p3);
    //  println("dir:", p4);
    //  println("numbers:", den, t, u);
    
    if(t>0 && t<1 && u>0){
      pt = new PVector(p1.x+t* (p2.x-p1.x), p1.y+t*(p2.y-p1.y));
      return pt; 
    }
    else{
     return null; 
    }
    
  }
}
