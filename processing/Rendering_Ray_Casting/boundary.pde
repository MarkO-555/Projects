class Boundary{
  PVector a;
  PVector b;
  int id =0;
  
  Boundary(float x1, float y1, float x2, float y2, int id_){
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
    id = id_;
    if(id==6)
      ellipse(a.x, a.y, 5, 5);
  }
  
  void show(){
    stroke(255);
    line(a.x, a.y, b.x, b.y); 
  }
}
