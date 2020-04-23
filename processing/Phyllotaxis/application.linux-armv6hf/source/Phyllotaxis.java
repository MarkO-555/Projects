import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Phyllotaxis extends PApplet {

float n = 0;
float c = 4;
public void setup(){
 //size(1200,800);
 
 colorMode(HSB);
 background(0);
}

public void draw(){
 
 float a = n * 137.5f;
 float r = c * sqrt(n);
 
 float x = r*cos(a) + width/2;
 float y = r*sin(a) +height/2;
 
 fill(a % 256, 255, 255);
 noStroke();
 ellipse(x, y, 1, 1);
 n++;
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Phyllotaxis" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
