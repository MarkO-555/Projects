String loc = "c:/Users/redst/Desktop/OPTIMUS.VBIN";
byte[] bytes;
String[] chars;
String[] hexs;

ArrayList<String> lines;

PrintWriter output;

void setup(){
  output = createWriter("c:/Users/redst/Desktop/output.txt");
  
  populateVars();
  
  for(int i=0; i<lines.size(); i++){
    output.println(lines.get(i)); 
  }
  output.flush();
  output.close();
  println("finished Saving");
}
