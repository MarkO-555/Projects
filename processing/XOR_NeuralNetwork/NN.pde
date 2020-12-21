class NeuralNetwork {
  private float Weightrange = 10;

  private Neuron[] Neurons;

  private int[] Inputs;
  private int[][] Hiddens;
  private int[] Outputs;

  private float[] weights;
  private int[] weightsmap;
  private int[] weightsHXmap;
  private int[] weightsHYmap;

  private float learningrate = 0.1;

  NeuralNetwork(int Input, int HiddenX, int HiddenY, int Output, boolean loading) {
    Inputs = new int[Input];
    Hiddens = new int[HiddenX][HiddenY];
    Outputs = new int[Output];
    Neurons = new Neuron[Input+HiddenX*HiddenY+Output];

    int weightCount = 0;
    if (HiddenX>0)
      weightCount = Input*HiddenY + (HiddenX - 1)*HiddenY*HiddenY + HiddenY*Output;
    else
      weightCount = Input*HiddenY+HiddenY*Output;

    weights = new float[weightCount];
    weightsmap = new int[weightCount];
    weightsHXmap = new int[weightCount - Input*HiddenY - HiddenY*Output];
    weightsHYmap = new int[weightCount - Input*HiddenY - HiddenY*Output];

    initWeights(loading);

    int y = 0;
    int Count = 0;

    for (int i=0; i<Input; i++) {
      Inputs[i] = y;
      Neurons[y] = new Neuron();
      y++;
    }

    for (int i=0; i<HiddenX; i++) {
      for (int v=0; v<HiddenY; v++) {
        Hiddens[i][v] = y;
        Neurons[y] = new Neuron();

        if (i==0) {
          for (int j=0; j<Input; j++) {
            Neurons[y].addDendrite(new Neuron(), weights[Count]);
            Count++;
          }
        } else {
          for (int j=0; j<HiddenY; j++) {
            Neurons[y].addDendrite(Neurons[Hiddens[i-1][j]], weights[Count]);
            Count++;
          }
          Count -= HiddenY;
        }
        y++;
      }
    }


    for (int i=0; i<Output; i++) {
      Outputs[i] = y;
      Neurons[y] = new Neuron();

      for (int j=0; j<HiddenY; j++) {
        Neurons[y].addDendrite(Neurons[Hiddens[HiddenX-1][j]], weights[Count]);
        Count++;
      }

      y++;
    }
  }

  private void initWeights(boolean loading) {
    int count =0;
    int xcount =0;
    int ycount =0;

    if (loading)
      weights = loadWeights(weights.length);
    else {
      for (int i=0; i<weights.length; i++) {
        weights[i] = 1;
        //weights[i] = random(-Weightrange, Weightrange);

        if (i<=Inputs.length * Hiddens[0].length-1)//IH
          weightsmap[i] = 0;
        else if (i<=Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length, 2)-1) {//HH
          weightsmap[i] = 1;

          if (ycount >= Hiddens[0].length) {
            xcount++;
            ycount=0;
          }

          weightsHXmap[count]=xcount;
          weightsHYmap[count]=ycount;
          ycount++;
          count++;
        } else if (i<=Inputs.length * Hiddens[0].length + (Hiddens.length-1) * Math.pow(Hiddens[0].length, 2) + Hiddens[0].length*Outputs.length-1)//HO
          weightsmap[i] = 2;
      }
    }
  }

  public float[] feedForward(float[] Inputs) {
    int len = this.Inputs.length;

    if (len != Inputs.length) {
      println("The inputs length is not expected value");
    }

    for (int i=0; i<Neurons.length-len; i++) {
      Neurons[len+i].process();
    }

    len = this.Outputs.length;
    float[] Outputs = new float[len];

    for (int i=0; i<len; i++)
      Outputs[i] = Neurons[this.Outputs[i]].axonValue;

    return Outputs;
  }

  public void train(float[] inputs, float[] expected) {
    int len = expected.length;
    float[] result = feedForward(inputs);

    //float[] error = new float[len];
    //float avr = 0;

    float[] OutputErrors = new float[len];
    float[][] hiddenErrors = new float[Hiddens.length][Hiddens[0].length];
    float[][] hiddens = new float[Hiddens.length][Hiddens[0].length];

    //Neuron[][] hiddens = new Neuron[Hiddens.length][Hiddens[0].length];

    for (int i=0; i<result.length; i++) {
      OutputErrors[i] = expected[i] - result[i];
      Neurons[Outputs[i]].addError(OutputErrors[i]);
      Neurons[Outputs[i]].processErrors();
    }

    for (int x=0; x<Hiddens.length; x++) {
      for (int y=0; y<Hiddens[x].length; y++) {
        hiddens[x][y] = Neurons[Hiddens[x][y]].axonValue;
      }
    }


    for (int x=Hiddens.length-1; x>=0; x--) {
      for (int y=0; y<Hiddens[x].length; y++) {
        //println(x, Hiddens.length-1);
        if (x==Hiddens.length-1) {//Hidden Outputs
          for (int i=0; i<Outputs.length; i++) {
            Neuron output = Neurons[Outputs[i]];
            //int index = i*Hiddens[x].length + y;
            //int index = i*Hiddens.length + y;

            //println(i,y, output.weightlen());

            //Neurons[Hiddens[x][y]].addError(OutputErrors[i] * output.getWeight(index));//error * weight
            Neurons[Hiddens[x][y]].addError(OutputErrors[i] * output.getWeight(y));//error * weight
          }
        }
        else {//Hidden Hidden
            //println("test");
          for (int i=0; i<Hiddens[x].length; i++) {
            Neuron hidden = Neurons[Hiddens[x+1][i]];

            //int index = i*(Hiddens[x].length) + y;

            //println(index,i, y, hidden.weightlen());

            //println(y);

            //println("test", hidden.getError() * hidden.getWeight(y));

            Neurons[Hiddens[x][y]].addError(hidden.getError() * hidden.getWeight(y));
          }
        }

        //println(x);
        
        Neurons[Hiddens[x][y]].processErrors();
        hiddenErrors[x][y] = Neurons[Hiddens[x][y]].getError();
      }
    }



    //for(int i=0; i<len; i++){
    //   //error[i] = (float)Math.pow(expected[i] - result[i], 2);
    //   error[i] = (expected[i] - result[i]);
    //   avr+= error[i];
    //}

    //avr /= len;

    //println(weightsHXmap);
    //println(weightsHYmap);

    len = weights.length;

    //println(weightsmap);

    for (int i=0; i<len; i++) {
      float nonproc = 0;
      float error = 0;

      //println(weightsmap[i], i%2);

      if (weightsmap[i] == 1) {//Connected Hiddens, Hiddens
        int index = i - inputs.length*hiddens[0].length;

        //int x = index/(hiddens.length *hiddens[0].length);

        int x = index / (int)Math.pow(hiddens[0].length, 2);

        int y = index%hiddens[0].length;//0, 1

        //println(index/hiddens[0].length);

        //println(index, "|", x, y);
        //println(x);

        nonproc = hiddens[x][y];
        error = Neurons[Hiddens[x+1][index/hiddens[0].length]].getError();

        //int index = i - inputs.length*hiddens[0].length;

        //int x = index/4;
      } else if (weightsmap[i] == 2) {//Connected to Outputs, Hiddens

        //int index = i - ((int)Math.pow(hiddens.length-1, hiddens[0].length) + hiddens[0].length*inputs.length);

        int index = 0;

        if (hiddens.length <= 1)
          index = i - (hiddens[0].length*inputs.length);
        else
          index = i - (hiddens[0].length*inputs.length + (int)Math.pow(hiddens[0].length, hiddens.length));

        nonproc = hiddens[hiddens.length-1][index%hiddens[0].length];

        //println(i, Math.pow(hiddens.length-1, hiddens[0].length), hiddens[0].length*inputs.length);

        //println(i - (hiddens[0].length*inputs.length + (int)Math.pow(hiddens[0].length, hiddens.length)));

        //println(index, index%2, Math.abs(1-index%2));
        //println(expected.length);
        
        if(expected.length == 1)
          error = Neurons[Outputs[0]].getError();
        else
          error = Neurons[Outputs[index/expected.length]].getError();

        //println((i-(hiddens.length*hiddens[0].length))/hiddens[0].length -1, hiddens.length-1,i%hiddens[0].length, hiddens[0].length);
      }

      if (weightsmap[i] == 0) {//Connected Hiddens, Inputs
        //int index = i/(hiddens[0].length-1);
        int index = i/inputs.length;

        error = Neurons[Hiddens[0][index]].getError();
        nonproc = inputs[i%inputs.length];
      } else {
        nonproc = dSigmoid(nonproc);
      }

      weights[i] += learningrate * error * nonproc;
      //weights[i] += learningrate * avr * nonproc;//delta = LearningRate * AverageError *
    }

    updateWeights();
  }

  void train(float[][][] dataset) {
    for (int i=0; i<dataset.length; i++) {
      train(dataset[i][0], dataset[i][1]);
    }
  }


  private void updateWeights() {
    //println("");

    ArrayList<Float> ls = new ArrayList();  

    int Count = 0;
    for (int i=0; i<Neurons.length; i++) {
      ArrayList<Float> nW = new ArrayList<Float>(); 
      Neuron n = Neurons[i];

      for (int v=0; v<n.weights.size(); v++) {
        ls.add(weights[Count]);
        nW.add(weights[Count]);
        Count++;
      }

      //println(nW, n.weights, nW.equals(n.weights));

      n.setWeights(nW);
    }

    //println("");
    //for(int i=0; i<weights.length; i++){
    //  println(weights[i], ls.get(i), weights[i] == ls.get(i));
    //}
  }

  private void saveWeights() {
    PrintWriter weightLog;

    weightLog = createWriter("Weights.txt");

    for (int i=0; i<weights.length; i++) {
      weightLog.println(weights[i]);
    }
    weightLog.flush();

    println("saved Network");
  }

  private float[] loadWeights(int weightCount) {
    BufferedReader weightsLog = createReader("Weights.txt");

    float[] weights_ = new float[weightCount];
    String line = null;
    int i=0;

    try {
      while ((line = weightsLog.readLine()) != null) {
        weights_[i] = float(line);
        i++;
      }
      weightsLog.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }

    return weights_;
  }
}
