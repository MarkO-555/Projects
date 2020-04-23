class bullet {
  PVector pos = new PVector(width/2, height/2);
  PVector vel = new PVector(0, 0);
  boolean hit = false;

  bullet(PVector pos_, PVector vel_) {
    pos = pos_;
    vel = vel_;

    vel.setMag(vel.mag() + 5);
  }

  void update() {
    if (!hit)
      pos.add(vel);
  }
  void show() {
    if (!hit)
      ellipse(pos.x, pos.y, 2, 2);
  }

  boolean checkHit() {
    for (int i=0; i<asteroids.length; i++) {//bug!!!
      PVector dif = PVector.sub(asteroids[i].pos, pos);
      dif.x = abs(dif.x);
      dif.y = abs(dif.y);


      if ((dif.x <= asteroids[i].r/2) && (dif.y <= asteroids[i].r/2)) {
        Asteroid_Slice(i);
        return true;
      }
    }
    return false;
  }
}

void bullet_Push(bullet a) {
  bullet[] temp = b;
  b = new bullet[b.length+1];

  for (int i=0; i<temp.length; i++) {
    b[i] = temp[i];
  }
  b[b.length-1] = a;
}

void bullet_Slice(int index) {
  bullet[] temp = b;
  b = new bullet[b.length-1];

  if (b.length!=0) {
    int v=0;
    for (int i=0; i<temp.length; i++) {

      println(b[v], temp[i]);
      if (i==index)
        i++;
      b[v] = temp[i];
      v++;
    }
  }
}
