import processing.video.*;
//import ipcapture.*;

Capture cam;
//IPCapture cam;

int c = 0;

//255
int ra = 169;
int ga = 169;
int ba = 169;
//int tha = 100;

//0
int rb = 63;
int gb = 85;
int bb = 78;
//int thb = 0;

boolean avflag = false;

int[][] pixs;

int Crashes = 0;

void setup() {
  //size(640, 180); // 320/90
  size(640, 480);
  //fullScreen();
  pixs = new int[width][height];
  try {
    cam = new Capture(this, Capture.list()[0]);
  }
  catch(Exception exc) {
    if (Crashes<=100) {
      Crashes++;
      setup();
    }
    else{
      println("could not load camera");
      //println(Capture.list());
    }
  }
  //cam = new IPCapture(this, "http://frcvision.local:1181/stream.mjpg", "", "");

  //String[] list = cam.list();

  //for(int i=0; i<list.length; i++){
  //  println(i, list[i]); 
  //}
  cam.start();
  thread("FindLocation");
}

void draw() {
  background(0);

  if (cam.available())
    cam.read();

  for (int x=0; x<cam.width; x+=c) {
    for (int y=0; y<cam.height; y+=c) {
      int index = y*cam.width+x;
      color[] cols = cam.pixels;
      int current = cols[index];

      int r = (int)red(current);
      int g = (int)green(current);
      int b = (int)blue(current);

      if ((r<=ra && r>=rb) && (g<=ga && g>=gb) && (b<=ba && b>=bb)) {

        int[] average = new int[3];
        if (x%(2*c+1)==c && y%(2*c+1)==c) {
          
          for(int nx =-2*c; nx<2*c; nx+=1){
            for(int ny =-2*c; ny<2*c; ny+=1){
              average[0] += red(current);
              average[1] += green(current);
              average[2] += blue(current);
            }
          }
          
          average[0] /= Math.pow(2*c+1, 2);
          average[1] /= Math.pow(2*c+1, 2);
          average[2] /= Math.pow(2*c+1, 2);
          
          if(c==0)
            set(x, y, current);
          else{
            for (int x_=-(c+1)*c; x_<(c+1)*c; x_++) {
              for (int y_=-(c+1)*c; y_<(c+1)*c; y_++) {
                if((x+x_<=width-1 && x+x_>=0) && (y+y_ <=height-1 && y+y_>=0)){
                  if(avflag)
                    set((x+x_), (y+y_), color(average[0], average[1], average[2]));                
                  else
                    set((x+x_), (y+y_), current);
                }
              }
            }
          }
        }
      }
      if (c==0)
        y++;
    }
    if (c==0)
      x++;
  }

  fill(color(0, 255, 0));

  text("c: "+c+" "+avflag, 10, 20);
  text("upper: ra "+ra+" ga "+ga+" ba "+ba, 10, 40);
  text("lower: rb "+rb+" gb "+gb+" bb "+bb, 10, 60);
  //text("th "+tha+" / "+thb, 10, 100);



  //DrawLocation();
}

void mouseWheel(MouseEvent event) {
  int t = -event.getCount();

  if (key=='q' && ((ra+t<=255 && t>0) || (ra+t>=0 && t<0)))
    ra+=t; 
  else if (key=='a' && ((rb+t<=255 && t>0) || (rb+t>=0 && t<0)))
    rb+=t;
  else if (key=='w' && ((ga+t<=255 && t>0) || (ga+t>=0 && t<0)))
    ga+=t;
  else if (key=='s' && ((gb+t<=255 && t>0) || (gb+t>=0 && t<0)))
    gb+=t;
  else if (key=='e' && ((ba+t<=255 && t>0) || (ba+t>=0 && t<0)))
    ba+=t;
  else if (key=='d' && ((bb+t<=255 && t>0) || (bb+t>=0 && t<0)))
    bb+=t;
  //else if(key=='r' && ((tha+t<=100 && t>0) || (tha+t>=0 && t<0)) && (tha+t >= thb))
  //  tha+=t;
  //else if(key=='f' && ((thb+t<=100 && t>0) || (thb+t>=0 && t<0)) && (thb+t <= tha))
  //  thb+=t;
  else if (key=='x' && (c+t>=0) && (c+t<=width/3 || c+t<=height/3))
    c+=t;
}

void keyPressed() {
  if (key=='z') {
    if (avflag)
      avflag = false;
    else
      avflag = true;
  }
}
