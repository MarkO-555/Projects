class Command {
  String input = "resume";
  String output = "";
  int id;
  
  Command(int id_){
   id = id_; 
  }
  
  void update(){
    try{
      if(input.substring(0, 5).equals("debug")){
        if(input.substring(6, 9).equals("ray")){
          if(input.substring(14,17).equals("all")){
            ray = p.rays[int(input.substring(10,12))];
            println(int(input.substring(10,12)));
            console.output[id] = ray.p1.toString()+" p2:"+ray.p2.toString()+" p3:"+ray.p3.toString()+" p4:"+ray.p4.toString()+" pt:"+ray.pt.toString()+" den:"+ray.den+" t:"+ray.t+" u:"+ray.u;
          }
        }
      }
      else if(input.substring(0, 6).equals("resume")){
        println("test");
        console.output[id] = "Click Me to pause and resume";
        uiClickable[uiCount] = new PVector(50, 10*id);
        uiClickable[uiCount+1] = new PVector(width-100, 10*id+10);
        uiCount+=2;
      }
    }
    catch(Throwable error){
      output = error.toString();
      //println(error);
    }
  }
}


class Console {
  float currenth = 0;
  float h = 0;
  
  float min = 0;
  public float max = 200;
  boolean open = false;
  
  String commandLine = "";
  
  String[] output = new String[37];
  Command[] c = new Command[37];
  
  int count =0;
  
  public void show() {
    for(int i=0; i<c.length; i++){
      c[i] = new Command(i);
      c[i].update();
    }
    
    if(open){
      cursor(ARROW);
      
      fill(100, 150);
      rect(0, 0, width, height);
      
      fill(255);
      for(int i=0; i<height-40; i+=10){
       text(output[i/10], 50, i+15);
      }
      rect(50, height-30, width-100, 20);
      
      fill(0);
      text(commandLine, 53, height-15);
    }
    else{     
      noCursor(); 
    }
  }
  
  public void run(String command_){
    
    c[count].input = command_;
    
    
    commandLine = "";
    count++;
  }
  
  public void toggle() {
    if(open)
      open = false;
    else
      open = true;
  }
}
