int s = 60;
int w, h;

int[][] grid;
color[][][] colors;
int[][] directions = {{0, 1, 2, 3}, {1, 0, 3, 2}, {3, 2, 1, 0}};
int[][] segments = {{1, 0, 1, 0}, {0, 1, 1, 0}, {0, 0, 1, 1}};

void setup() {
  size(1500, 1500);
  w = width/s; 
  h = height/s;
  grid = new int[w][h];
  colors = new color[w][h][2];
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      grid[x][y] = floor(random(3));
      colors[x][y][0] = color(0, 0, 0);
      colors[x][y][1] = color(0, 0, 0);
    }
  }
  tracePaths();
}

void tracePaths() {
  for(int i = 0; i < 10000; i++) {
    tracePath();
  }
}

void tracePath() {
  int x = floor(random(w));
  int y = floor(random(h));
  int segment = floor(random(2));
  color col = randColor();
  int tx = x; int ty = y; int ts = segment;
  int cell = grid[tx][ty]; 
  int d = 0;
  switch(cell) {
    case 0: d = (segment==0)?1:0; break;
    case 1: d = (segment==0)?0:2; break;
    case 2: d = (segment==0)?0:2; break;
  }
  while(true) {
    colors[tx][ty][ts] = col;
    tx = tx + (d==1?1:(d==3?-1:0));
    ty = ty + (d==2?1:(d==0?-1:0));
    if(tx < 0 || tx >= w || ty < 0 || ty >= h) break;
    cell = grid[tx][ty];
    d = directions[cell][d];
    ts = segments[cell][d];
    if(colors[tx][ty][ts] == col) break;
  }
  tx = x; ty = y; ts = segment;
  cell = grid[tx][ty]; 
  d = 0;
  switch(cell) {
    case 0: d = (segment==0)?3:2; break;
    case 1: d = (segment==0)?3:1; break;
    case 2: d = (segment==0)?1:3; break;
  }
  while(true) {
    colors[tx][ty][ts] = col;
    tx = tx + (d==1?1:(d==3?-1:0));
    ty = ty + (d==2?1:(d==0?-1:0));
    if(tx < 0 || tx >= w || ty < 0 || ty >= h) break;
    cell = grid[tx][ty];
    d = directions[cell][d];
    ts = segments[cell][d];
    if(colors[tx][ty][ts] == col) break;
  }
}

void draw() {
  colorMode(RGB, 255, 255, 255);
  //background(0);
  background(255);
  strokeWeight(s/10);
  noFill();
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      drawShape(x*s, y*s, grid[x][y]);
    }
  }
  noLoop();
}

void drawShape(int x, int y, int n) {
  stroke(colors[x/s][y/s][0]);
  switch(n) {
  case 0:
    line(x, y+s/2, x+s, y+s/2);
    break;
  case 1:
    arc(x, y, s, s, 0, TAU/4);
    break;
  case 2:
    arc(x+s, y, s, s, TAU/4, TAU/2);
    break;
  }
  stroke(colors[x/s][y/s][1]);
  switch(n) {
  case 0: 
    line(x+s/2, y, x+s/2, y+s); 
    break;
  case 1:
    arc(x+s, y+s, s, s, TAU/2, 3*TAU/4);
    break;
  case 2:
    arc(x, y+s, s, s, 3*TAU/4, TAU);
    break;
  }
}

void mouseClicked() {
  draw();
  int n = floor(random(1000));
  save("loops_"+n+".png");
  println("Saved: " + n);
}

color randColor() {
  // Random:
  //return color(random(256), random(256), random(256));
  
  // Blues & greens:
  //return color(random(100), random(192)+64, random(192)+64);
  
  // Hues:
  //colorMode(HSB, 360, 100, 100);
  //color ret = color(random(360), 100, 100);
  //colorMode(RGB);
  //return ret;
  
  // Grayscale:
  return color(random(230));
}
