color[][] cells = new color[7][6];
boolean player1 =true;
int r=50;

void setup(){
  size(600, 600);
  
  for(int x=0; x<cells.length; x++){
    for(int y=0; y<cells[x].length; y++){
      cells[x][y] = color(255,255,255);
    }
  }
}

void draw(){
  background(color(0,150,255));
  
  //rect(0,0, width, 20);
  
  
  //strokeWeight(20);
  //stroke(color(0,0,255));
  //line(0,0,0,height);
  //line(0,0,width,0);
  //line(width,0,width,height);
  //line(0,height,width,height);
  strokeWeight(0);
  
  for(int x=0; x<cells.length; x++){
    for(int y=0; y<cells[x].length; y++){
      fill(cells[x][y]);
      ellipse(x*(width/cells.length)+r, y*(height/cells[x].length)+r, r, r);
    }
  }
}

void mousePressed(){
  color current;
  
  if(player1)
    current = color(255, 255, 0);
  else
    current = color(255, 0, 0);
    
  for(int x=0; x<cells.length; x++){
    if(mouseX >x*(width/cells.length)+48- r/2 && mouseX<x*(width/cells.length)+48+ r/2){
      for(int y=0; y<cells[x].length; y++){
        
        if(cells[x][0] == color(255, 255, 255)){
          if(player1)
            player1=false;
          else
            player1=true;
        }
        
        if(cells[x][y]==color(255, 255, 255)){
          cells[x][y] = current;
          if(y>0)
            cells[x][y-1] = color(255, 255, 255);
        }
        else if(y>0){
          if(cells[x][y-1]==color(255, 255, 255))
            cells[x][y-1] = current;
        }
        
      }
      
    }
  }
}

boolean checkWin(int x, int y){
  
  return false;
}
