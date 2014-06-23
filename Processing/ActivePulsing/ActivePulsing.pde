// ActivePulsing
// @mpinner
// intent: create a 3d simulation of the different geometries for Active
// control: 
// mouse button cycles the colors
// keyboard keys enable or disables the following mode to make it easy to view from the side
//   Q - places the interface in to mouse mode so you might drage the form around to view from different angles
//   S - puts a 90 degree rotation on the form. this is helpful to view from the side
// 
//
// bugs: video capture and 3d rendering dont really play well together in processing. i'll move to the real hardware.

// ball geometry
int sphereRadius = 8; // 4 -> .5 inches
int sphereDistanceBetween = 8; // 8 -> 2 inches , 6 -> 1.5 inches
int sphereSpacing = sphereDistanceBetween + 2*sphereRadius;  // center to center

// modes for interface
boolean mouseMove = false;
boolean sideView = false;

// postitions where balls can exist
int count[] = {
  24, 24, 48
};

// cache for precalculated position and color data
boolean[][][] on = new boolean[count[0]][count[1]][count[2]];
float[][] xDistance = new float[count[1]][count[2]];
int[][] xPosition = new int[count[1]][count[2]];
int[][] xBrightness = new int[count[1]][count[2]];

int dropped = 0;

// starts here
void setup() {
  size(1280, 800, P3D);
  colorMode(HSB);

  // pre-calc
  calcOn();
  calcXDistance();
  calcXPosition();
  calcXBrightness();

  return;
}

void calcXDistance() {
  for (int j = 0; j < count[1]; j++) {
    for (int k = 0; k < count[2]; k++) {

      xDistance[j][k] = random(count[0]);
    }
  }

  return;
}


void calcXBrightness() {
  for (int j = 0; j < count[1]; j++) {
    for (int k = 0; k < count[2]; k++) {

      xBrightness[j][k] = (int)random(200.0);
    }
  }

  return;
}


void reCalcXBrightness() {
  for (int j = 0; j < count[1]; j++) {
    for (int k = 0; k < count[2]; k++) {

      xBrightness[j][k] = xBrightness[j][k]-5;

      if (random(100) > 95) {
        xBrightness[j][k] = (int)random(200.0);
      }
    }
  }


  return;
}


void calcXPosition() {
  print("[");
  for (int j = 0; j < count[1]; j++) {
    for (int k = 0; k < count[2]; k++) {

      int distance = ((int)xDistance[j][k]);
        xPosition[j][k] = distance;
      print("{\"point\": [" + j + ", " + k + ", " + distance + "]},");
    }
  }

  return;
}

void calcOn() {
  for (int i = 0; i < count[0]; i++) {
    for (int j = 0; j < count[1]; j++) {
      for (int k = 0; k < count[2]; k++) {

        if (random(1.0) > 0.9) {
          on[i][j][k] = true;
        } 
        else {
          on[i][j][k] = false;
        }
      }
    }
  }
}



void drawXDistance() {

  pushMatrix();

  translate(-1 * count[2] * sphereSpacing / 2, -1 * count[1] * sphereSpacing / 2, 0);

  for (int j = 0; j < count[1]; j++) {
    translate(0, sphereSpacing, 0);
    pushMatrix();

    for (int k = 0; k < count[2]; k++) {
      translate(sphereSpacing, 0, 0);


      translate (0, 0, xPosition[j][k]*sphereSpacing);
      fill(xDistance[j][k]*10, 25, xBrightness[j][k]);
      sphere(sphereRadius);
      translate (0, 0, -1 * xPosition[j][k]*sphereSpacing);
    }
    popMatrix();
  }
  popMatrix();



  return;
}

void draw() {


  background(0);
  lights();
  translate(width/2, height/2, 0);


  // video is broken
  /*
  if (video.available()) {
   video.read();
   video.loadPixels();
   
   //background(0, 0, 255);
   
   // Begin loop for columns
   for (int i = 0; i < cols; i++) {
   // Begin loop for rows
   for (int j = 0; j < rows; j++) {
   
   // Where are we, pixel-wise?
   //  int x = i * xCellSize;
   //  int y = j * yCellSize;
   int loc = j + i*video.height; // Reversing x to mirror the image
   
   // Each rect is colored white with a size determined by brightness
   color c = video.pixels[loc];
   if (random(1000) > 995) {
   println (c);
   }
   float sz = brightness(c);
   
   // xBrightness[j][i] = (int)sz;
   }
   }
   }
   
   */


  if (mousePressed) {

    reCalcXBrightness();
    /*
    float fov = PI/3.0; 
     float cameraZ = (height/2.0) / tan(fov/2.0); 
     perspective(fov, float(width)/float(height), cameraZ/2.0, cameraZ*2.0);
     */
  } 
  else {

    ortho(0, width, 0, height);
  }

  if (mouseMove) {
    rotateX(radians(-1*mouseY/2));
    rotateY(radians(-1*mouseX/2));
  }


  if (sideView) {
    rotateY(radians(90));
  }



  noStroke();
  fill(255);

  drawXDistance();


  if (millis() / 2000 > dropped) {
    //  printBrightness();
    dropped++;
  }



  // draws an image in the form
  /*  
   
   beginShape();
   texture(img);
   vertex(-100, -100, 0, 0,   0);
   vertex( 100, -100, 0, 400, 0);
   vertex( 100,  100, 0, 400, 400);
   vertex(-100,  100, 0, 0,   400);
   endShape();
   */
}

// some debug output
void printBrightness() {

  println ("hi: " + dropped); 

  for (int j = 0; j < count[1]; j++) {


    if (0 != j) {
      println (", ");
    }

    for (int k = 0; k < count[2]; k++) {

      print (" " + xBrightness[j][k]);
      print (", ");
    }
  }
  return;
}


// interface event handling
void keyPressed() {

  if (key == 'q' || key == 'Q') {
    mouseMove = !mouseMove;
  }

  if (key == 's' || key == 'S') {
    sideView = !sideView;
  }
}

