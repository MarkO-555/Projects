class Particle {
  PVector pos = new PVector(width/2, height/2);
  Ray[] rays = new Ray[360];

  Particle() {
    for (int i=0; i<rays.length; i++) {
      rays[i] = new Ray(pos, radians(i));
    }
  }

  void show() {
    for (int i=0; i<rays.length; i++) {
      rays[i].show();
    }
    fill(200);
    ellipse(pos.x, pos.y, 8, 8);
  }

  void update() {
    pos.x = mouseX;
    pos.y = mouseY;
  }

  void look(Boundary[] b) {
    for (int i=0; i<rays.length; i++) {
      float record = 100000000;
      PVector closest = null;
      for (int v =0; v<walls.length; v++) {
        PVector pt = rays[i].cast(walls[v]);

        if (pt != null) {
          float d = PVector.dist(pos, pt);
          if (d<record) {
            record = d;
            closest = pt;
          }
        }
      }
      if (closest !=null) {
        line(pos.x, pos.y, closest.x, closest.y);
      }
    }
  }
}
