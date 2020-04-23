class Particle {
  PVector pos = new PVector(sceneW/2, height/2);
  Ray[] rays = new Ray[360];
  float heading = 0;

  Particle() {
    for (int i=-rays.length/2; i<rays.length/2; i++) {
      rays[i+rays.length/2] = new Ray(pos, radians(i));
    }
  }

  void rot(float angle){
    heading += angle;
    for (int i=-range/2; i<range/2; i++) {
      rays[i+range/2].setAngle(radians(i) + heading); 
    }
  }

  void show() {
    for (int i=0; i<range; i++) {
      rays[i].show();
    }
    fill(200);
    ellipse(pos.x, pos.y, 8, 8);
  }

  PVector last = new PVector();
  void update() {
    
    if(!console.open)
      last = new PVector(mouseX, mouseY);
      
    pos.x = last.x;
    pos.y = last.y;
  }
  
  float[] look(Boundary[] b) {
    float[] s = new float[range];
    for (int i=0; i<range; i++) {
      float record = 100000000;
      PVector closest = null;
      for (int v =0; v<b.length; v++) {

        PVector pt = rays[i].cast(walls[v]);//debug???
        
        
        if (pt != null) {
          float d = PVector.dist(pos, pt);
          //float a = rays[i].dir.heading() - heading;
          //d*=cos(a);
          
          if (d<record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest !=null) {
        stroke(255, 100);
        line(pos.x, pos.y, closest.x, closest.y);
      }
      s[i] = record;
    }
    return s;
  }
  
}
