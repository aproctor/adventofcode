import java.util.*;

  BufferedReader reader;
  String line;
  RopePiece head;
  ArrayList<RopePiece> segments;
  ArrayList<MoveInstruction> instructions;
  HashSet<PVector> visitedPoints;
  
  int minX = 0;
  int minY = 0;
  int maxX = 0;
  int maxY = 0;
  int padding = 10;
  int stepsPerFrame = 0;
  int connections = 9;
  float scaleFactor = 1f;
  MoveInstruction currentInstruction;
  
  void setup() {
    //size(1400, 1000);
    size(800, 800);
    //loadFile("day9.data");
    loadFile("instructions.txt");
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
      } else {
        return 0;
      }
    }    
    if(currentInstruction != null) {
      head.move(currentInstruction);
      RopePiece lastSegment = head;
      for(int i = 1; i < segments.size(); i++) {
        lastSegment = segments.get(i);
        lastSegment.follow(segments.get(i-1), 1);        
      }
      
      visitedPoints.add(new PVector(lastSegment.x, lastSegment.y));
      
      currentInstruction.magnitude -= 1;
      if(currentInstruction.magnitude <= 0) {
        currentInstruction = null;
      }      
    }
    System.out.println("Number of unique points <"+visitedPoints.size()+">");
    
    adjustScale();
    
    return 1;
  }
  
  void loadFile(String fname) {
    segments = new ArrayList<RopePiece>();
    
    head = new RopePiece("H", 0, 0);
    head.fillColor = color(0,255,0);
    segments.add(head);
    
    for(int i = 0; i < connections; i++) {
      RopePiece segment = new RopePiece(""+(i+1), 0, 0);
      segment.fillColor = color(0,0,255);
      segments.add(segment);
    }
    
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
      scaleFactor = (int) width / w;
    } else {
      scaleFactor = (int) height / h;
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
  for(int i = 0; i < segments.size(); i++) {
    segments.get(segments.size() - 1 - i).draw(scaleFactor, padding);
  }  
  
  for(int i = 0; i < stepsPerFrame; i++) {
    if(step() == 0)
      break;
  }
}
