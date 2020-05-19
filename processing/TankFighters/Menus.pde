boolean buttonDown = false;
class MainMenu{
  //private ArrayList<UIButton> buttons;
  int state = -1;
  boolean open = true;
  
  Menu Main = new Menu();
  Menu LevelCreator = new Menu();
  Menu MultiPlayer = new Menu();
  Menu Options = new Menu();
  Menu Tutorial = new Menu();
  
  MainMenu(){ 
    int[] MainText = {165, 160};
    Main.addText("TankFighters", MainText, 70);
    Main.addButton("Play", 100, 300, 600, 100); 
    Main.addButton("Level Creator", 100, 420, 600, 100); 
    Main.addButton("Multiplayer", 100, 540, 600, 100); 
    Main.addButton("Options", 100, 660, 600, 100);
    
    int[] LevelCreatorText = {165, 160};
    LevelCreator.addText("Level Creator", LevelCreatorText, 70);
    for(int x=200; x<width/2+200; x+=it/2){
      for(int y=220; y<height/2+220; y+=it/2){
        LevelCreator.addButton("", x, y, it/2, it/2);
      }
    }
    LevelCreator.addButton("Back", 100, 660, 250, 100);
    LevelCreator.addButton("Save Stage", 100, 660, 250, 100);
    
    int[] MultiPlayerText = {165, 160};
    MultiPlayer.addText("MultiPlayer", MultiPlayerText, 70);
    MultiPlayer.addButton("Back", 100, 660, 600, 100);
    
    int[] optionText = {165, 160};
    Options.addText("Options", optionText, 70); 
    Options.addButton("Back", 100, 660, 600, 100);
    
    int[] TutorialText = {165, 160};
    Tutorial.addText("Tutorial", TutorialText, 70);
    
    int[] exit = {500, 780};
    Tutorial.addText("Mouse Click to Countinue", exit, 20);
  }
  
  void update(){
     if(!open)
       return;
      
     if(state == -1){
       Main.update();
       state = Main.getState();
     }
       
     else if(state == 0){
       Main.setState(-1);
       this.open = false;
       //state = 4;
     }
     else if(state == 1){
       LevelCreator.update();
       for(int i=0; i<blocks.size(); i++){
         Block block = blocks.get(i);
         fill(block.RED, block.GREEN, block.BLUE);
         rect(block.x/2*it+200, block.y/2*it+220, it/2, it/2);
       }
       //println(blocks.size());
           
        //println(LevelCreator.getState());
       float st = LevelCreator.getState();
       if(st != -1){
         if(st == 100){
           state = -1;
         }
         else{
           blocks.add(new Block((int)Math.floor(st/10), (int)(st - Math.floor(st/10)*10), 1, 1, 255, 0, 0, 0));
         }
         
         //state = LevelCreator.getState() + 4 + LevelCreator.buttons.size();
         LevelCreator.setState(-1); 
       }
       
       Main.setState(-1);
     }
     
     else if(state == 2){
       MultiPlayer.update();
       if(MultiPlayer.getState() != -1){
         state = MultiPlayer.getState() + 4 + LevelCreator.buttons.size() + MultiPlayer.buttons.size();
         MultiPlayer.setState(-1);
       }
       Main.setState(-1);
     }
     else if(state == 3){
       Options.update();
       if(Options.getState() != -1){
         state = Options.getState() + 4 + LevelCreator.buttons.size() + MultiPlayer.buttons.size() + Options.buttons.size();
         Options.setState(-1);
       }
       Main.setState(-1);
     }
     else if(state == 4){
       Tutorial.update();
       if(mouseDown && !buttonDown)
         this.open = false;
     }
     else{
       state = -1; 
     }
     
     
     //else if(state == 4){
     //   state = -1;
     //   LevelCreator.setState(-1);
     //}
     //else if(state == 5){
     //   state = -1;
     //   MultiPlayer.setState(-1);
     //}
     //else if(state == 6){
     //   state = -1;
     //   Options.setState(-1);
     //}
     
  }
}

class Menu{
  private ArrayList<UIButton> buttons;
  private int state = -1;
  
  private ArrayList<String> text = new ArrayList<String>();
  private ArrayList<int[]> textpos = new ArrayList<int[]>();
  private ArrayList<Float> fontSize = new ArrayList<Float>();
  
  private ArrayList<PImage> images = new ArrayList<PImage>();
  private float backgroundColor = 150;
  private float RED, GREEN, BLUE;
  
  Menu(){
    buttons = new ArrayList<UIButton>();
  }
  
  void addButton(String text, float x, float y, float w, float h){
    buttons.add(new UIButton(text, x, y, w, h)); 
  }
  
  void addText(String text, int[] pos, float fontSize){
    //text(text, x, y); 
    this.text.add(text);
    this.textpos.add(pos);
    this.fontSize.add(fontSize);
  }
  
  void addImage(String img){
    images.add(loadImage(img));
  }
  
  int getState(){
     return state;
  }
  
  void setState(int nstate){
    state = nstate;
  }
  
  void setBackground(float num){
    backgroundColor = num;
  }
  
  void setBackground(float RED, float GREEN, float BLUE){
    this.RED = RED;
    this.GREEN = GREEN;
    this.BLUE = BLUE;
    
    this.backgroundColor = -1;
  }
  
  void update(){
    if(backgroundColor == -1){
      
    }
    background(backgroundColor);
    
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
    for(int i=0; i<text.size(); i++){
      textSize(fontSize.get(i));
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
