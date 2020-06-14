class Weapon{
  //int eqquiped;
  WeaponLists eqquiped;
  Tank tank;
  
  void fire(){
    if (!menuWasUp) {
      particlesystem.add(new ParticleSystem(20, tank.pos.copy().sub(tank.barrel.copy().setMag(tank.Width-10)), tank.pos.copy().sub(tank.barrel), 45, 2, 2, 2));

      bullets.add(new bullet(tank, eqquiped));
      tank.applyForce(tank.barrel.copy().setMag(2));
      mouseDown = false;
    }
    else
      mouseDown = false;

    menuWasUp = false;
  }
  
  Weapon(Tank tank){
    this.tank = tank;
    eqquiped = WeaponLists.Default;
  }
  
  void update(){
    
  }
  
  void NextWeapon(){
  }
  
  void PrevWeapon(){
  }
  
  void ToWeapon(int num){
  }
  
  void Draw(){
  }
}
