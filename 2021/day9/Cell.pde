class Cell {
  public int x;
  public int y;
  public int depth;
  public int group;
  
  public ArrayList<Cell> neighbours;
 
  
  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.depth = 0;
    this.group = 0;
    
    neighbours = new ArrayList(8);
  }
  
  public void attachTo(Cell other) {
    this.neighbours.add(other);
    other.neighbours.add(this);
  }
  
  public boolean copyLowestNeighbourGroup() {
    boolean groupChanged = false;
    int lowestDepth = this.depth;
    for(Cell c : this.neighbours) {
        if(c.depth < lowestDepth) {
          //println("Changed group from " + this.group + " to " + c.group);
          groupChanged = this.group != c.group;
          this.group = c.group;
          lowestDepth = c.depth;
        }
    }
    
    return groupChanged;
  }
  
  public boolean isLowPoint() {
    boolean isLowest = true;
    
    for(Cell c : this.neighbours) {
      if(c.depth <= this.depth) {
        isLowest = false;
      }
    }
    
    return isLowest;
  }
  
}
