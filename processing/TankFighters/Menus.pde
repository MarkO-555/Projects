boolean buttonDown = false;
class MainMenu{
  //private ArrayList<UIButton> buttons;
  int state = -1;
  boolean open = true;
  
  private int xoff = 375;
  private int yoff = 220;
  private float scale = 2;
  
  Menu Main = new Menu();
  Menu LevelCreator = new Menu();
  Menu MultiPlayer = new Menu();
  
  Menu Options = new Menu();
  Menu PlayMenu = new Menu();
  
  Menu SaveMenu = new Menu();
  Menu LoadMenu = new Menu();
  
  MainMenu(){
    int[] MainText = {165, 160};
    Main.addText("TankFighters", MainText, 70);
    Main.addButton("Play", 100, 300, 600, 100); 
    Main.addButton("Level Creator", 100, 420, 600, 100); 
    Main.addButton("Multiplayer", 100, 540, 600, 100); 
    Main.addButton("Options", 100, 660, 600, 100);
    
    int[] LevelCreatorText = {165, 160};
    LevelCreator.addText("Level Creator", LevelCreatorText, 70);
    
    
    for(int x=xoff; x<width/scale+xoff; x+=it/scale){
      for(int y=yoff; y<height/scale+yoff; y+=it/scale){
        LevelCreator.addButton("", x, y, it/scale, it/scale);
      }
    }
    
    LevelCreator.addButton("Back", 660, 660, 100, 100);
    LevelCreator.addButton("Save Stage", 40, 660, 250, 45);
    LevelCreator.addButton("Load Stage", 40, 660+55, 250, 45);
    
    int tSize = 20;
    int x = 125;
    int xdif = 80;
    
    int[] Colorpos = {x+50, yoff+30};
    int[] redpos = {x-xdif, yoff+80};
    int[] greenpos = {x-xdif, yoff+140};
    int[] bluepos = {x-xdif, yoff+200};
    
    LevelCreator.addRect(25, yoff, 325, 240, 200);
    
    LevelCreator.addText("Color", Colorpos, tSize);
    LevelCreator.addText("Red", redpos, tSize);
    LevelCreator.addText("Green", greenpos, tSize);
    LevelCreator.addText("Blue", bluepos, tSize);
    
    LevelCreator.addTextbox("150", x, yoff+50, 200, 50);
    LevelCreator.addTextbox("150", x, yoff+110, 200, 50);
    LevelCreator.addTextbox("150", x, yoff+170, 200, 50);
    
    LevelCreator.setTextboxType(0, true);
    LevelCreator.setTextboxType(1, true);
    LevelCreator.setTextboxType(2, true);
    
    int[] MultiPlayerText = {165, 160};
    MultiPlayer.addText("MultiPlayer", MultiPlayerText, 70);
    MultiPlayer.addButton("Back", 100, 660, 600, 100);
    
    int[] optionText = {165, 160};
    Options.addText("Options", optionText, 70); 
    Options.addButton("Back", 100, 660, 600, 100);
    
    int[] PlayText = {165, 160};
    PlayMenu.addText("Tutorial", PlayText, 70);
    
    int[] SaveTitleText = {165, 160};
    SaveMenu.addText("Save Menu", SaveTitleText, 70);
    SaveMenu.addButton("Back", 425, 660, 300, 100);
    SaveMenu.addButton("Save", 75, 660, 300, 100);
    
    int[] SaveName = {120, 452};
    SaveMenu.addText("Save Name", SaveName, 20);
    SaveMenu.addTextbox("", 250, 420, 400, 50);
    
    
    int[] LoadTitleText = {165, 160};
    LoadMenu.addText("Load Menu", LoadTitleText, 70);
    LoadMenu.addButton("Back", 100, 660, 600, 100);
    
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
         rect(block.x/2*it+xoff, block.y/2*it+yoff, it/2, it/2);
       }
       
       float st = LevelCreator.getState();
       if(st != -1){
         if(st == 100){
           state = -1;
         } 
         else if(st <= 100){
           if(mouseButton == LEFT){
             float RED, GREEN, BLUE;
             if(LevelCreator.getTextBoxValue(0) != "")
               RED = Float.parseFloat(LevelCreator.getTextBoxValue(0));
             else
               RED = 0;
             if(LevelCreator.getTextBoxValue(1) != "")
               GREEN = Float.parseFloat(LevelCreator.getTextBoxValue(1));
             else
               GREEN = 0;
             if(LevelCreator.getTextBoxValue(2) != "")
               BLUE = Float.parseFloat(LevelCreator.getTextBoxValue(2));
             else
               BLUE = 0;
             
             blocks.add(new Block((int)Math.floor(st/10), (int)(st - Math.floor(st/10)*10), 1, 1, RED, GREEN, BLUE, 0));
           }
           else if(mouseButton == RIGHT){
             for(int i=0; i<blocks.size(); i++){
                if(blocks.get(i).x == (int)Math.floor(st/10) && blocks.get(i).y == (int)(st - Math.floor(st/10)*10))
                  blocks.remove(i);
             }
           }
           LevelCreator.setState(-1);
         }
         else if(st == 101){//Save
           st = -1;
           state = 5;
         }
         else if(st == 102){//Load
           st = -1;
           state = 6;
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
       PlayMenu.update();
       if(mouseDown && !buttonDown)
         this.open = false;
     }
     else if(state == 5){//Save
       SaveMenu.update();
       if(SaveMenu.getState() == 2){
           PImage img = createImage(int(width/it), int(height/it), RGB);
           for(int i=0; i<blocks.size(); i++){
             Block block = blocks.get(i);
             
             img.set((int)block.x, (int)block.y, color(block.RED, block.GREEN, block.BLUE));
           }
           
           String str = SaveMenu.getTextBoxValue(0);
           if(str == "")
             str = "default";
             
           img.save(String.format("Levels/{0}.png", str));
       }
       if(SaveMenu.getState() != -1){
         state = 1;
         SaveMenu.setState(-1);
       }
     }
     else if(state == 6){//Load
       LoadMenu.update();
       if(LoadMenu.getState() != -1){
         state = 1;
         LoadMenu.setState(-1);
       }
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
  private int state = -1;
  
  private ArrayList<String> text = new ArrayList<String>();
  private ArrayList<int[]> textpos = new ArrayList<int[]>();
  private ArrayList<Float> fontSize = new ArrayList<Float>();
  
  private ArrayList<PVector> rectPos = new ArrayList<PVector>();
  private ArrayList<PVector> rectSize = new ArrayList<PVector>();
  private ArrayList<Float> rectColor = new ArrayList<Float>();
  
  private ArrayList<PImage> images = new ArrayList<PImage>();
  private ArrayList<PVector> imagePos = new ArrayList<PVector>();
  
  private ArrayList<UIButton> buttons = new ArrayList<UIButton>();
  private ArrayList<UITextbox> textboxs = new ArrayList<UITextbox>();
  
  private float backgroundColor = 165;
  private float RED, GREEN, BLUE;
  
  void addButton(String text, float x, float y, float w, float h){
    buttons.add(new UIButton(text, x, y, w, h)); 
  }
  
  void addRect(float x, float y, float w, float h, float Color){
    rectPos.add(new PVector(x, y));
    rectSize.add(new PVector(w, h));
    rectColor.add(Color);
  }
  
  void addText(String text, int[] pos, float fontSize){
    //text(text, x, y); 
    this.text.add(text);
    this.textpos.add(pos);
    this.fontSize.add(fontSize);
  }
  
  void addTextbox(String defaultValue, float x, float y, float w, float h){
     textboxs.add(new UITextbox(defaultValue, x, y, w, h));
  }
  
  void addImage(String img, PVector imagePos){
    this.images.add(loadImage(img));
    this.imagePos.add(imagePos);
  }
  
  String getTextBoxValue(int index){
    return textboxs.get(index).text;
  }
  
  int getState(){
     return state;
  }
  
  void setTextboxType(int index, boolean type){
    textboxs.get(index).numOnly = type;
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
    //if(backgroundColor == -1){}
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
    
    for(int i=0; i<textboxs.size(); i++)
      textboxs.get(i).update();
    for(int i=0; i<buttons.size(); i++)
      buttons.get(i).update();
      
  }
  
  void display(){
    //fill(0);
    
    for(int i=0; i<rectPos.size(); i++){
      fill(rectColor.get(i));
      rect(rectPos.get(i).x, rectPos.get(i).y, rectSize.get(i).x, rectSize.get(i).y);
    }
    
    for(int i=0; i<text.size(); i++){
      fill(0);
      textSize(fontSize.get(i));
      int[] pos = textpos.get(i);
      text(text.get(i), pos[0], pos[1]);
    }
    
    for(int i=0; i<images.size(); i++){
      image(images.get(i), imagePos.get(i).x, imagePos.get(i).y);
    }
    
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
   
   void update(){
     display(); 
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

class UITextbox{
  float x, y, w, h;
  String text = "";
  
  private int textlength;
  private boolean change = false;
  private boolean numOnly = false;
  private float background;
  private String defaultValue;
  
  UITextbox(String defaultValue, float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
    textlength = (int)(w * 19/200);
    if(defaultValue.length() > textlength)
      this.defaultValue = defaultValue.substring(0, defaultValue.length() - (defaultValue.length() - textlength));
    else
      this.defaultValue = defaultValue;
      
    text = this.defaultValue;
  }
  
  void update(){
    display();
    
    if(mouseDown){
      change = Hover();
    }
    else if(change && keyDown){
      if(key == ''){
        if(text.length() <= 1)
          text = "";
        else
          text = text.substring(0, text.length() -1);
        keyDown = false;
      }
      else if(keyCode ==16 || keyCode==17 || keyCode==UP || keyCode==LEFT || keyCode==RIGHT || keyCode==DOWN){}
      else if(text.length() < textlength){
        char c = key;
        if(numOnly){
          for(int i=0; i<10; i++){
            //println(c, i, str(c).equals(str(i)));
            if(str(c).equals(str(i))){
              text += c;
              keyDown = false;
            }
          }
        }
        else{
          text += c; 
          keyDown = false;
        }
      }
    }
    
    if(change)
      background = 220;
    else
      background = 255;
  }
  
  void display(){
    fill(background);
    rect(x, y, w, h);
    
    textSize(15);
    fill(0);
    text(text, x + 10, y + h/2+5);
    //println(19, w, text.length());
  }
  
  boolean Hover(){
     return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
  }
}
