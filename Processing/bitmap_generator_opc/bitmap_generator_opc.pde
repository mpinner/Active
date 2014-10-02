/*
 * Bitmap generator for an 8x8 LED matrix
 * by Keith Kay
 * 7/8/2013
 * CC by-sa v3.0 - http://creativecommons.org/licenses/by-sa/3.0/
 * http://keithkay.com
 *
 * portions of this code modified from:
 * Two-Dimensional Arrays - Example: 2D Array of Objects
 * arduno.cc
 * http://processing.org/learning/2darray/
 *
 */
 
 import img2opc.*;
import processing.net.*;

Img2Opc i2o;
//Img2Opc i2oLocal;
PImage resized;
int displayWidth = 60;
int displayHeight = 24;

/* Declare our variables */
Cell[][] bitmap;          // 2-dimensonal array used to store the bitmap
PrintWriter bitmapOutput; // declare an instance of PrinterWriter, a processing class that allows characters to print to a text-output stream.
int bitmapOutputCount=0;  // variable to store the count of the number of bitmaps saved as a file
int imgFrameCount=0;      // variable to store the numbers of frames in the current file
String filename="";       // variable to store the filename used to save all the bitmap frames

int coordinateValue = 0;

boolean renderFromLower = true;

int cols = 60;  // used as a constant
int rows = 24;  // used as a constant

void setup() {

  // build the grid used to repre each "pixel" of the bitmap
  size(1200, 480);
      strokeWeight(0);

  
    i2o = new Img2Opc(this, "white", 7890, displayWidth, displayHeight);
    


    i2o.setSourceSize(width, height);

  bitmap = new Cell[rows][cols];

  // iterate thru each cell and initialize it, passing sizing information, in this case 45x45
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      bitmap[i][j] = new Cell(i*20, j*20, 20, 20);
    }
  }

  // finish drawing the window, including directions
  background(204);
  textSize(11);
  textAlign(LEFT);
  fill(0);
  text("Press 'f' on your keyboard to save the current bitmap frame", 10, 380);
  text("Press 's' on your keyboard to save the current set of frames", 10, 400);
  text("to a file", 10, 420);
  text("Press the spacebar to clear the entire bitmap", 10, 440);

  // open the file for the bitmap
  openFile();
}

// draw() is the main function in Processing, like loop() in an Arduino sketch
void draw() {
  paintScreen();
  drawBitMap();
}

void drawBitMap() {
  // The counter variables i and j are also the column and row numbers and 
  // are used as arguments to the constructor for each object in the grid.  
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      bitmap[i][j].display();
    }
  }
}

// using the mouseClicked() event instead of mousePressed, because it was too erratic
void mouseClicked() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int temp = bitmap[i][j].clickedOnMe();
      // we can drop out as soon as we get a match because only one cell can be clicked at a time
      if (temp == 1) break;
    }
  }
}

// keyReleased detects when a key has been pressed and released, this was found to be more reliable
// for getting one execution of this function than keyPressed
void keyReleased() {
  // f - save the current frame
  if ((key =='f') || (key == 'F')) {
    // export the bitmap to a file
    saveFrame("bitmaps/bitmap-####.png"); // these are going to be saved in the project folder of your Processing folder

    // write the header line and then traverse the array to write the bits for an entire "frame"
    imgFrameCount++;
    bitmapOutput.print("{ ");
    for (int i = 0; i < rows; i++) {
      bitmapOutput.print("  B");
      for (int j = 0; j < cols; j++) {
        bitmapOutput.print(bitmap[i][j].cell_set);
      }
      if (i < rows-1) {
        bitmapOutput.print(", ");
      } 
      else {
        bitmapOutput.println("},");
      }
    }
  }

  if ((key =='l') || (key == 'L')) {

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        if (isCoordinate(j, i, 24 - coordinateValue)) {
          bitmap[i][j].cell_set = 0;
        } else {
          bitmap[i][j].cell_set = 1;
        }
        
        
      }
    }  

      coordinateValue++;
        coordinateValue = coordinateValue % rows;
        
        paintScreen();


  }

 if ((key =='d') || (key == 'D')) {

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {

        if (i == coordinateValue) {
          bitmap[i][j].cell_set = 0;
        } else {
          bitmap[i][j].cell_set = 1;
        }
        
        
      }
    }  

      coordinateValue++;
        coordinateValue = coordinateValue % rows;
paintScreen();

  }

  if ((key =='s') || (key == 'S')) {

    bitmapOutput.println("};"); 
    bitmapOutput.println("");

    // print the number of frames
    bitmapOutput.println("const int frames = " + imgFrameCount +";");

    // close the current file and open the next
    bitmapOutput.flush();
    bitmapOutput.close();
    imgFrameCount=0;
    openFile();
  }


  if ((key =='c') || (key == 'C')) {

     for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {


          bitmap[i][j].cell_set = 0;
        
        
      }
    }  
    
    
     for (int i = 2; i < rows-2; i++) {
      for (int j = 2; j < cols-2; j++) {


          bitmap[i][j].cell_set = 1;
        
        
      }
    } 
    
  }

  // simply clear the grid
  if (key == ' ') {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        bitmap[i][j].clear();
        bitmap[i][j].display();
      }
    }
  }
}

boolean isCoordinate(int x, int y, int z) {
  for (int i =0 ; i < 1440; i++) {
    if (Active.coordinate[i][0] == x) {
      if (Active.coordinate[i][1] == y) {
        if (Active.coordinate[i][2] == z) {
          return true;
        }
      }
    }
  }
  return false;
}

void openFile() {

  bitmapOutputCount++;
  filename = "bitmaps/bitmap_" + bitmapOutputCount + ".txt";
  println("Opening output file : " + filename);
  bitmapOutput = createWriter(filename);    
  bitmapOutput.println("byte imgFrame[frames][8] = {");
}

// A Cell object
class Cell {
  // A cell object knows about its location in the grid as well as its size with the variables x,y,w,h.
  float x, y;   // x,y location
  float w, h;   // width and height
  byte cell_set;

  // Cell Constructor
  Cell(float tempY, float tempX, float tempW, float tempH) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    cell_set = 0;
  }

  void clear() {
    cell_set = 0;
  }

  int clickedOnMe() {
    if ((mouseX > x) && (mouseX < x+w) && (mouseY > y) && (mouseY < y+h)) {
      // we need to flip the current setting of cell_set
      if (cell_set == 1) {
        cell_set = 0;
      } 
      else {
        cell_set = 1;
      }
      return 1;
    } 
    else {
      return 0;
    }
  }


  void display() {
    stroke(0);
    strokeWeight(0);
    // determine fill color
    if (cell_set == 1) {
      fill(0);
    } 
    else {
      fill(255);
    }

    rect(x, y, w, h);
  }
}

void paintScreen() {
PImage img = get();
img.updatePixels();
i2o.sendImg(img, renderFromLower  );
}

