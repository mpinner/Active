Particle[] particles;
int particlesAmount = 5;

import img2opc.*;
import processing.net.*;

Img2Opc i2o;

PImage pixelBuffer;

int displayWidth = 60;
int displayHeight = 24;


void setup() {

  frameRate(30);

  size(720, 480, P3D);
  particles = new Particle[particlesAmount];
  for (int i = 0; i < particlesAmount; i++) {
    particles[i] = new Particle();
  }
  noStroke();

  pixelBuffer = new PImage(displayWidth, displayHeight, RGB);
  i2o = new Img2Opc(this, "localhost", 7890, displayWidth, displayHeight);
  i2o.setSourceSize(width, height);
  for (int i = 0; i < 1440; i++) {
    pixelBuffer.pixels[i] = 255;
  }
  pixelBuffer.updatePixels();
  image(pixelBuffer, 0, 0);
  pixelBuffer.loadPixels();
  i2o.sendImg(pixelBuffer);
  
}

void draw() {
  background(0);
  lights(); 
  directionalLight(255, 0, 145, -1, 0, 0);
  directionalLight(220, 30, 30, 1, 0, 0);
  camera(0, 0, (height * 0.2) / tan(PI * 60.0 / 360.0), 0, 0, 0, 0, 1, 0);

  for (int i = 0; i < particlesAmount; i++) {
    rotateZ(radians(mouseX));
    rotateY(radians(mouseY));

    particles[i].draw();
    
    
  }

// pull image from the screen
  pixelBuffer = get();
  pixelBuffer.updatePixels();
  
//  for (int i = 0; i < (displayWidth*displayHeight); i++) {
    
    
    //pixelBuffer.pixels[i] = color(255, 255, 255);
 // }

  i2o.sendImg(pixelBuffer, false);
  
  return;
  
}

