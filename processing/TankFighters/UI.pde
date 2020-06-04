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
  
  private ArrayList<ButtonChooser> Choosers = new ArrayList<ButtonChooser>();
  
  //private float backgroundColor = 165;
  //private float RED, GREEN, BLUE;
  private color col = color(165);
  
  void addChooser(float x, float y, float w, float h, float background, ArrayList<UIButton> buttons){
    Choosers.add(new ButtonChooser(x, y, w, h, background));
    for(int i=0; i<buttons.size(); i++)
      Choosers.get(Choosers.size()-1).addButton(buttons.get(i));
  }
  
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
  
  int getChooserState(int index){
    return Choosers.get(index).getState();
  }
  
  void setTextboxType(int index, boolean type){
    textboxs.get(index).numOnly = type;
  }
  
  void setState(int nstate){
    state = nstate;
  }
  
  void setBackground(float num){
    //backgroundColor = num;
    this.col = color(num);
  }
  
  void setBackground(float RED, float GREEN, float BLUE){
    //this.RED = RED;
    //this.GREEN = GREEN;
    //this.BLUE = BLUE;
    
    this.col = color(RED, GREEN, BLUE);
    
    //this.backgroundColor = -1;
  }
  
  void update(){
    //if(backgroundColor == -1){}
    background(this.col);
    
    display();
    
    for(int i=0; i<buttons.size(); i++){
      if(buttons.get(i).Hover()){
        buttons.get(i).background  = Constants.ButtonPressed;// 190;
        if(mouseDown && !buttonDown){
          state = i;
          buttonDown = true;
        }
        
      }
      else
        buttons.get(i).background  = Constants.ButtonReleased; //220;
    }
    
    for(int i=0; i<textboxs.size(); i++)
      textboxs.get(i).update();
    for(int i=0; i<buttons.size(); i++)
      buttons.get(i).update();
    for(int i=0; i<Choosers.size(); i++)
      Choosers.get(i).update();
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

class UIButton implements UIObject{
  float x, y, w, h;
  String text;
  PImage img = null;
  
  float background = 220;
  
   UIButton(String text, float x, float y, float w, float h){
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     this.text = text;
   }
   
   UIButton(PImage img, float x, float y){
    this.img = img;
    this.x = x;
    this.y = y;
    this.w = img.width;
    this.h = img.height;
    this.text = null;
   }
   
   void update(){
     display(); 
   }
   
   void display(){
     fill(background);
     rect(x, y, w, h); 
     
     fill(0);
     textSize(20);
     if(text != null)
       text(text, x+30, y+h/2+10);
     else
       image(img, x, y);
   }
   
   boolean Hover(){
     return(mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
   }
}

class UITextbox implements UIObject{
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
      background = Constants.TextActive; //220;
    else
      background = Constants.TextInactive; //255;
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

class UIScrollTab implements UIObject{
  private float x, y, w, h;
  
  UIScrollTab(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void update(){
    
  }
}

class ButtonChooser implements UIObject{
  private float x, y, w, h;
  private ArrayList<UIButton> buttons;
  private int state = 0;
  private float background = 150;
  
  ButtonChooser(float x, float y, float w, float h, float background){
    this.buttons = new ArrayList<UIButton>();
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.background = background;
  }
  
  int getState(){
    return this.state;
  }
  
  void setBackground(float background){
    this.background = background; 
  }
  
  void addButton(String str, float x, float y, float w, float h){
    this.buttons.add(new UIButton(str, x, y, w, h));
  }
  
  void addButton(UIButton button){
    this.buttons.add(button); 
  }
  
  void update(){
    Draw();
    
    if(buttons.size() > 0){
      for(int i=0; i<buttons.size(); i++){
        UIButton btn = buttons.get(i);
        btn.update();
        
        if(this.buttons.get(i).Hover() && mouseDown && !buttonDown){
          state = i;
        }
        //buttons.get(state).background = Constants.ButtonPressed;//190;
      }
      
      UIButton btn = buttons.get(state);
      fill(Constants.ButtonPressed, 170);
      rect(btn.x, btn.y, btn.w, btn.h);
    }
  }
  
  void Draw(){
    fill(background);
    rect(x, y, w, h);
  }
}
