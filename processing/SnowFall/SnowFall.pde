Snowflake[] snow = new Snowflake[0];

void setup() {
  size(600, 600);
}
void draw() {
  background(0);
  PVector gravity = new PVector(0, 0.03);

  int index = snow.length;
  for (int i=0; i<snow.length; i++) {
    snow[i].render();
    snow[i].update();
    snow[i].applyForce(gravity);
    if(snow[i].offScreen()){
      Snowflake_Slice(i); 
    }
  }
  
  Snowflake_Push(new Snowflake());
  
}
