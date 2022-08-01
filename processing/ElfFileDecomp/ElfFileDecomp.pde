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
  String neg = "";
  
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
        if(      Codes.get(j).Hex[0].equals(Hex.get(i-3)) || Codes.get(j).Hex[0].equals("XX") || Codes.get(j).Hex[0].equals("?1") || Codes.get(j).Hex[0].equals("?0") || Codes.get(j).Hex[0].equals("-?0") || Codes.get(j).Hex[0].equals("-?0x2")){
          if(    Codes.get(j).Hex[1].equals(Hex.get(i-2)) || Codes.get(j).Hex[1].equals("XX") || Codes.get(j).Hex[1].equals("?1") || Codes.get(j).Hex[1].equals("?0") || Codes.get(j).Hex[1].equals("-?0") || Codes.get(j).Hex[1].equals("-?0x2")){
            if(  Codes.get(j).Hex[2].equals(Hex.get(i-1)) || Codes.get(j).Hex[2].equals("XX") || Codes.get(j).Hex[2].equals("?1") || Codes.get(j).Hex[2].equals("?0") || Codes.get(j).Hex[2].equals("-?0") || Codes.get(j).Hex[2].equals("-?0x2")){
              if(Codes.get(j).Hex[3].equals(Hex.get(i-0)) || Codes.get(j).Hex[3].equals("XX") || Codes.get(j).Hex[3].equals("?1") || Codes.get(j).Hex[3].equals("?0") || Codes.get(j).Hex[3].equals("-?0") || Codes.get(j).Hex[3].equals("-?0x2")){
                ArrayList<String> str = new ArrayList<String>();
                
                if(Codes.get(j).Hex[0] == "?0")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "?0")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "?0")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "?0")
                  str.add(Hex.get(i-0));
                  
                if(Codes.get(j).Hex[0] == "-?0")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "-?0")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "-?0")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "-?0")
                  str.add(Hex.get(i-0));
                  
                if(Codes.get(j).Hex[0] == "-?0x2")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "-?0x1")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "-?0x1")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "-?0x1")
                  str.add(Hex.get(i-0));
                  
                  
                if(str.size() > 0 && (Codes.get(j).Hex[0] == "-?0" || Codes.get(j).Hex[1] == "-?0" || Codes.get(j).Hex[2] == "-?0" || Codes.get(j).Hex[3] == "-?0")){
                  if(binary(unhex(str.get(0)), 8).substring(0, 1).equals("1")){
                    if(!hex(-unhex(str.get(0))-255-2, 2).equals("00"))
                      str.set(0, "-"+hex(-unhex(str.get(0))-255-2, 2));
                    else
                      str.set(0, "00");
                  }
                }
                  
                if(Codes.get(j).Hex[0] == "?1")
                  str.add(Hex.get(i-3));
                else if(Codes.get(j).Hex[1] == "?1")
                  str.add(Hex.get(i-2));
                else if(Codes.get(j).Hex[2] == "?1")
                  str.add(Hex.get(i-1));
                else if(Codes.get(j).Hex[3] == "?1")
                  str.add(Hex.get(i-0));
                if(str.size() > 0){
                  if(str.get(0).equals("00"))
                    str.remove(0);
                  else if(str.get(0).substring(0, 1).equals("0"))
                    str.set(0, str.get(0).substring(1));
                    
                  if(str.size() > 0)
                    ParmLine += neg+"0x";
                }
                  
                  
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
  
  Codes.add(new opCode("j"     , "XX", "XX", "04", "08"));// Missing Parameters
  
  Codes.add(new opCode("Clear" , "28", "XX", "00", "70"));// Missing Parameters
  Codes.add(new opCode("Clear" , "11", "XX", "00", "00"));// Missing Parameters
  Codes.add(new opCode("Clear" , "11", "XX", "00", "70"));// Missing Parameters
  Codes.add(new opCode("Clear" , "13", "XX", "00", "00"));// Missing Parameters
  Codes.add(new opCode("Clear" , "13", "XX", "00", "70"));// Missing Parameters
  
  Codes.add(new opCode("Clear" , "00", "XX", "19", "04"));// Missing Parameters
  Codes.add(new opCode("Clear" , "00", "XX", "80", "44"));// Missing Parameters
  
  //Codes.add(new opCode("addiu" , "?1", "-?0", "E7", "24"));
  Codes.add(new opCode("addiu" , "?1", "-?0", "42", "24"));//Missing Parameter Subtraction Sometimes!!!
  
  
  Codes.add(new opCode("ori"   , "00", "XX", "84", "34"));// Missing Parameters
  Codes.add(new opCode("and"   , "XX", "XX", "64", "00"));// Missing Parameters
  Codes.add(new opCode("andi"  , "XX", "XX", "44", "30"));// Missing Parameters
  
  
  Codes.add(new opCode("sb"  , "XX", "XX", "40", "A0"));// Missing Parameters
  Codes.add(new opCode("sw"  , "XX", "XX", "B2", "AF"));// Missing Parameters
  
  Codes.add(new opCode("beq" , "XX", "XX", "43", "10"));// Missing Parameters
  
  
  Codes.add(new opCode("syscall", "0C", "00", "00", "00"));// Missing Parameters
  Codes.add(new opCode("_move"  , "XX", "XX", "40", "00"));// Missing Parameters
  
  Codes.add(new opCode("lui" , "?1", "?0", "XX", "3C"));
  Codes.add(new opCode("li" , "?1", "?0", "03", "24"));
  
  
  
}

void draw(){
  
}
