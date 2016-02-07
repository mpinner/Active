/*
  mpinner
 
 intent : scan possible three dimensional content in web or kiosk interface.
 
 todo:
 event model for live position data
 playback record multiple position streams
 portable data formats (jpeg, osc messages, artnet)
 swappable shaders (bc why not)
 animated point cloud colliders ( 3d simulation environment)
 
 
 inspiration:
 - Arc Length parametrization of curves by Jakub Valtar
 - From Nebula from CoffeeBreakStudios.com (CBS)
 - From Follow 3 from Keith Peters. 
 
 */

PShader shader;

import oscP5.*;
import netP5.*;

OscP5 oscP5;

NetAddress myRemoteLocation;


String tag = "01020224";

// segment points
float[] x = new float[20];
float[] y = new float[20];
float segLength = 15;

//time slicer
float t = 0.0;
float tStep = 0.004;

int borderSize = 40;


int latestX = 0;
int latestY = 0;


////////
// SETUP
void setup() {
  size(500, 500, P2D);
  
  
  frameRate(60);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this, "239.255.0.76",10076);
//  oscP5 = new OscP5(this,"127.0.0.1",12000);

  myRemoteLocation = new NetAddress("127.0.0.1",8005);


  frameRate(60);
  smooth(8);
  textAlign(CENTER);
  textSize(16);
  strokeWeight(9);

  // fun shaders
  //  shader = loadShader("landscape.glsl");
  shader = loadShader("monjori.glsl");
  //  shader = loadShader("nebula.glsl");

  // noops
  //  shader = loadShader("mask.glsl");
  //  shader = loadShader("frag.glsl");
  //  shader = loadShader("edges.glsl");
  // shader = loadShader("blur.glsl");
  //  shader = loadShader("FishEye.glsl");


  shader.set("resolution", float(width), float(height));

  return;
}


void draw() {

  // Show static value when mouse is pressed, animate otherwise
  if (mousePressed) {
    int a = constrain(mouseX, borderSize, width - borderSize);
    t = map(a, borderSize, width - borderSize, 0.0, 1.0);
  } else {
    t += tStep;
    if (t > 1.0) t = 0.0;
  }


  background(0);

  // iterate shader
  shader.set("time", millis() / 500.0);  
  shader(shader); 


  // draw segment line follower
  pushMatrix();
  {
    strokeWeight(10);
    stroke(255, 100);
    dragSegment(0, latestX, latestY);
    for (int i=0; i<x.length-1; i++) {
      dragSegment(i+1, x[i], y[i]);
    }
  }
  popMatrix();



  // draw seek bar
  pushMatrix();
  {
    translate(borderSize, height - 45);

    int barLength = width - 2 * borderSize;

    barStyle();
    line(0, -5, 0, 5);
    line(0, 0, t * barLength, 0);

    barLabelStyle();
    text(nf(t, 0, 2), barLength/2, 25);
  }
  popMatrix();
  
 // sendCurve();
  
  return;
}


float simZ() {
 
  return sin(radians(frameCount)); 
}

void sendCurve() {
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/position/uwb/" + tag);
  
  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(mouseX);
  myOscMessage.add(mouseY);
  myOscMessage.add(simZ());
  
   println(simZ());
  
  
  /* send the OscMessage to the multicast group. 
   * the multicast group netAddress is the default netAddress, therefore
   * you dont need to specify a NetAddress to send the osc message.
   */
  oscP5.send(myOscMessage);
}


void dragSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  float angle = atan2(dy, dx);  
  x[i] = xin - cos(angle) * segLength;
  y[i] = yin - sin(angle) * segLength;
  segment(x[i], y[i], angle);
}


void segment(float x, float y, float a) {
  pushMatrix();
  {
    translate(x, y);
    rotate(a);
    line(0, 0, segLength, 0);
  }
  popMatrix();
}




public void position(int x, int y, float z) {
  println(" 2 ints received: "+x+", "+y);  
  latestX = x;
  latestY = y;
  return;
}


/* incoming osc message are logged. */
void oscEvent(OscMessage theOscMessage) {
  
 
  if (theOscMessage.addrPattern().contains("omni")) {
    omni(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("wrist")) {
        wrist(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("armvert")) {
        armvert(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("note")) {
        note(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("/motion/")) {
        motion(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("/gesture/")) {
        gesture(theOscMessage);
  }
  if (theOscMessage.addrPattern().contains("/position/")) {
        position(theOscMessage);
  }
    
    

  
  if(theOscMessage.isPlugged()==false) {
    
  println("### addrpattern\t"+theOscMessage.addrPattern() + " " +theOscMessage.typetag());

  }
  
  return;
}



void sendWithoutDups(OscMessage theOscMessage) {
  
  
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage(theOscMessage.addrPattern());
  
  oscP5.send(myOscMessage, myRemoteLocation);
}




void omni(OscMessage theOscMessage) {
  
}

void wrist(OscMessage theOscMessage) {
  
}

void armvert(OscMessage theOscMessage) {
  
}

void note(OscMessage theOscMessage) {
  
}

void motion(OscMessage theOscMessage) {
  
}

void gesture(OscMessage theOscMessage) {
  sendWithoutDups(theOscMessage);
}

void position(OscMessage theOscMessage) {
  
}


// Styles -----

void curveStyle() {
  stroke(170);
  noFill();
}

void labelStyle() {
  noStroke();
  fill(120);
}

void circleStyle() {
  noStroke();
  fill(0);
}

void barBgStyle() {
  stroke(220);
  noFill();
}

void barStyle() {
  stroke(100);
  noFill();
}

void barLabelStyle() {
  noStroke();
  fill(120);
}