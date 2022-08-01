PrintWriter output;

ArrayList<String> Hex;
ArrayList<Character> Chars;
ArrayList<opCode> Codes;

class opCode{
  String[] Hex;
  String Code = "";
  
  opCode(String Code, String a, String b, String c, String d){
    String[] Hex = {a, b, c, d};
    
    this.Code = Code;
    this.Hex = Hex;
  }
}


void start(){
  Codes = new ArrayList<opCode>();
  
  OpCodeInit();
  
  byte b[] = loadBytes("elf"); 
  
  Hex = new ArrayList<String>();
  Chars = new ArrayList<Character>();
  
  output = createWriter("decompiled");
  int Correct = 0;
  String  Charline = "";
  String   HexLine = "";
  String CodesLine = "";
  String  ParmLine = "";
  String[] Parms = new String[2];
  int HeaderLength = 256;
  
  for(int i=0; i<b.length; i++){
    Correct = 0;
    if(i==HeaderLength){
      output.println("========================");
      output.println("End of Header");
    }
      
    Hex.add(hex(b[i]));
    Chars.add((char)Integer.parseInt(Hex.get(i), 16));
    
    for(int j=0; j<Codes.size(); j++){
      if(i%4 ==3){
        Correct++;
        if(      Codes.get(j).Hex[0].equals(Hex.get(i-3)) || Codes.get(j).Hex[0].equals("XX") || Codes.get(j).Hex[0].equals("?1") || Codes.get(j).Hex[0].equals("?0")){
          if(    Codes.get(j).Hex[1].equals(Hex.get(i-2)) || Codes.get(j).Hex[1].equals("XX") || Codes.get(j).Hex[1].equals("?1") || Codes.get(j).Hex[1].equals("?0")){
            if(  Codes.get(j).Hex[2].equals(Hex.get(i-1)) || Codes.get(j).Hex[2].equals("XX") || Codes.get(j).Hex[2].equals("?1") || Codes.get(j).Hex[2].equals("?0")){
              if(Codes.get(j).Hex[3].equals(Hex.get(i-0)) || Codes.get(j).Hex[3].equals("XX") || Codes.get(j).Hex[3].equals("?1") || Codes.get(j).Hex[3].equals("?0")){
                ArrayList<String> str = new ArrayList<String>();
                
                if(Codes.get(j).Hex[0] == "?0")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "?0")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "?0")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "?0")
                  str.add(Hex.get(i-0));
                  
                if(Codes.get(j).Hex[0] == "?1")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "?1")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "?1")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "?1")
                  str.add(Hex.get(i-0));
                //if(str.size() > 0)
                //  if(str.get(0).equals("00"))
                //    str.remove(0);
                if(str.size() > 0)
                  ParmLine += "#";
                  
                for(var k =0; k<str.size(); k++){
                  ParmLine += str.get(k);
                }
                  
                CodesLine += Codes.get(j).Code;
              }
            }
          }
        }
      }
    }
    
    HexLine += Hex.get(i)+" ";
    Charline += Chars.get(i);
    
    if(i%4==3){
      output.println(floor(i/4)+" || "+HexLine+"|| "+CodesLine+" "+ParmLine);//+Charline);
      CodesLine = "";
      Charline  = "";
      HexLine   = "";
      ParmLine  = "";
    }
  }
  
  println("Done");
}

void OpCodeInit(){
  Codes.add(new opCode(".ELF"  , "7F", "45", "4C", "46"));
  Codes.add(new opCode("nop"   , "00", "00", "00", "00"));
  Codes.add(new opCode("jr"    , "08", "00", "E0", "03"));
  
  Codes.add(new opCode("addiu" , "?1", "?0", "65", "26"));
  Codes.add(new opCode("addiu" , "?1", "?0", "31", "26"));
  
  
  Codes.add(new opCode("addiu" , "?1", "?0", "C6", "24"));
  Codes.add(new opCode("addiu" , "?1", "?0", "E7", "24"));
  Codes.add(new opCode("addiu" , "?1", "?0", "84", "24"));
  Codes.add(new opCode("addiu" , "?1", "?0", "63", "24"));
  Codes.add(new opCode("_addiu", "?1", "?0", "A5", "24"));
  Codes.add(new opCode("_addiu", "?1", "?0", "A5", "27"));
  Codes.add(new opCode("_addiu", "?1", "?0", "A4", "27"));
  Codes.add(new opCode("_addiu", "?1", "?0", "BD", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "AB", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "AC", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "AE", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "AD", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "A9", "27"));
  Codes.add(new opCode("addiu" , "?1", "?0", "AA", "27"));
  
  Codes.add(new opCode("addiu" , "?1", "XX", "42", "24"));//Missing Parameter Subtraction Sometimes!!!
  
  
  
  Codes.add(new opCode("lui" , "?1", "?0", "XX", "3C"));
  
  
}

void draw(){
  
}
