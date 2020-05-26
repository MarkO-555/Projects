float mill, sec;
int i=0;

void TestTime() {
  if (i==1) {
    mill = 0;
    sec = 0;
  }

  mill = millis() - mill;
  sec = second() - sec;
  i++;
}
