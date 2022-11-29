class OPoint {
  public int x;
  public int y;
  
  public OPoint(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public void applyFold(FoldInstruction ins) {
    if(ins.alongX) {
      if(this.x > ins.coordinate) {
        this.x = ins.coordinate - (this.x - ins.coordinate);
      }
    } else {
      if(this.y > ins.coordinate) {
        this.y = ins.coordinate - (this.y - ins.coordinate);        
      }
    }
  }
  
  public String getCoords() {
    return x + "," + y;
  }
  
  public void draw(float scaleFactor, int padding) {
    if(scaleFactor <= 1) {
      stroke(255);
      point(this.x, this.y);
    } else {
      fill(255);
      stroke(0);
      rect(this.x*scaleFactor + padding, this.y*scaleFactor + padding, scaleFactor, scaleFactor);
    }
  }
}
