//Part 2 secret?  AHPRPAU


  BufferedReader reader;
  String line;
  ArrayList<OPoint> points;
  ArrayList<FoldInstruction> instructions;
  
  int minX = 0;
  int minY = 0;
  int maxX = 0;
  int maxY = 0;
  int padding = 2;
  float scaleFactor = 1f;
  
  void setup() {
    size(1400, 1000);
    loadFile("day13.data");
    //loadFile("sample.data");
  }
  
 void keyPressed() {
  if(keyCode == TAB) {
    //loadState3();
  } else {
    step();
  }
}
  
  void step() {
    if(instructions.size() > 0) {
      FoldInstruction ins = instructions.remove(0);
      
      for(OPoint point : points) {
        point.applyFold(ins);
      }
      
      optimizePoints();
    }
  }
  
  void optimizePoints() {
    int newMaxX = 0;
    int newMaxY = 0;
    for(OPoint point : points) {
        if(point.x > newMaxX) {
          newMaxX = point.x;
        }
        if(point.y > newMaxY) {
          newMaxY = point.y;
        }
        
        //TODO remove duplicate points
    }
    
    System.out.println("New X<"+newMaxX+"> old <"+maxX+">");
    System.out.println("New Y<"+newMaxY+"> old <"+maxY+">");
    
    maxX = newMaxX;
    maxY = newMaxY;
    
    adjustScale();
  }
  
  void loadFile(String fname) {
    points = new ArrayList<OPoint>();
    instructions = new ArrayList<FoldInstruction>();   
    
    try {
      reader = createReader(fname);
      
      int i = 0;
     
      do {
        line = reader.readLine();
        
        String[] matchData = null;
        
        if(line != null) {
          // System.out.println(line);
  
          matchData = match(line, "([0-9]+),([0-9]+)");
          if(matchData != null) {
            int x = int(matchData[1]);
            int y = int(matchData[2]);
            
            if(i == 0) {
              minX = maxX = x;
              minY = maxY = y;
            } else {
              if(x < minX) {
                minX = x;
              }
              if(y < minY) {
                minY = y;
              }
              if(x > maxX) {
                maxX = x;
              }
              if(y > maxY) {
                maxY = y;
              }
            }
            
            OPoint p = new OPoint(x,y);
            points.add(p);
          } else {
             matchData = match(line, "fold along (x|y)=([0-9]+)");
             
             if(matchData != null) {
               System.out.println("Axis: "+matchData[1]+ " coord: "+matchData[2]);
               
               instructions.add(new FoldInstruction(matchData[1], int(matchData[2])));
             }
          }
        } 

        i++;
      } while(line != null);
      
      adjustScale();
    } catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
  }
  
void adjustScale() {
  int w = maxX - minX + padding*2;
  int h = maxY - minY + padding*2;
  
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
  
  for(OPoint p : points) {
    p.draw(scaleFactor, padding);
  }
}
