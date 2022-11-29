class FoldInstruction {
  public boolean alongX = true;
  public int coordinate = 0;
  
  public FoldInstruction(String direction, int coordinate) {    
    this.coordinate = coordinate;
    this.alongX = (direction.equals("x"));
  }
}
