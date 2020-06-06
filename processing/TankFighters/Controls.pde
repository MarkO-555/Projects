boolean mouseDown, openMenu, keyDown;
boolean left, right, up, down, ring;
boolean buttonDown = false;
boolean menuWasUp = true;

void mousePressed() {
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false; 
  buttonDown = false;
}

void keyPressed() {
  keyDown = true;
  if (key=='a') {
    left = true;
    right = false;
  }
  if (key=='d') {
    right = true;
    left = false;
  }
  if (key=='w') {
    up = true;
    down = false;
  }
  if (key=='s') {
    down = true;
    up = false;
  }
  if (key=='q')
    ring = true;
  //if(key=='z'){
  //  mainMenu.open = true;
  //  mainMenu.state = -1;
  //  menuWasUp = true;
  //}
}

void keyReleased() {
  keyDown = false;
  if (key=='a')
    left = false;
  if (key=='d')
    right = false;
  if (key=='w')
    up = false;
  if (key=='s')
    down = false;
  if (key=='q')
    ring = false;
}
