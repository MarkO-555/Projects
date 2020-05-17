ParticleSystem ps;

void setup() {
  size(640, 360);
  PImage img = loadImage("texture.png");
  ps = new ParticleSystem(0, new PVector(width/2, height-60), img);
}

void draw() {
  background(0);

  // Calculate a "wind" force based on mouse horizontal position
  //float dx = map(mouseX, 0, width, -0.2, 0.2);
  //PVector wind = new PVector(dx, 0);
  //ps.applyForce(wind);
  ps.run();
}

void mousePressed(){
  for (int i = 0; i < 10; i++) {
    ps.addParticle();
  } 
}

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  PImage img;

  ParticleSystem(int num, PVector v, PImage img_) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.copy();                                   // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img));         // Add "num" amount of particles to the arraylist
    }
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  // Method to add a force vector to all particles currently in the system
  void applyForce(PVector dir) {
    // Enhanced loop!!!
    for (Particle p : particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    particles.add(new Particle(origin, img));
  }
}



// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  PVector target;
  
  float lifespan;
  PImage img;

  Particle(PVector l, PImage img_) {
    acc = new PVector(0, 0);
    //float vx = randomGaussian()*0.3;
    //float vy = randomGaussian()*0.3 - 1.0;
    //vel = new PVector(vx, vy);
    //vel = new PVector(randomGaussian()*0.3, -Math.abs(randomGaussian()*0.50));
    
    loc = l.copy();
    lifespan = random(150);
    img = img_;
  }

  void run() {
    update();
    render();
  }

  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update position
  void update() {
    target = new PVector(mouseX, mouseY);
    
    vel.add(acc);
    loc.add(vel);
    lifespan -= 2.5;
    acc.mult(0); // clear Acceleration
  }

  // Method to display
  void render() {
    //imageMode(CENTER);
    //tint(255, lifespan);
    //image(img, loc.x, loc.y);
    
    // Drawing a circle instead
     fill(255,lifespan);
     noStroke();
     //ellipse(loc.x,loc.y,img.width,img.height);
     
     ellipse(loc.x, loc.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
