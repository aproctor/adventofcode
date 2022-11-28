class Light {
  public int x;
  public int y;
  public int charge = 0;
  public boolean on = false;
  
  public ArrayList<Light> neighbours;
  
  public Light(int x, int y) {
    this.x = x;
    this.y = y;
    
    neighbours = new ArrayList(8);
  }
  
  public void attachTo(Light other) {
    this.neighbours.add(other);
    other.neighbours.add(this);
  }
  
  public void updateCharge() {   
    this.on = false;
    this.charge += 1; 
  }
  
  public boolean check() {
    if(this.charge > 9) {
      this.on = true;
      this.charge = 0;
      for(Light light : neighbours) {
        light.charge += 1;
      }
      
      return true;
    }
    
    return false;
  }
}
