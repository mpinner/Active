/**
 * LoadFile 1
 * 
 * Loads a text file that contains two numbers separated by a tab ('\t').
 * A new pair of numbers is loaded each frame and used to draw a point on the screen.
 */

String[] lines;
int index = 0;

void setup() {
  size(500, 500, P3D);
  background(0);
  
  noStroke();
  frameRate(60);
  lights();

  lines = loadStrings("trim.csv");
}

void draw() {
  if (index < lines.length) {
    String[] pieces = split(lines[index], ' ');
    if (pieces.length == 3) {
      float x = abs(float(pieces[0]) * 300);
      float y = abs(float(pieces[1]) * 200);
      float z = abs(float(pieces[2]));
      translate((int)x-300, (int)y, (int)z-10);
      fill(frameCount/3%250);
      sphere(10);
      println(x+","+y+","+z);
    }
    // Go to the next line for the next run through draw()
    index = index + 1;
  }
}