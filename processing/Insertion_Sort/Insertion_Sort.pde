float[] sorted;
int sortedCount = 0;

float[] unsorted;
int unsortedCount = width;

void setup() {
  size(600, 500);
  sorted = new float[width];
  unsorted = new float[width];
  for (int i=0; i<unsorted.length; i++) {
    unsorted[i] = random(height);
  }
}

void draw() {
  background(0);
  for (int i=0; i<unsorted.length; i++) {
    stroke(255);
    if (i>sortedCount) {
      line(i, height, i, height-unsorted[i]);
    } 
    else {
      line(i, height, i, height-sorted[i]);
    }
  }
}
