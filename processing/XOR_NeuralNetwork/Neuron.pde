class Neuron {
  private ArrayList<Double> weights = new ArrayList<Double>();
  private ArrayList<Double> errors = new ArrayList<Double>();
  private ArrayList<Neuron> dendrites = new ArrayList<Neuron>();
  private double axonValue, nonProcessed;

  private double error;
  private double axonDerivative;

  private double xPos = 0;
  private double yPos = 0;
  //private double bias = 0.0001;

  void process() {
    axonValue = 0;
    for (int i=0; i<dendrites.size(); i++)
      axonValue += dendrites.get(i).axonValue * weights.get(i);

    nonProcessed = axonValue;
    axonValue = sigmoid(axonValue);
    //axonValue = relu(axonValue);
    //axonValue = bianary(axonValue);
    //axonDerivative = axonValue * (1-axonValue);
    
  }

  double getDerivitive() {
    return axonDerivative;
  }

  void setX(double xPos) {
    this.xPos = xPos;
  }
  void setY(double yPos) {
    this.yPos = yPos;
  }

  double getX() {
    return xPos;
  }

  double getY() {
    return yPos;
  }

  void setError(double error) {
    this.error = error;
  }

  void addError(double error) {
    errors.add(error);
  }

  void processErrors() {
    this.error = 0;
    for (int i=0; i<this.errors.size(); i++) {
      this.error += this.errors.get(i);
    }
    this.error /= errors.size();
    errors = new ArrayList<Double>();
  }

  double getWeight(int index) {
    //println(xPos, yPos);
    return weights.get(index);
  }

  int weightlen() {
    return weights.size();
  }

  double getError() {
    return this.error;
  }

  void setWeights(ArrayList<Double> weights) {
    this.weights = weights;

    for (int i=0; i<weights.size(); i++) {
      //this.weights.set(i, constrain((float)this.weights.get(i), -1000000000, 1000000000));

      double maxnum = 100000000;
      //double maxnum = 10000;
      

      if (this.weights.get(i) >= maxnum) {
        this.weights.set(i, maxnum);
      } else if (this.weights.get(i) <= -maxnum) {
        this.weights.set(i, -maxnum);
      }

      //this.weights.set(i, this.weights.get(i));//unconstrained!!!
    }
  }

  void setDendrite(int index, Neuron n) {
    if (dendrites.size() != 0)
      dendrites.set(index, n);
  }

  void clearWeights() {
    this.weights = new ArrayList<Double>();
  }

  double getAxon() {
    return axonValue;
  }

  double getNonProcessedAxon() {
    return nonProcessed;
  }

  void addDendrite(Neuron neuron, double weight) {
    dendrites.add(neuron);
    weights.add(weight);
  }
}
