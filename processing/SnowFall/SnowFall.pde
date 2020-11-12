ArrayList<Snowflake> snow = new ArrayList();
PVector gravity = new PVector(0, 0.03);
  
void setup() {
  size(600, 600);
}
void draw() {
  background(0);

  for (int i=0; i<snow.size(); i++) {
    snow.get(i).render();
    snow.get(i).update();
    snow.get(i).applyForce(gravity);
    if(snow.get(i).offScreen()){
      snow.remove(i);
    }
  }
  
  snow.add(new Snowflake());
  
}
