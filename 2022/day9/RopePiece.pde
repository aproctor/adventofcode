class RopePiece {
  public int x;
  public int y;
  public String label;
  public color fillColor; 
  
  public RopePiece(String label, int x, int y) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.fillColor = color(80,0,0);
  }
  
  public void draw(float scaleFactor, int padding) {
    if(scaleFactor < 1) {
      scaleFactor = 1;
    }
        
    fill(this.fillColor);
    rect(this.x*scaleFactor + padding + 2, this.y*scaleFactor + padding + 2, scaleFactor-4, scaleFactor-4);
    
    fill(255);
    stroke(0);
    text(label, this.x*scaleFactor + padding, this.y*scaleFactor + padding);
  }
  
  public void follow(RopePiece other, int maxDistance) {
    int deltaX = other.x - this.x;
    int deltaY = other.y - this.y;
    
    if(deltaX == 0 && deltaY == 0) {
      // Do nothing head is overlapping
      // This will simplify later logic
      return;
    }
    
    int adx = abs(deltaX);
    int ady = abs(deltaY);
    
    if(adx > maxDistance && deltaY == 0) {
      // Shift over by 1 x
      this.x += deltaX / adx;
    } else if(ady > maxDistance && deltaX == 0) {
      // Shift over by 1 y in correct direction
      this.y += deltaY / ady;
    } else if(adx > maxDistance || ady > maxDistance) {
      // We know that the head is out of bounds, now find the bigger distance and move that way
      if(adx > 0) {
        this.x += deltaX / adx;
      }
      if(ady > 0) {
        this.y += deltaY / ady;
      }
    }
    
  }
  
  public void move(MoveInstruction ins) {
    if(ins.direction == MoveDirection.UP) {
      this.y -= 1;
    } else if(ins.direction == MoveDirection.DOWN) {
      this.y += 1;
    } else if(ins.direction == MoveDirection.RIGHT) {
      this.x += 1;
    } else if(ins.direction == MoveDirection.LEFT) {
      this.x -= 1;
    }
    
    print("Head is now at: "+this.getCoordinateString()+"\n");
  }
  
  public String getCoordinateString() {
    return this.x + "," + this.y;
  }
}
