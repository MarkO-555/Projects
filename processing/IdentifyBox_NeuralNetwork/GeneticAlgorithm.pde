public class GeneticAlgorithm{
  ArrayList<Network> nets = new ArrayList<Network>();
  int initCount =1;
  
  public GeneticAlgorithm(){
    for(int i=0; i<initCount; i++){
      nets.add(new Network(4, 2, 4, 16, false));
    }
  }
  
  public void breed(){
  
  }
  
  public float grade(){
  
  }
}
