//PrintWriter output;
//ArrayList<opCode> Codes;

//class opCode{
//  String name;
//  String bin;
//  block[] blocks;
  
//  opCode(String name, String bin, block[] blocks, String eq){
//    this.name   = name;
//    this.blocks = blocks;
//  }
//}
//class block{
//  String name;
//  int start;
//  int stop;
  
//  block(String name, int start, int stop){
//     this.name  = name;
//     this.start = start;
//     this.stop  = stop;
//  }
//}

//void start(){
//  Codes = new ArrayList<opCode>();
  
//  println("Done");
//}

//void OpCodeInit(){
//  //Codes.add(new opCode("", ""));
//  //block b0, b1, b2, b3, b4, b5;
  
//  block[] blocks = new block[6];
  
//  blocks = new block[4];  
//  blocks[0] = new block("Immediate", 0, 15);
//  blocks[1] = new block("rt",       16, 20);
//  blocks[2] = new block("rs",       21, 25);
//  blocks[3] = new block("Special",  26, 31);
//  Codes.add(new opCode("ADDI", "??", blocks, "rt=rs+imm"));//Identifier??
  
//  blocks[3].name = "Name";
//  Codes.add(new opCode("ADDIU", "001001", blocks, "rt=rs+imm"));
  
//  blocks = new block[6];
//  blocks[0] = new block("Name",    0,   5);
//  blocks[1] = new block("0" ,      6,  10);
//  blocks[2] = new block("rd",      11, 15);
//  blocks[3] = new block("rt",      16, 20);
//  blocks[4] = new block("rs",      21, 25);
//  blocks[5] = new block("Special", 26, 31);
  
//  Codes.add(new opCode("DADD", "101100", blocks, "rd=rs+rt"));
//  Codes.add(new opCode("ADD",  "100000", blocks, "rd=rs+rt"));
//  Codes.add(new opCode("ADDU", "100001", blocks, "rd=rs+rt"));
//  Codes.add(new opCode("AND",  "100100", blocks, "rd=rs&rt"));
  
//  blocks = new block[4];
//  blocks[0] = new block("Immediate", 0, 15);
//  blocks[1] = new block("rt",       16, 20);
//  blocks[2] = new block("rs",       21, 25);
//  blocks[3] = new block("Name",     26, 31);
//  Codes.add(new opCode("ANDI", "001100", blocks, "rt=rs&imm"));
  
//  blocks[0].name = "offset";
//  Codes.add(new opCode("BEQ",  "000100", blocks, "rs==rt@b"));
//  Codes.add(new opCode("BEQL", "010100", blocks, "rs==rt@b"));
  
  
//  blocks[1].name = "Name";
//  blocks[3].name = "REGIMM";
//  Codes.add(new opCode("BGEZ",    "00001", blocks, "rs>=0@b"));
//  Codes.add(new opCode("BGEZAL",  "10001", blocks, "rs>=0@p"));
//  Codes.add(new opCode("BGEZALL", "10011", blocks, "rs>=0@p"));
//  Codes.add(new opCode("BGQZL",   "00011", blocks, "rs>=0@p"));
  
//  blocks[0] = new block("offset", 0, 15);
//  blocks[1] = new block("0",     16, 20);
//  blocks[2] = new block("rs",    21, 25);
//  blocks[3] = new block("Name",  26, 31);
  
//  Codes.add(new opCode("GBTZ",  "000111", blocks, "rs>0@b"));
//  Codes.add(new opCode("GBTZL", "010111", blocks, "rs>0@b"));
//  Codes.add(new opCode("BLEZ",  "000110", blocks, "rs<=0@b"));
//  Codes.add(new opCode("BGTZL", "010111", blocks, "rs>0@b"));
//  Codes.add(new opCode("BLEZ",  "000110", blocks, "rs<=0@b"));
  
//  Codes.add(new opCode("BLEZL", "010110", blocks, "rs<=0@"));//Work on algorithm
  
//  blocks[1].name = "Name";
//  blocks[3].name = "REGIMM";
//  Codes.add(new opCode("BLTZ",    "00000",  blocks, "rs<0@b"));
//  Codes.add(new opCode("BLTZAL",  "10000",  blocks, "rs<0@p"));
//  Codes.add(new opCode("BLTZALL", "10010",  blocks, "rs<0@p"));
//  Codes.add(new opCode("BLTZL",   "00010",  blocks, "rs<0@b"));
  
//  blocks[1].name = "rt";
//  blocks[2].name = "rs";
//  blocks[3].name = "Name";
//  Codes.add(new opCode("BNE",     "000101", blocks, "rs!=rt@b"));
//  Codes.add(new opCode("BNEL",    "010101", blocks, "rs!=rt@b"));
  
//  blocks = new block[3];
//  blocks[0] = new block("Name",     0,  5);
//  blocks[1] = new block("code",     6, 25);
//  blocks[2] = new block("Special", 26, 31);
//  Codes.add(new opCode("BREAK",   "001101", blocks, "break"));
  
//  blocks = new block[4];
//  blocks[0] = new block("Immediate", 0, 15);
//  blocks[1] = new block("rt",       16, 20);
//  blocks[2] = new block("ts",       21, 25);
//  blocks[3] = new block("Name",     26, 31);
//  Codes.add(new opCode("DADDI",   "011000", blocks, "rt=rs+imm"));
//  Codes.add(new opCode("DADDIU",  "011001", blocks, "rt=rs+imm"));
//  Codes.add(new opCode("DADDU",   "101101", blocks, "rd=rs+rt"));
  
//  blocks = new block[5];
//  blocks[0] = new block("Name",     0,  5);
//  blocks[0] = new block("0",        6, 15);
//  blocks[0] = new block("rt",      16, 20);
//  blocks[0] = new block("rs",      21, 25);
//  blocks[0] = new block("Special", 26, 31);
//  Codes.add(new opCode("DIV", "011010", blocks, "LH=rs/rt"));
//  Codes.add(new opCode("DIVU","011011", blocks, "LH=rs/rt"));
  
//  blocks = new block[6];
//  blocks[0] = new block("Name",       0,  5);
//  blocks[1] = new block("sa",         6, 10);
//  blocks[2] = new block("rd",        11, 15);
//  blocks[3] = new block("rt",        16, 20);
//  blocks[4] = new block("0",         21, 25);
//  blocks[5] = new block("Special",   26, 31);
  
//  Codes.add(new opCode("DSLL",   "111000", blocks, "rd=rt<<sa"));
//  Codes.add(new opCode("DSLL32", "111000", blocks, "rd=rt<<sa+32"));//32
//  Codes.add(new opCode("DSRA",   "111000", blocks, "rd=rt>>sa"));
//  Codes.add(new opCode("DSRA32", "111111", blocks, "rd=rt>>sa+32"));
//  Codes.add(new opCode("DSRAV",  "010111", blocks, "rd=rt>>rs"));
//  Codes.add(new opCode("DSRL",   "111010", blocks, "rd=rt>>sa"));
//  Codes.add(new opCode("DSRL32", "111110", blocks, "rd=rt>>sa+32"));
  
//  blocks[1].name = "0";
//  blocks[2].name = "rd";
//  blocks[3].name = "rt";
//  blocks[4].name = "rs";
//  blocks[5].name = "Special";
//  Codes.add(new opCode("DSRLV",  "010110", blocks, "rd=rt>>rs"));
//  Codes.add(new opCode("DSUB",   "101110", blocks, "rd=rs-rt"));
//  Codes.add(new opCode("DSUBU",  "101111", blocks, "rd=rs-rt"));
//  Codes.add(new opCode("DSLLV", "010100", blocks, "rd=rt<<rs"));
  
//  blocks[3].name = "0";
//  Codes.add(new opCode("JALR",   "001001", blocks, "rd=Return=rs"));//Working
  
//  blocks = new block[2];
//  blocks[0] = new block("offset", 0, 25);
//  blocks[1] = new block("Name",   0, 25);
//  Codes.add(new opCode("J", "000010", blocks, "T"));
  
//  blocks[0].name = "inst_index";
//  Codes.add(new opCode("JAL", "000011", blocks, "T"));
  
//  blocks = new block[4];
//  blocks[0] = new block("Name",     0,  5);
//  blocks[1] = new block("0",        6, 20);
//  blocks[2] = new block("rs",      21, 25);
//  blocks[1] = new block("Special", 26, 31);
//  Codes.add(new opCode("JR", "001000", blocks, "`rs"));
  
//  blocks[0] = new block("offset",   0, 15);
//  blocks[1] = new block("rt",      16, 20);
//  blocks[2] = new block("base",    21, 25);
//  blocks[3] = new block("Name",    26, 31);
//  Codes.add(new opCode("LB",  "100000", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LBU", "100100", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LD",  "100100", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LBU", "011010", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LDR", "011011", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LH",  "100001", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LHU", "100101", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LUI", "001111", blocks, "rt=immediate"));
//  Codes.add(new opCode("LW",  "100011", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LWL", "100010", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LWR", "100110", blocks, "rt=mem[base+offset]"));
//  Codes.add(new opCode("LWU", "100111", blocks, "rt=mem[base+offset]"));
  
//  blocks[0] = new block("Name",     0,  5);
//  blocks[1] = new block("0",        6, 10);
//  blocks[2] = new block("rd",      11, 15);
//  blocks[3] = new block("0",       16, 25);
//  blocks[4] = new block("Special", 26, 31);
//  Codes.add(new opCode("MFHI", "010000", blocks, "rd=HI"));
  
//  //Codes.add(new opCode("", "", blocks, ""));
//}

//void draw(){
  
//}

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
    
    for(int v=0; v<length; v++){
      this.invidentity += this.identity.charAt(7-v);
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
  
  output = createWriter("file");
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
