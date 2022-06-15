void populateVars(){
  bytes = loadBytes(loc);
  chars = new String[bytes.length];
  hexs = new String[bytes.length];
  
  for(int i=0; i<bytes.length; i++){
    hexs[i] = Integer.toHexString(bytes[i]);
    
    if(hexs[i].length() > 2)
      hexs[i] = hexs[i].substring(hexs[i].length()-3, hexs[i].length()-1);
    else if(hexs[i].length() == 1)
      hexs[i] += "0";
  }
  
  for(int i=0; i<chars.length; i++){
    if(hexs[i].substring(0, 1).equals("0"))
      chars[i] = ".";
    else
      chars[i] = ""+(char)Integer.parseInt(hexs[i], 16);
  }
  println("finished populating");
  
  interprit();
}

void interprit(){
  lines = new ArrayList<String>();
  String line = "";
  
  //for(int i=0; i<chars.length; i++){
  //  for(int j=0; j<db.length; j++){
  //    if(i+db[j].length() <= chars.length){//will fit
  //      boolean pass = false;
  //      for(int k=0; k<db[j].length(); k++){
  //        pass = false;
  //        if(db[j].charAt(k) == chars[i+k].charAt(0))
  //          pass = true;
  //      }
  //      if(pass){
  //        lines.add(line);
  //        line = "";
  //        //line = db[j];
          
  //        //i+=db[j].length();
  //        i++;
  //        //break;
  //      }
  //    }
  //  }
  //  line+=chars[i];
  //}
  
  for(int i=0; i<10; i++){
    for(int j=0; j<db.length; j++){
      String str1 = "";
      String str2 = "";
      if(i+db[j].length() < chars.length){
        
        for(int k=i; k<i+db[j].length(); k++){
          
          str1+= chars[k];
          str2+=db[j].charAt(k-i);
          //println(chars[k].charAt(0), db[j].charAt(k-i), chars[k].charAt(0) == db[j].charAt(k-i));
          
          //pass = false;
          //if(chars[k].charAt(0) == db[j].charAt(k-i)){
          //  pass = true;
          //}
        }
      }
      if(str1.equals(str2)){
        lines.add(line);
        i+=db[j].length();
        
        line = db[j];
        break;
      }
    }
    
    line+=chars[i];
    //println(line);
    
    if(i+1 == 5)
      lines.add(line);
  }
  
  
  println("finished interpriting");
}
