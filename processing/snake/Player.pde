class Player{
  int x[] = new int[50];
  int y[] = new int[50];
  int size = 1;
  //int x = (width/25) /2;
  //int y = (height/25) /2;
  //int[] tail = new int[50];
  //int oldX;
  //int oldY;
  
  
  Player(){
    x[0] = floor(random(width/25));
    y[0] = floor(random(height/25));
    Scene[x[0]*(width/25-1)+y[0]] = "Player";
  }
  
  void move(int x_, int y_){
    eat(x_, y_);
    for(int a=0; a<size; a++){
      Scene[(x[a]+x_)*(width/25-1)+(y[a]+y_)] ="Player"; 
    }
  }
  
  void eat(int x_, int y_){
    if(Scene[(x[0]+x_)*(width/25-1)+(y[0]+y_)] == "Apple"){
      n = floor(random(width/25)) * floor(random(height/25));
      Scene[n] = "Apple";
      size++;
      x[size] = x[size-1];
      y[size] = x[size-1];
    }
  }
}
