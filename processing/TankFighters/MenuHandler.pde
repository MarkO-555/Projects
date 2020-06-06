boolean buttonDown = false;
class MainMenu{
  //private ArrayList<UIButton> buttons;
  int state = -1;
  //int state = 6;
  int loadTargetState, loadBackState;
  boolean open = true;
  PrintWriter Writer;
  
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
    Writer = createWriter("Levels/Levels.txt");
    
    for(int i=0; i<Levels.size(); i++)
      Writer.println(Levels.get(i));
    Writer.flush();
    
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
    
    LevelCreator.addRect(25, yoff, 325, 240, Constants.TabBackground);
    
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
    
    ArrayList<UIButton> btns = new ArrayList<UIButton>();
    
    float Lcx = 30;
    float Lcy = 470;
    float Loff = 5;
    
    btns.add(new UIButton(loadImage("Icons/Player.png"), Lcx+Loff, Lcy+Loff));
    btns.add(new UIButton(loadImage("Icons/Enemy.png"), Lcx+30+Loff, Lcy+Loff));
    btns.add(new UIButton(loadImage("Icons/Block.png"), Lcx+60+Loff, Lcy+Loff));
    
    LevelCreator.addChooserB(Lcx, Lcy, 100, 100, Constants.TabBackground, btns);
    
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
    SaveMenu.addButton("Back", 75, 660, 300, 100);
    SaveMenu.addButton("Save", 425, 660, 300, 100);
    
    int[] SaveName = {120, 452};
    SaveMenu.addText("Save Name", SaveName, 20);
    SaveMenu.addTextbox("", 250, 420, 400, 50);
    
    
    int[] LoadTitleText = {165, 160};
    LoadMenu.addText("Load Menu", LoadTitleText, 70);
    LoadMenu.addButton("Back", 75, 660, 300, 100);
    LoadMenu.addButton("Load", 425, 660, 300, 100);
    
    //ArrayList<UIButton> LMBtns = new ArrayList<UIButton>();
    //ArrayList<Integer> LMBpages = new ArrayList<Integer>();
    ArrayList<String> LMBstrs = new ArrayList<String>();
    
    float LMWidth = 600;
    float LMHeight = 400;
    
    float LMcx = 100;
    float LMcy = 170;
    
    int maxButtons = (int)Math.ceil(LMHeight / Constants.loadButtonHeight);
    //println(maxButtons, Constants.loadButtonHeight, LMHeight);
    
    for(int i=0; i<Levels.size(); i++){
      //LMBtns.add(new UIButton(Levels.get(i), LMcx, LMcy+i*Constants.loadButtonHeight, Constants.loadButtonWidth, Constants.loadButtonHeight));
      //LMBpages.add(0);
      //LMBpages.add((int)Math.ceil(i/maxButtons));
      LMBstrs.add(Levels.get(i));
    }
    
    LoadMenu.addChooser(LMcx, LMcy, LMWidth, LMHeight, Constants.TabBackground, LMBstrs);//, LMBtns, LMBpages);
    LoadMenu.getChooser(0).setMaxButtonsPerPage(maxButtons);
  }
  
  void update(){
     if(!open)
       return;
     if(state == -2){
       this.open = false;
       Main.setState(-1);
     }
     else if(state == -1){
       Main.update();
       state = Main.getState();
     }
     else if(state == 0){
       loadBackState = -1;
       loadTargetState = -2;
       state = 6;
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
               
             blocks.add(new Block((int)Math.floor(st/10), (int)(st - Math.floor(st/10)*10), 1, 1, RED, GREEN, BLUE, LevelCreator.getChooserState(0)));
             
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
           loadBackState = 1;
           loadTargetState = 1;
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
     else if(state == 5){//Save Menu
       SaveMenu.update();
       if(SaveMenu.getState() == 1){
           PImage col  = createImage(int(width/it), int(height/it), RGB);
           PImage type  = createImage(int(width/it), int(height/it), RGB);
           
           //println("Size",blocks.size());
           for(int i=0; i<blocks.size(); i++){
             Block block = blocks.get(i);
             //println((int)block.x, (int)block.y);
             col.set((int)block.x, (int)block.y, color(block.RED, block.GREEN, block.BLUE));
             int t = block.getType();
             type.set((int)block.x, (int)block.y, color(t+1, t+1, t+1));
           }
           
           String str = SaveMenu.getTextBoxValue(0);
           if(str == "")
             str = "default";
             
           col.save("Levels/"+str+"-color.png");
           type.save("Levels/"+str+"-type.png");
           
           Writer.println(str);
           Writer.flush();
           
           Levels.add(str);
           LoadMenu.getChooser(0).addButton(str);  //bookmark
       }
       if(SaveMenu.getState() != -1){
         state = 1;
         SaveMenu.setState(-1);
       }
     }
     else if(state == 6){//Load Menu
       LoadMenu.update();
       Main.setState(-1);
       
       if(LoadMenu.getState() == 0){
         state = loadBackState;
       }
       else if(LoadMenu.getState() == 1){//Loading in Level!!!!
         
         blocks = new ArrayList<Block>();
         tanks = new ArrayList<Tank>();
         
         String name = Levels.get(LoadMenu.getChooserState(0));
         
         PImage col = loadImage("Levels/"+name+"-color.png");
         PImage type = loadImage("Levels/"+name+"-type.png");
         
         //image(col, 0, 0);
         //noLoop();
         //println(col.width, col.height);
         
         for(int x=0; x<col.width; x++){
           for(int y=0; y<col.height; y++){
             color Ccol = col.get(x, y); 
             color Ctype = type.get(x, y);
             
             if(red(Ctype) != 0){
               blocks.add(new Block(x, y, 1, 1, red(Ccol), green(Ccol), blue(Ccol), (int)red(Ctype)-1));
               
               //println(red(Ctype), blocks.get(blocks.size()-1).type);
               //println(red(Ctype), 0, 1);
               
               if(red(Ctype) == 1 || red(Ctype)==2)
                 tanks.add(new Tank(red(Ctype) == 1, new PVector(x*it+it/2, y*it+it/2), red(Ccol), green(Ccol), blue(Ccol))); 
               
               //if(red(Ctype)==1)
               //  tanks.add(new Tank(true, new PVector(x*it+it/2, y*it+it/2), red(Ccol), green(Ccol), blue(Ccol))); 
               //else if(red(Ctype)==2)
               //  tanks.add(new Tank(false, new PVector(x*it+it/2, y*it+it/2), red(Ccol), green(Ccol), blue(Ccol))); 
             }
           }
         }
         
         state = loadTargetState;
         
       }
       
       if(LoadMenu.getState() != -1)
         LoadMenu.setState(-1);
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
