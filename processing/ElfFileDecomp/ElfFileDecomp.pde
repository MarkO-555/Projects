PrintWriter output;
ArrayList<opCode> Codes;

class opCode{
  String name;
  String bin;
  block[] blocks;
  
  opCode(String name, String bin, block[] blocks, String eq){
    this.name   = name;
    this.blocks = blocks;
  }
}
class block{
  String name;
  int start;
  int stop;
  
  block(String name, int start, int stop){
     this.name  = name;
     this.start = start;
     this.stop  = stop;
  }
}

void start(){
  Codes = new ArrayList<opCode>();
  
  println("Done");
}

void OpCodeInit(){
  //Codes.add(new opCode("", ""));
  //block b0, b1, b2, b3, b4, b5;
  block[] blocks = new block[6];
  
  blocks[0] = new block("Name"   , 0,  5);
  blocks[1] = new block("0"      , 6,  10);
  blocks[2] = new block("rd"     , 11, 15);
  blocks[3] = new block("rt"     , 16, 20);
  blocks[4] = new block("rs"     , 21, 25);
  blocks[5] = new block("Special", 26, 31);
  
  Codes.add(new opCode("ADD", "100000", blocks, "rd=rs+rt"));
  
  blocks = new block[4];  
  blocks[0] = new block("Immediate", 0, 15);
  blocks[1] = new block("rt"       , 16, 20);
  blocks[2] = new block("rs"       , 21, 25);
  blocks[3] = new block("Special"  , 26, 31);
  Codes.add(new opCode("ADDI", "??", blocks, "rt=rs+imm"));//Identifier??
  
  blocks[3].name = "Name";
  Codes.add(new opCode("ADDIU", "001001", blocks, "rt=rs+imm"));
  
  blocks = new block[6];
  blocks[0] = new block("Name", 0, 5);
  blocks[1] = new block("0" , 6, 10);
  blocks[2] = new block("rd", 11, 15);
  blocks[3] = new block("rt", 16, 20);
  blocks[4] = new block("rs", 21, 25);
  blocks[5] = new block("Special", 26, 31);
  
  Codes.add(new opCode("ADDU", "100001", blocks, "rd=rs+rt"));
  Codes.add(new opCode("AND", "100100", blocks, "rd=rs&rt"));
  
  blocks = new block[4];
  blocks[0] = new block("Immediate", 0, 15);
  blocks[1] = new block("rt", 16, 20);
  blocks[2] = new block("rs", 21, 25);
  blocks[3] = new block("Name", 26, 31);
  Codes.add(new opCode("ANDI", "001100", blocks, "rt=rs&imm"));
  
  blocks[0].name = "offset";
  Codes.add(new opCode("BEQ",  "000100", blocks, "rs==rt@b"));
  Codes.add(new opCode("BEQL", "010100", blocks, "rs==rt@b"));
  
  
  blocks[1].name = "Name";
  blocks[3].name = "REGIMM";
  Codes.add(new opCode("BGEZ",    "00001", blocks, "rs>=0@b"));
  Codes.add(new opCode("BGEZAL",  "10001", blocks, "rs>=0@p"));
  Codes.add(new opCode("BGEZALL", "10011", blocks, "rs>=0@p"));
  Codes.add(new opCode("BGQZL",   "00011", blocks, "rs>=0@p"));
  
  blocks[0] = new block("offset", 0, 15);
  blocks[1] = new block("0",     16, 20);
  blocks[2] = new block("rs",    21, 25);
  blocks[3] = new block("Name",  26, 31);
  
  Codes.add(new opCode("GBTZ",  "000111", blocks, "rs>0@b"));
  Codes.add(new opCode("GBTZL", "010111", blocks, "rs>0@b"));
  Codes.add(new opCode("BLEZ",  "000110", blocks, "rs<=0@b"));
  Codes.add(new opCode("BGTZL", "010111", blocks, "rs>0@b"));
  Codes.add(new opCode("BLEZ",  "000110", blocks, "rs<=0@b"));
  
  Codes.add(new opCode("BLEZL", "010110", blocks, "rs<=0@"));//Work on algorithm
  
  blocks[1].name = "Name";
  blocks[3].name = "REGIMM";
  Codes.add(new opCode("BLTZ",    "00000",  blocks, "rs<0@b"));
  Codes.add(new opCode("BLTZAL",  "10000",  blocks, "rs<0@p"));
  Codes.add(new opCode("BLTZALL", "10010",  blocks, "rs<0@p"));
  Codes.add(new opCode("BLTZL",   "00010",  blocks, "rs<0@b"));
  
  blocks[1].name = "rt";
  blocks[2].name = "rs";
  blocks[3].name = "Name";
  Codes.add(new opCode("BNE",     "000101", blocks, "rs!=rt@b"));
  Codes.add(new opCode("BNEL",    "010101", blocks, "rs!=rt@b"));
  
  blocks = new block[3];
  blocks[0] = new block("Name",     0, 5);
  blocks[1] = new block("code",     6, 25);
  blocks[2] = new block("Special", 26, 31);
  Codes.add(new opCode("BREAK",   "001101", blocks, "break"));
  
  blocks = new block[5];
  blocks[0] = new block("Name",     0, 5);
  blocks[1] = new block("0",        6, 10);
  blocks[1] = new block("rd",      11, 15);
  blocks[1] = new block("rt",      16, 20);
  blocks[1] = new block("rs",      21, 25);
  blocks[1] = new block("Special", 26, 31);
  Codes.add(new opCode("DADD",    "101100", blocks, "rd=rs+rt"));
  
  blocks = new block[4];
  blocks[0] = new block("Immediate", 0, 15);
  blocks[1] = new block("rt",       16, 20);
  blocks[2] = new block("ts",       21, 25);
  blocks[3] = new block("Name",     26, 31);
  Codes.add(new opCode("DADDI",   "011000", blocks, "rt=rs+imm"));
  Codes.add(new opCode("DADDIU",  "011001", blocks, "rt=rs+imm"));
  Codes.add(new opCode("DADDU",   "101101", blocks, "rd=rs+rt"));
  
  blocks = new block[5];
  blocks[0] = new block("Name",     0,  5);
  blocks[0] = new block("0",        6, 15);
  blocks[0] = new block("rt",      16, 20);
  blocks[0] = new block("rs",      21, 25);
  blocks[0] = new block("Special", 26, 31);
  Codes.add(new opCode("DIV", "011010", blocks, "LH=rs/rt"));
  
  
  
  //Codes.add(new opCode("", "", blocks, ""));
}

void draw(){
  
}
