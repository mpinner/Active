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
  i2o.setSourceSize(displayWidth, displayWidth);
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
  // pixelBuffer = get();
  pixelBuffer.updatePixels();

  for (int i = 0; i < (displayWidth*displayHeight); i++) {
    
    int x = i % 60;
    int y = i / 60;
    int z = Active.coordinate[x*24+y][2];
    
    
    
    int index = y * 24 + x;

    //  pixelBuffer.pixels[i] = color(255, 255, 255);
    float shortest = 255.0;

    for (int j = 0; j < particlesAmount; j++) {
      
      
      PVector activePoint = new PVector(
      (x- displayWidth/2) * 5,
      (y- displayHeight/2) * 3,
      (z- displayHeight/2) * 3);
      
      
      float distance = activePoint.dist(particles[j].pos);
//        float distance = activePoint.dist(new PVector(0.0,0.0,0.0));

      if (shortest > distance) {
      shortest = distance;
    }

    if (i == 0) {

      print(shortest + "\n");
      pixelBuffer.pixels[i] = color(shortest, shortest, shortest);
         
     print ("j"+j+" x,y,z: "+particles[j].pos.x+","+particles[j].pos.y+","+particles[j].pos.z+"\n");
      print (" x,y,z: "+activePoint.x+","+activePoint.y+","+activePoint.z+"\n");


    }
    
//shortest *= 5;

    if ( shortest < 50 ) { 
      shortest = map(shortest, 0, 50, 255, 0);
    } else {
      shortest = 0;
    
    }



/*if ( ((millis()/250) % 24) == z ){
        shortest = 255;
    } else {
      shortest = 0;
    }
*/
    pixelBuffer.pixels[i] = color(shortest, shortest, shortest);
  }
  
  }


 for (int j = 0; j < particlesAmount; j++) {

//print ("j"+j+" x,y,z: "+particles[j].pos.x+","+particles[j].pos.y+","+particles[j].pos.z+"\n");

    }



  i2o.sendImg(pixelBuffer, true);

  return;
}

