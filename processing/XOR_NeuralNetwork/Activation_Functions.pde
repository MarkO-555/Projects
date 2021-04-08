private double dSigmoid(double x){
  return sigmoid(x) * (1 - sigmoid(x)); 
}

private double sigmoid(double x) {
  return (double)(1/( 1 + Math.pow(Math.E,(-1*x))));
}

private int bianary(double x){
  double thesh = 0.5;
  if(x>=thesh)
    return 1;
  return 0;
}
private double linear(double x){
  double slope =1;
  double yint =0;
  
  return slope*x+yint;
}

private double relu(double x){
  double thesh =0;
  double lower =0;
  if(x<thesh)
    return lower;
  return x;  
}
