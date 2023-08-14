import java.util.*;

  BufferedReader reader;
  String line;
  RopePiece head;
  RopePiece tail;
  ArrayList<MoveInstruction> instructions;
  HashSet<PVector> visitedPoints;
  
  int minX = 0;
  int minY = 0;
  int maxX = 0;
  int maxY = 0;
  int padding = 10;
  float scaleFactor = 1f;
  MoveInstruction currentInstruction;
  
  void setup() {
    //size(1400, 1000);
    size(800, 600);
    loadFile("day9.data");
    //loadFile("instructions.txt");
  }
  
 void keyPressed() {
  if(keyCode == TAB) {
    //loadState3();
  } else {
    step();
  }
}
  
  int step() {
    if(currentInstruction == null) {
      if(instructions.size() > 0) {
        currentInstruction = instructions.remove(0);
      }
      return 0;
    }    
    if(currentInstruction != null) {
      head.move(currentInstruction);
      tail.follow(head, 1);
            
      visitedPoints.add(new PVector(tail.x, tail.y));
      
      currentInstruction.magnitude -= 1;
      if(currentInstruction.magnitude <= 0) {
        currentInstruction = null;
      }      
    }
    System.out.println("Number of unique points <"+visitedPoints.size()+">");
    
    return 1;
  }
  
  void loadFile(String fname) {
    head = new RopePiece("H", 0, 0);
    head.fillColor = color(0,255,0);
    
    tail = new RopePiece("T", 0, 0);
    tail.fillColor = color(0,0,255);
    
    instructions = new ArrayList<MoveInstruction>();
    visitedPoints = new HashSet<PVector>();
    currentInstruction = null;
    
    try {
      reader = createReader(fname);
         
      do {
        line = reader.readLine();
        
        String[] matchData = null;
        
        if(line != null) {
          // System.out.println(line);
  
          matchData = match(line, "([UDLR]) ([0-9]+)");
          if(matchData != null) {
            MoveInstruction ins = new MoveInstruction(matchData[1], int(matchData[2]));
            instructions.add(ins);
          } else {
            System.out.println("WTF <"+line+">");
          }
        } 
      } while(line != null);
      
      adjustScale();
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
  }
  
void adjustScale() {
  if(head.x > maxX) {
    maxX = head.x;
  }
  if(head.x < minX) {
    minX = head.x;
  }
  if(head.y > maxY) {
    maxY = head.y;
  }
  if(head.y < minY) {
    minY = head.y;
  }
  
  int w = maxX - minX + padding*2;
  int h = maxY - minY + padding*2;
  if(w < 10) {
    w = 10;
  }
  if (h < 10) {
    h = 10;
  }
  
  if(w < width && h < height) {
    if(w > h) {      
      scaleFactor = (int) width / w / 10;
    } else {
      scaleFactor = (int) height / h / 10;
    }
  } else {
    scaleFactor = 1;
  }
}
  
void draw() {
  background(0);
  stroke(255);
  fill(255);
   
  translate(width / 2, height / 2);
  
  for(PVector v : visitedPoints) {
    fill(90,0,0);
    rect(v.x*scaleFactor + padding, v.y*scaleFactor + padding, scaleFactor, scaleFactor);
  }
   
  head.draw(scaleFactor, padding);
  if(tail.x != head.x || tail.y != head.y) {
    tail.draw(scaleFactor, padding);
  }
  
  
  for(int i = 0; i < 100; i++) {
    if(step() == 0)
      break;
  }  
}
