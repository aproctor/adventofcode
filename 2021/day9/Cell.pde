class Cell {
  public int x;
  public int y;
  public int depth;
  
  public ArrayList<Cell> neighbours;
  
  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.depth = 0;
    
    neighbours = new ArrayList(8);
  }
  
  public void attachTo(Cell other) {
    this.neighbours.add(other);
    other.neighbours.add(this);
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
