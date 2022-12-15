class RopePiece {
  public int x;
  public int y;
  public String label;
  
  public RopePiece(String label, int x, int y) {
    this.label = label;
    this.x = x;
    this.y = y;
  }
  
  public void draw(float scaleFactor, int padding) {
    if(scaleFactor < 1) {
      scaleFactor = 1;
    }
    
    fill(90);
    rect(this.x*scaleFactor + padding, this.y*scaleFactor + padding, scaleFactor, scaleFactor);
    
    fill(255);
    stroke(0);
    text(label, this.x*scaleFactor + padding, this.y*scaleFactor + padding);
  }
  
  public void follow(RopePiece other, int maxDistance) {
  }
  
  public void move(MoveInstruction ins) {
    if(ins.direction == MoveDirection.UP) {
      this.y -= ins.magnitude;
    } else if(ins.direction == MoveDirection.DOWN) {
      this.y += ins.magnitude;
    } else if(ins.direction == MoveDirection.RIGHT) {
      this.x += ins.magnitude;
    } else if(ins.direction == MoveDirection.LEFT) {
      this.x -= ins.magnitude;
    }
    
    print("Head is now at: "+this.getCoordinateString()+"\n");
  }
  
  public String getCoordinateString() {
    return this.x + "," + this.y;
  }
}
