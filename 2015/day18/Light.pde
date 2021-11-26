class Light {
  public int x;
  public int y;
  
  public boolean on = true;
  public boolean nextState = true;
  public boolean locked = false;
  
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
  
  public void updateNextState() {
    if(locked) {
      this.nextState = this.on;
    } else {
      int totalOn = 0;
      for(Light light : neighbours) {
        totalOn += (light.on) ? 1 : 0;
      }
          
      if(this.on) {
        //A light which is on stays on when 2 or 3 neighbors are on, and turns off otherwise.
        this.nextState = (totalOn == 2 || totalOn == 3);
      } else {
       //A light which is off turns on if exactly 3 neighbors are on, and stays off otherwise.
        this.nextState = (totalOn == 3);
      }
    }
  }
  
  public void step() {
    this.on = this.nextState;
  }
}
