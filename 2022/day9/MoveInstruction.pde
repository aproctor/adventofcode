public enum MoveDirection {
    UP,
    DOWN,
    LEFT,
    RIGHT
}

class MoveInstruction {
  
  public MoveDirection direction;
  public int magnitude;
  
  public MoveInstruction(String dir, int magnitude) {
    switch(dir) {
      case "U":
        direction = MoveDirection.UP;
        break;
      case "D":
        direction = MoveDirection.DOWN;
        break;
      case "L":
        direction = MoveDirection.LEFT;
        break;
      case "R":
        direction = MoveDirection.RIGHT;
        break;
    }
    this.magnitude = magnitude;
  }
}
