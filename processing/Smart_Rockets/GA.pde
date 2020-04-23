class GA{
  int populationSize = 5;
  public rocket[] population = new rocket[populationSize];
  
  public void init(){
   for(int i=0; i<populationSize; i++){
     population[i] = new rocket(); 
   }
  }
  
  public void run(){
    for(int i=0; i<population.length; i++){
      population[i].show(); 
      population[i].update();
    }
  }
  
}
