boolean buttonDown = false;
class MainMenu{
  //private ArrayList<UIButton> buttons;
  int state = -1;
  boolean open = true;
  Menu Main = new Menu();
  Menu LevelCreator = new Menu();
  Menu MultiPlayer = new Menu();
  Menu Options = new Menu();
  
  MainMenu(){ 
    int[] MainText = {165, 160};
    Main.addText("TankFighters", MainText);
    Main.addButton("Play", 100, 300, 600, 100); 
    Main.addButton("Level Creator", 100, 420, 600, 100); 
    Main.addButton("Multiplayer", 100, 540, 600, 100); 
    Main.addButton("Options", 100, 660, 600, 100);
    
    int[] LevelCreatorText = {165, 160};
    LevelCreator.addText("Level Creator", LevelCreatorText);
    LevelCreator.addButton("Back", 100, 660, 600, 100);
    
    int[] MultiPlayerText = {165, 160};
    MultiPlayer.addText("MultiPlayer", MultiPlayerText);
    MultiPlayer.addButton("Back", 100, 660, 600, 100);
    
    int[] optionText = {165, 160};
    Options.addText("Options", optionText); 
    Options.addButton("Back", 100, 660, 600, 100);
  }
  
  void update(){
     if(!open)
       return;
      println(state);
      
     if(state == -1){
       Main.update();
       state = Main.getState();
     }
       
     else if(state == 0){
       this.open = false;
       Main.setState(-1);
       state = Main.getState();
     }
     else if(state == 1){
       LevelCreator.update();
       if(LevelCreator.getState() != -1)
         state = LevelCreator.getState() + 3+LevelCreator.buttons.size();
       Main.setState(-1);
     }
     else if(state == 2){
       MultiPlayer.update();
       if(MultiPlayer.getState() != -1)
         state = MultiPlayer.getState() + 3+LevelCreator.buttons.size()+MultiPlayer.buttons.size();
       Main.setState(-1);
     }
     else if(state == 3){
       Options.update();
       if(Options.getState() != -1)
         state = Options.getState() + 3+LevelCreator.buttons.size()+MultiPlayer.buttons.size()+Options.buttons.size();
       Main.setState(-1);
     }
     
     
     else if(state == 4){
        state = -1;
        LevelCreator.setState(-1);
     }
     else if(state == 5){
        state = -1;
        MultiPlayer.setState(-1);
     }
     else if(state == 6){
        state = -1;
        Options.setState(-1);
     }
     
  }
}

class Menu{
  private ArrayList<UIButton> buttons;
  private int state = -1;
  
  ArrayList<String> text = new ArrayList<String>();
  ArrayList<int[]> textpos = new ArrayList<int[]>();
  
  Menu(){
    buttons = new ArrayList<UIButton>();
  }
  
  void addButton(String text, float x, float y, float w, float h){
    buttons.add(new UIButton(text, x, y, w, h)); 
  }
  
  void addText(String text, int[] pos){
    //text(text, x, y); 
    this.text.add(text);
    this.textpos.add(pos);
  }
  
  int getState(){
     return state;
  }
  
  void setState(int nstate){
    state = nstate;
  }
  
  void update(){
    background(150);
    
    display();
    for(int i=0; i<buttons.size(); i++){
      if(buttons.get(i).Hover()){
        buttons.get(i).background  = 190;
        if(mouseDown && !buttonDown){
          state = i;
          buttonDown = true;
        }
        
      }
      else
        buttons.get(i).background  = 220;
    }
  }
  
  void display(){
    fill(0);
    textSize(70);
    for(int i=0; i<text.size(); i++){
      int[] pos = textpos.get(i);
      text(text.get(i), pos[0], pos[1]);
    }
    
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
   
   boolean Hover(){
     return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
   }
}
