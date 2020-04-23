String[] board;
int turn =0;
boolean run = true;
void setup(){
  size(600, 600);
  board = new String[9];
  for(int i=0; i<9; i++){
     board[i] = "";
  }
  AIturn();
}
void draw(){
  fill(255);
  background(200);
  for(int i=1; i<3; i++){
    
    line(i*width/3, 0, i*width/3, height); 
    line(0, i*height/3, width, i*height/3); 
  }
  for(int x=0; x<3; x++){
    for(int y=0; y<3; y++){
      fill(0);
      //text(x*3+y, x*width/3+width/6, y*height/3+height/6);
      text(board[x*3+y], x*width/3+width/6, y*height/3+height/6);
    }
  }
  
  
  
}
boolean Win(){
  boolean result = false;
  
  if(board[0]==board[3] && board[3]==board[6] && board[6] !="")
    result = true;
  else if(board[1]==board[3] && board[3]==board[7] && board[7] !="")
    result = true;
  else if(board[2]==board[5] && board[5]==board[8] && board[8] !="")
    result = true;
  else if(board[0]==board[1] && board[1]==board[2] && board[2] !="")
    result = true;
  else if(board[3]==board[4] && board[4]==board[5] && board[5] !="")
    result = true;
  else if(board[6]==board[7] && board[7]==board[8] && board[8] !="")
    result = true;
  else if(board[0]==board[4] && board[4]==board[8] && board[8] !="")
    result = true;
  else if(board[2]==board[4] && board[4]==board[6] && board[6] !="")
    result = true;
  if(result)
    run = false;
    
  return result;
}

void mousePressed(){
  if(run){
    for(int x=0; x<3; x++){
     for(int y=0; y<3; y++){
       if(mouseX > x*width/3 && mouseX < (x+1)*width/3){
         if(mouseY > y*height/3 && mouseY < (y+1)*width/3){
           if(board[x*3+y] ==""){
             if(turn%2==0)
               board[x*3+y] = "X";
             else
               board[x*3+y] = "O";
             if(Win())
               println("winner is player", turn%2+1);
             else
               turn++;
           }
         }
       }
     }
    }
  }
}

void AIturn(){
  float bestScore = 0;
  float bestIndex = -1;
  
  for(int i=0; i<board.length; i++){
    float score =0;
    println((i), (i)/3);
/** 1 2 3
    4 5 6
    7 8 9 **/
    if(i%3==0){
      
    }
    else if(i%3==1){
      if(board[i-1] =="O")
        score++;
      if(board[i+1] =="O")
        score++;
      if(i/3==1){
        if(board[i-4] =="O")
          score++;
        if(board[i+4] =="O")
          score++;
      }
    }
    else if(i%3==2){
      
    }
  }
}
