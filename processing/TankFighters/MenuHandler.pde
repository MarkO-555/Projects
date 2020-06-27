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
    
    ArrayList<UIButton> LVbtns = new ArrayList<UIButton>();
    
    int[] LevelCreatorText = {165, 160};
    LevelCreator.addText("Level Creator", LevelCreatorText, 70);
        
    for(int x=xoff; x<width/scale+xoff; x+=it/scale){
      for(int y=yoff; y<height/scale+yoff; y+=it/scale){
        LVbtns.add(new UIButton("", x, y, it/scale, it/scale));
        //LevelCreator.addButton("", x, y, it/scale, it/scale);
      }
    }
    
    LevelCreator.addChooser(0, 0, 0, 0, 0, LVbtns, null);
    
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
    
    LevelCreator.getChooser(0).setState(blockTypes.Block.ordinal());
    LevelCreator.getChooser(0).setClickMode(true);
    
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
    
    
    int[] LoadTitleText = {215, 130};
    LoadMenu.addText("Load Menu", LoadTitleText, 70);
    LoadMenu.addButton("Back", 75, 660, 300, 100);
    LoadMenu.addButton("Load", 425, 660, 300, 100);
    LoadMenu.addButton("Delete", 655, 315, 100, 100);
    
    PImage Next = loadImage("Icons/Next.png");
    PImage Prev = loadImage("Icons/Prev.png");
    
    float LMWidth = 550;
    float LMHeight = 400;
    
    LoadMenu.addButton(Next, 655, 170);
    LoadMenu.addButton(Prev, 655, 70+LMHeight);
    
    
    ArrayList<String> LMBstrs = new ArrayList<String>();
    
    
    int maxButtons = (int)Math.ceil(LMHeight / Constants.loadButtonHeight);
    
    for(int i=0; i<Levels.size(); i++){
      LMBstrs.add(Levels.get(i));
    }
    
    LoadMenu.addChooser(100, 170, LMWidth, LMHeight, Constants.TabBackground, LMBstrs, maxButtons);
    //println(maxButtons);
    //LoadMenu.getChooser(0).setMaxButtonsPerPage(maxButtons);
  }
  
  void update(){
     //println(blocks.size());
      
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
     else if(state == 1){//Level Editor
       LevelCreator.update();
       ButtonChooser editor = LevelCreator.getChooser(0);
       
       for(int i=0; i<blocks.size(); i++){
         Block block = blocks.get(i);
         fill(block.RED, block.GREEN, block.BLUE);
         rect(block.x/2*it+xoff, block.y/2*it+yoff, it/2, it/2);
       }
       
       float st = LevelCreator.getState();
       float sta = editor.getState();
        
       
       boolean pass = true;
       
       for(int i=0; i<blocks.size(); i++){
         if(blocks.get(i).x == (int)Math.floor(sta/10) && blocks.get(i).y == (int)(sta - Math.floor(sta/10)*10))
           pass = false;
       }
       
       if(!buttonDown && pass && mouseDown && mouseButton == LEFT){
         //println("test", sta);
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
         
         blocks.add(new Block((int)Math.floor(sta/10), (int)(sta - Math.floor(sta/10)*10), 1, 1, RED, GREEN, BLUE, LevelCreator.getChooserState(1)));
       }
       else if(mouseDown && mouseButton == RIGHT){
         for(int i=0; i<blocks.size(); i++){
            if(blocks.get(i).x == (int)Math.floor(sta/10) && blocks.get(i).y == (int)(sta - Math.floor(sta/10)*10))
              blocks.remove(i);
         }
       }
         
         //if(mouseDown && buttonDown){
         //  if(mouseButton == LEFT){
         //    float RED, GREEN, BLUE;
         //    if(LevelCreator.getTextBoxValue(0) != "")
         //      RED = Float.parseFloat(LevelCreator.getTextBoxValue(0));
         //    else
         //      RED = 0;
         //    if(LevelCreator.getTextBoxValue(1) != "")
         //      GREEN = Float.parseFloat(LevelCreator.getTextBoxValue(1));
         //    else
         //      GREEN = 0;
         //    if(LevelCreator.getTextBoxValue(2) != "")
         //      BLUE = Float.parseFloat(LevelCreator.getTextBoxValue(2));
         //    else
         //      BLUE = 0;
             
         //    blocks.add(new Block((int)Math.floor(sta/10), (int)(sta - Math.floor(sta/10)*10), 1, 1, RED, GREEN, BLUE, LevelCreator.getChooserState(1)));
             
         //  }
         //  else if(mouseButton == RIGHT){
         //    println("test");
         //    for(int i=0; i<blocks.size(); i++){
         //       if(blocks.get(i).x == (int)Math.floor(sta/10) && blocks.get(i).y == (int)(sta - Math.floor(sta/10)*10))
         //         blocks.remove(i);
         //    }
         //  }
         //}
         
              
       if(st != -1){
         if(st == 0){
           state = -1;
         } 
         else if(st == 1){//Save
           st = -1;
           state = 5;
         }
         else if(st == 2){//Load
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
           String str = SaveMenu.getTextBoxValue(0);
           boolean pass = true;
           
           for(int i=0; i<Levels.size(); i++){
             if(Levels.get(i) == str){
               pass = false;
               break;
             }
           }
           
           if(pass){
             PImage col  = createImage(int(width/it), int(height/it), RGB);
             PImage type  = createImage(int(width/it), int(height/it), RGB);
             
             for(int i=0; i<blocks.size(); i++){
               Block block = blocks.get(i);
               int t = block.getType().ordinal();
               col.set((int)block.x, (int)block.y, color(block.RED, block.GREEN, block.BLUE));
               type.set((int)block.x, (int)block.y, color(t+1, t+1, t+1));
             }
             
             if(str == "")
               str = "default";
               
             col.save("Levels/"+str+"-color.png");
             type.save("Levels/"+str+"-type.png");
             
             Writer.println(str);
             Writer.flush();
             
             Levels.add(str);
             LoadMenu.getChooser(0).addButton(str);             
           }
       }
       if(SaveMenu.getState() != -1){
         state = 1;
         SaveMenu.setState(-1);
       }
     }
     else if(state == 6){//Load Menu
       LoadMenu.update();
       Main.setState(-1);//fix prob
       
       ButtonChooser chooser = LoadMenu.getChooser(0);
         
       if(LoadMenu.getState() == 0){//back
         state = loadBackState;
       }
       else if(LoadMenu.getState() == 1){//Loading in Level!!!!
         LoadMenu.setState(-1);
         
         if(chooser.getButtonCount() > 0){
           blocks = new ArrayList<Block>();
           tanks = new ArrayList<Tank>();
           
           String name = Levels.get(LoadMenu.getChooserState(0));
           
           PImage col = loadImage("Levels/"+name+"-color.png");
           PImage type = loadImage("Levels/"+name+"-type.png");
           
           for(int x=0; x<col.width; x++){
             for(int y=0; y<col.height; y++){
               color Ccol = col.get(x, y); 
               color Ctype = type.get(x, y);
               int t = (int)red(Ctype) - 1;
               
               if(t != -1){
                 blocks.add(new Block(x, y, 1, 1, red(Ccol), green(Ccol), blue(Ccol), t));
               if(t == blockTypes.Player.ordinal() || t == blockTypes.Enemy.ordinal())
                 tanks.add(new Tank(t == blockTypes.Player.ordinal(), new PVector(x*it+it/2, y*it+it/2), red(Ccol), green(Ccol), blue(Ccol))); 
               }
             }
           }
           
           //debug
           state = loadTargetState;
         }
       }
       else if(LoadMenu.getState() == 2){//delete
         LoadMenu.setState(-1);
         
         if(chooser.getButtonCount() > 0){
           try{
             Writer = createWriter("Levels/Levels.txt");
             
             int index = chooser.getState();         
             String name = chooser.getButton(index).getText();
             
             chooser.removeButton(index);
             
             sketchFile(sketchPath(name+"-color.png")).delete();
             sketchFile(sketchPath(name+"-type.png")).delete();
             Levels.remove(index);
             
             for(int i=0; i<Levels.size(); i++)
               Writer.println(Levels.get(i));
             Writer.flush();
           }
           catch(Exception ext){
             println("There is an error while deleting:",ext);
           }
           
           chooser.Rebuild();
         }
         
         //chooser.setState(0);
       }
       else if(LoadMenu.getState() == 3){//Prev
         chooser.prevPage();
         LoadMenu.setState(-1);
       }
       else if(LoadMenu.getState() == 4){//Next
         chooser.nextPage();
         LoadMenu.setState(-1);
       }
       
       if(LoadMenu.getState() == 1 || LoadMenu.getState() == 0)
         LoadMenu.setState(-1);
     }
     else{
       state = -1; 
     }
  }
}
