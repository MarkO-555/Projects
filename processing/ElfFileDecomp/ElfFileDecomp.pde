String bins[];
String hexs[];
String funs[];
String invbins[];
PrintWriter output;

class opCode{
  String name; 
  String identity;
  String invidentity;
  int index;
  int length = 0;
  
  opCode(String name, String identity, int index){
    this.name = name;
    this.identity = identity;
    this.length = identity.length();
    this.index = index;
    
    for(int v=0; v<this.length; v++){
      this.invidentity += this.identity.charAt(this.length-(v+1));
    }
  }
  
  boolean equals(opCode opCode){  
    return (this.identity.equals(opCode.identity) && (this.index == opCode.index));
  }
  
  boolean equals(String identity, int index){
    return (this.invidentity.equals(identity) && this.index == index);
  }
  
}

opCode[] codes = {
   new opCode("ADD",     "100000", 00),
   new opCode("ADDI",    "------", -1),//BinaryCode wher!?!??!
   new opCode("ADDIU",   "001001", 26),
   new opCode("ADDU",    "100001", 00),
   new opCode("AND",     "100100", 00),
   new opCode("ANDI",    "001100", 26),
   new opCode("BEQ",     "000100", 26),
   new opCode("BEQL",    "010100", 26),
   new opCode("BGEZ",    "00001",  16),
   new opCode("BGEZAL",  "10001",  16),
   new opCode("BGEZALL", "10011",  16),
   new opCode("BGEZL",   "00011",  16),
   new opCode("BGTZ",    "000111", 26),
   new opCode("BGTZL",   "010111", 26),
   new opCode("BLEZ",    "000110", 26),
   new opCode("BLEZL",   "010110", 26),
   new opCode("BLTZ",    "00000",  16),
   new opCode("BLTZAL",  "10000",  16),
   new opCode("BLTZALL", "10010",  16),
   new opCode("BLTZL",   "00010",  16),
   new opCode("BNE",     "000101", 26),
   new opCode("BNEL",    "010101", 26),
   new opCode("Break",   "001101", 00),
   new opCode("DADD",    "101100", 00),
   new opCode("DADDI",   "011000", 26),
   new opCode("DADDIU",  "011001", 26),
   new opCode("DADDU",   "101101", 00),
   new opCode("DIV",     "011010", 00),
   new opCode("DIVU",    "011011", 00),
   new opCode("DSLL",    "111000", 00),
   new opCode("DSLL32",  "111100", 00),
   new opCode("DSLLV",   "010100", 00),
   new opCode("DSRA",    "111011", 00),
   new opCode("DSRA32",  "111111", 00),
   new opCode("DSRAV",   "010111", 00),
   new opCode("DSRL",    "111010", 00),
   new opCode("DSRL32",  "111110", 00),
   new opCode("DSRLV",   "010110", 00),
   new opCode("DSUB",    "101110", 00),
   new opCode("DSUBU",   "101111", 00),
   new opCode("J",       "000010", 26),
   new opCode("JAL",     "000011", 26),
   new opCode("JALR",    "001001", 00),
   new opCode("JR",      "001000", 00),
   new opCode("LB",      "100000", 26),
   new opCode("LBU",     "100100", 26),
   new opCode("LD",      "110111", 26),
   new opCode("LDL",     "011010", 26),
   new opCode("LDR",     "011011", 26),
   new opCode("LH",      "100001", 26),
   new opCode("LHU",     "100101", 26),
   new opCode("LUI",     "001111", 26),
   new opCode("LW",      "100011", 26),
   new opCode("LWL",     "100010", 26),
   new opCode("LWR",     "100110", 26),
   new opCode("LWU",     "100111", 26),
   new opCode("MGHI",    "010000", 00),
   new opCode("MFLO",    "010010", 00),
   new opCode("MOVN",    "001011", 00),
   new opCode("MOVZ",    "001010", 00),
   new opCode("MTHI",    "010001", 00),
   new opCode("MTLO",    "010011", 00),
   new opCode("MULT",    "011000", 00),
   new opCode("MULTU",   "011001", 00),
   new opCode("NOR",     "100111", 00),
   new opCode("OR",      "100101", 00),
   new opCode("ORI",     "001101", 26),
   new opCode("PREF",    "110011", 26),
   new opCode("SB",      "101000", 26),
   new opCode("SD",      "111111", 26),
   new opCode("SDL",     "101100", 26),
   new opCode("SDR",     "101101", 26),
   new opCode("SH",      "101001", 26),
   new opCode("SLL",     "000000", 00),
   new opCode("SLLV",    "000100", 00),
   new opCode("SLT",     "101010", 00),
   new opCode("SLTI",    "001010", 26),
   new opCode("SLTIU",   "001011", 26),
   new opCode("SLTU",    "101011", 00),
   new opCode("SRA",     "000011", 00),
   new opCode("SRAV",    "000111", 00),
   new opCode("SRL",     "000010", 00),
   new opCode("SRLV",    "000110", 00),
   new opCode("SUB",     "100010", 00),
   new opCode("SUBU",    "100011", 00),
   new opCode("SW",      "101011", 26),
   new opCode("SWL",     "101010", 26),
   new opCode("SWR",     "101110", 26),
   new opCode("SYNC",    "001111", 00),
   new opCode("SYSCALL", "001100", 00),
   new opCode("TEQ",     "110100", 00),
   new opCode("TEQI",    "01100",  16),
   new opCode("TGE",     "110000", 00),
   new opCode("TGEI",    "01000",  16),
   new opCode("TGEIU",   "01001",  16),
   new opCode("TGEU",    "110001", 00),
   new opCode("TLT",     "110010", 00),
   new opCode("TLTI",    "01010",  16),
   new opCode("TLTIU",   "01011",  16),
   new opCode("TLTU",    "110011", 00),
   new opCode("TNE",     "110110", 00),
   new opCode("TNEI",    "01110",  16),
   new opCode("XOR",     "100110", 00),
   new opCode("XORI",    "001110", 26),
   
   //EE Core-Specific Instruction Set
   new opCode("DIV1",   "011010", 00),
   new opCode("DIVU1",  "011011", 00),
   new opCode("LQ",     "011110", 26),
   new opCode("MADD",   "000000", 00),
   new opCode("MADD1",  "100000", 00),
   new opCode("MADDU",  "000001", 00),
   new opCode("MADDU1", "100001", 00),
   new opCode("MFHI1",  "010000", 00),
   new opCode("MFLO1",  "010010", 00),
   new opCode("MFSA",   "101000", 00),
   new opCode("MTHI1",  "010001", 00),
   new opCode("MTLO1",  "010001", 00),
   new opCode("MTSA",   "101001", 00),
   new opCode("MTSAB",  "11000",  16),
   new opCode("MTSAH",  "11001",  16),
   new opCode("MULT",   "011000", 00),
   new opCode("MULT1",  "011000", 00),
   new opCode("MULTU",  "011001", 00),
   new opCode("MULTU1", "011001", 00),
   new opCode("PABSH",  "00101",  06),
   new opCode("PABSW",  "0001",   06),
   new opCode("PADDB",  "01000",  06),
   new opCode("PADDH",  "00100",  06),
   new opCode("PADDSB", "11000",  06),
   new opCode("PADDSH", "10100",  06),
   new opCode("PADDSW", "10000",  06),
   new opCode("PADDUB", "11000",  06),
   new opCode("PADDUH", "10100",  06),
   new opCode("PADDUW", "10000",  06),
   new opCode("PADDW",  "00000",  06),
   new opCode("", "", 00)
   
   //new opCode("", "", 00)
 };

int translate(String[] binary){
  
  return -1;
}

void start(){
  byte b[] = loadBytes("elf");
  bins = new String[b.length];
  invbins = new String[b.length];
  hexs = new String[b.length];
  funs = new String[b.length];
  
  output = createWriter("file.ignore");
  String hexline = "";
  String strline = "";
  String invbinsline = "";
  for(int i=0; i<b.length; i++){
     hexs[i] = hex(b[i]);
     bins[i] = binary(b[i]);
     invbins[i] = "";
     
     for(int v=0; v<bins[i].length(); v++){
       invbins[i] += bins[i].charAt(7-v);
     }
     
     
     hexline += hexs[i]+" ";
     strline += bins[i]+" ";
     invbinsline+=invbins[i]+" ";
     invbins[i]="";
     
     
    if(i%4==3){
      output.println(hexline+"|| "+strline+" || "+invbinsline);
      hexline = "";
      strline = "";
      invbinsline="";
    }
  }
  
  for(int i=0; i<bins.length/4; i++){
    int result = translate(bins);
    if(result == -1)
      funs[i] = "";
     else
       funs[i] = codes[result].name;
  }
    
  output.flush();
  
  println("Done!!!");
}

void draw(){
  
}
