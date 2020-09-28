private float dSigmoid(float x){
  return sigmoid(x) * (1 - sigmoid(x)); 
}

private float sigmoid(float x) {
  return (float)(1/( 1 + Math.pow(Math.E,(-1*x))));
}

private int bianary(float x){
  float thesh = 0.5;
  if(x>=thesh)
    return 1;
  return 0;
}
private float linear(float x){
  float slope =1;
  float yint =0;
  
  return slope*x+yint;
}

private float relu(float x){
  float thesh =0;
  float lower =0;
  if(x<thesh)
    return lower;
  return x;  
}
