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
  
  public void draw(float scaleFactor, int padding) {
    fill(255);
    
    if(scaleFactor <= 1) {
      point(this.x, this.y);
    } else {
      rect(this.x*scaleFactor + padding, this.y*scaleFactor + padding, scaleFactor, scaleFactor);
    }
  }
}
