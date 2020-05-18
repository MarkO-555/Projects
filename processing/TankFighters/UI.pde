ArrayList<UIButton> buttons;

class MainMenu{
  boolean open = true;
  
  MainMenu(){
    buttons = new ArrayList<UIButton>();
    buttons.add(new UIButton("Play", 100, 300, 600, 100)); 
    buttons.add(new UIButton("Level Creator", 100, 420, 600, 100)); 
    buttons.add(new UIButton("Multiplayer", 100, 540, 600, 100)); 
    buttons.add(new UIButton("Options", 100, 660, 600, 100)); 
  }
  
  void update(){
    if(!open)
      return;
    background(150);
    
    for(int i=0; i<buttons.size(); i++){
      if(buttons.get(i).Clicked()){
        buttons.get(i).background  = 190;
        if(mouseDown){
          if(i==0)
            open = false;
        }
      }
      else
        buttons.get(i).background  = 220;
    }
      
      
    display();
  }
  
  void display(){
    fill(0);
    for(int i=0; i<buttons.size(); i++)
      buttons.get(i).display();
  }
}

class UIButton{
  float x, y, w, h;
  String text;
  
  float background = 220;
   UIButton(String text, float x, float y, float w, float h){
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.text = text;
   }
   
   void display(){
     
     fill(background);
     rect(x, y, w, h); 
     
     fill(0);
     textSize(20);
     text(text, x+30, y+h/2+10);
   }
   
   boolean Clicked(){
     return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
   }
}
