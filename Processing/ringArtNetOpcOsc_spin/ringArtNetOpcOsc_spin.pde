OPC opc;
PImage dot;


import oscP5.*;
import netP5.*;
  
OscP5 osc;
NetAddress oscOut;

HashMap<String,int[]> position = new HashMap<String,int[]>();
  
OscMessage msg = new OscMessage("/default");

void setup()
{
  size(500, 500);
  
  osc = new OscP5(this,12000);
  oscOut = new NetAddress("127.0.0.1",8017);




  // Load a sample image
  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver
  opc = new OPC(this, "127.0.0.1", 7890);

  // Map one 24-LED ring to the center of the window
  opc.ledRing(0, 4, width/2, height/2, width*0.3, 0);
  opc.ledRing(4, 4, width/2, height/2, width*0.1, 0);
}




void drawDot(float angle, float distance, float size)
{
  image(dot, width/2 - distance * sin(angle) - size/2,
    height/2 - distance * cos(angle) - size/2, size, size);
}

void draw()
{
  background(0);

  float a = millis();

  blendMode(ADD);
  tint(40, 0, 130);
  drawDot(a * -0.002, width*0.2, width*0.6);
  
  tint(155, 155, 155);
  drawDot(a * -0.001, width*0.2, width*0.6);
  
  tint(90, 90, 155);
  drawDot(a *  0.001, width*0.1, width*0.6);
  
     
  int msgSize = 44;
  
// todo: impl position
  msgSize = 24;

    
  // traditional artnet 24 channel
  int colorChannels = 3 ; // rgb 
  for(int i = 0; i < msgSize/colorChannels; i++ ) {
    
    color pixel = opc.getPixel(i);
    msg.add(red(pixel)); 
    msg.add(green(pixel)); 
    msg.add(blue(pixel)); 
    

    
  }
  
  
 
  
  
  //osc sending
  msg.setAddrPattern("/artnet" );
  osc.send(msg, oscOut);
  msg.clear();
  

 
  
}