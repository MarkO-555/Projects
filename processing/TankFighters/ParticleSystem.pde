
// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  PImage img;
  Tank tank;
  bullet b;

  ParticleSystem(int num, PVector pos, PImage img_) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = pos.copy();                                   // Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img));         // Add "num" amount of particles to the arraylist
    }
  }
  
  ParticleSystem(int num, bullet b, Tank tank) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = b.pos.copy();                                   // Store the origin point
    img = null;
    
    origin.sub(origin.copy().sub(tank.pos).div(2));
    
    this.b = b;
    this.tank = tank;
    
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, tank.RED*100, tank.GREEN*100, tank.BLUE*100));         // Add "num" amount of particles to the arraylist
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
    for (Particle p : particles) {
      p.applyForce(dir);
    }
  }  

  void addParticle() {
    if(img==null)
      particles.add(new Particle(origin, tank.RED, tank.GREEN, tank.BLUE));
    else
      particles.add(new Particle(origin, img));
  }
  
  boolean isDead(){
    for(int i=0; i<particles.size(); i++){
      if(particles.get(i).isDead())
        return true;
    }
    return false;
  }
}



// A simple Particle class, renders the particle as an image

class Particle {
  private float RED, GREEN, BLUE;
  
  PVector loc;
  PVector vel;
  PVector acc;
  PVector target;
  
  float lifespan;
  PImage img;

  Particle(PVector pos, PImage img_) {
    acc = new PVector(0, 0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    
    vel = new PVector(vx, vy);
    //vel = new PVector(randomGaussian()*0.3, -Math.abs(randomGaussian()*0.50));
    
    loc = pos.copy();
    lifespan = random(150);
    img = img_;
  }
  
  Particle(PVector pos, float RED, float GREEN, float BLUE) {
    acc = new PVector(0, 0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    vel = new PVector(vx, vy);
    //vel = new PVector(randomGaussian()*0.3, -Math.abs(randomGaussian()*0.50));
    
    this.RED = RED;
    this.BLUE = BLUE;
    this.GREEN = GREEN;
    
    //println("test", RED);
    
    loc = pos.copy();
    lifespan = random(200);
    img = null;
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
    if(img==null){
      noStroke();
      fill(RED, GREEN, BLUE);
      ellipse(loc.x, loc.y, 4, 4);
    }
    else{
      imageMode(CENTER);
      tint(255, lifespan);
      image(img, loc.x, loc.y);
    }
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
