int lightSize = 5;
int padding = 1;
int gridWidth = 6;
int gridHeight = 6;
int curStep = 0;
int curLine = 0;
int flashCount = 0;
Light[][] lights;

void setup() {
  size(600, 600);
  loadState1();
}

void keyPressed() {
  if(keyCode == TAB) {
    loadState1();
  } else {
    step();
  }
}

 
void setupGrid() {
  lights = new Light[gridHeight][gridWidth];
  
  for(int i = 0; i < gridHeight; i++) {
    for(int j = 0; j < gridWidth; j++) {
      int x = j * (lightSize + padding);
      int y = i * (lightSize + padding);
      Light light = new Light(x, y);
      lights[i][j] = light;
      
      if(i > 0) {
        light.attachTo(lights[i-1][j]);
        
        if(j > 0) {
          //Diagonal up left
          light.attachTo(lights[i-1][j-1]);
        }
        if(j < gridWidth - 1) {
          //Diagonal up right
          light.attachTo(lights[i-1][j+1]);
        }
      }
      if(j > 0) {
        light.attachTo(lights[i][j-1]);
      }
    }
  }
}

void step() {
  int totalFlashes = 0;
  
  // All of the lights update simultaneously; they all consider the same current state before moving to the next.
  for(int i = 0; i < gridHeight; i++) {
    for(int j = 0; j < gridWidth; j++) {
      lights[j][i].updateCharge();
    }
  }
  
  int newFlashes = 1;
  while(newFlashes > 0) {
    newFlashes = 0;
    
    for(int i = 0; i < gridHeight; i++) {
      for(int j = 0; j < gridWidth; j++) {
        boolean flashed = lights[j][i].check();
        if(flashed) {
          newFlashes += 1;
        }
      }
    }
    totalFlashes += newFlashes;
  }
  
  curStep +=1;
  
  flashCount += totalFlashes;
  
  println("Step " + curStep + ": +" + totalFlashes + " =  " + flashCount + " Total");
}

void draw() {
  background(0);
  
  stroke(255);
  fill(255);
  strokeWeight(0);
  
  for(int i = 0; i < gridHeight; i++) {
    for(int j = 0; j < gridWidth; j++) {
      Light l = lights[j][i];
      
      if(l.on) {
        fill(255);
      } else {
        fill(map(l.charge, 0, 8, 0, 100));
      }
      
      rect(l.x, l.y, lightSize, lightSize);
      
      /* Debug Draw neighbour count */
      stroke(255,0,0);
      strokeWeight(1);
      fill(122);
      text(""+l.charge, l.x + 7, l.y+15);
      strokeWeight(0);
      /* */
    }
  }
  
  /* Debug Draw selected
  Light l2 = lights[3][4];
  stroke(0,255, 0);
  strokeWeight(1);
  fill(255,0.2);
  rect(l2.x, l2.y, lightSize, lightSize);
  stroke(0,0,255);
  for(Light l : l2.neighbours) {
    rect(l.x, l.y, lightSize, lightSize);
  }
  */
  
  // step();
}

void loadLine(String line) {
  for(int i = 0; i < line.length(); i++) {
    lights[curLine][i].charge = Character.getNumericValue(line.charAt(i)); 
  }
  
  curLine += 1;
}

void loadState1() {
  gridWidth = 10;
  gridHeight = 10;
  lightSize = 20;
  setupGrid();
  
  curStep = 0;
  curLine = 0;
  flashCount = 0;
  
  loadLine("5483143223");
  loadLine("2745854711");
  loadLine("5264556173");
  loadLine("6141336146");
  loadLine("6357385478");
  loadLine("4167524645");
  loadLine("2176841721");
  loadLine("6882881134");
  loadLine("4846848554");
  loadLine("5283751526");
}

void loadState2() {
  gridWidth = 5;
  gridHeight = 5;
  lightSize = 20;
  setupGrid();
  
  curStep = 0;
  curLine = 0;
  flashCount = 0;
  
  loadLine("11111");
  loadLine("19991");
  loadLine("19191");
  loadLine("19991");
  loadLine("11111");
  
}
