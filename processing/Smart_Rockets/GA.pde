class GA{
  public rocket[] population;
  int initSize = 50;
  int populationSize = 1000;
  
  GA(){
    population = new rocket[populationSize];
    for(int i=0; i<initSize; i++){
      population[i] = new rocket();
    }
  }
  
  public void run(){
    for(int i=0; i<population.length; i++){
      population[i].show(); 
      population[i].update();
      
    }
  }
  
  void breed(){
    //for(int i=0; i<population.length; i++){
    //  population[i].grade();
    //}
    int index1 = (int)Math.floor(random(population.length));//fix these
    int index2 = (int)Math.floor(random(population.length));
    
    while(index1 == index2){
      index2 = (int)Math.floor(random(population.length));
    }
    
    rocket parent1 = population[index1];
    rocket parent2 = population[index2];
    
    PVector[] genes = new PVector[parent1.genes.length];
  }
  
}
