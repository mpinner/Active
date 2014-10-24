import img2opc.*;
import processing.video.*;
import processing.net.*;

/*
 * This sketch uses the img2opc library to display video files in the data
 * directory at random.
 */

Movie m;
Img2Opc i2o;
//Img2Opc i2oLocal;
PImage resized;
int displayWidth = 60;
int displayHeight = 24;
Movie endingMovie = null;

PImage black; 

void setup() {

  println("user.dir : " + System.getProperty("user.dir") );
  println("Sketch path: " + sketchPath);
  println("Sketch data: " + dataPath(""));

  println( javaVersionName );
  println( System.getProperty("java.home") + "\n");

  println( System.getProperty("os.arch") );
  println( System.getProperty("os.name") );
  println( System.getProperty("os.version") + "\n");

  println( System.getProperty("user.home") );
  println( System.getProperty("user.dir") );
  println( dataPath("") );

  black = loadImage("night_img.png");

  background(0);
  size(600, 480);

  //i2o = new Img2Opc(this, "white", 7890, displayWidth, displayHeight);
  i2o = new Img2Opc(this, "localhost", 7890, displayWidth, displayHeight);
  loadMovie();
}

void mousePressed() {
  if (endingMovie != null) {
    endingMovie.stop();
    endingMovie = null;
  }
  endingMovie = m;
  loadMovie();
  endingMovie.stop();
  endingMovie = null;
}

void loadMovie() {
  m = null;


  java.io.File folder = new java.io.File(dataPath(""));
  String[] filenames = folder.list();

  String f;
  do {
    f = filenames[int(random(filenames.length))];
  } 
  while (f.equals (".DS_Store"));
  print("loading '");
  print(f);
  println("'");
  m = new Movie(this, f);
  m.play();
  m.read();
  i2o.setSourceSize(m.width, m.height);
  //i2oLocal.setSourceSize(m.width, m.height);
}

void movieEvent(Movie mov) {
  if (mov == endingMovie) {
    return;
  }
  mov.read();

  // between midnight and 8am keep it off
  if (hour() > 7) {
  
    resized = i2o.sendImg(mov, true);
    
  }   else {
    resized = i2o.sendImg(black, true);
  }


  if (mov.time() >= mov.duration() - 0.1) {
    if (endingMovie != null) {
      endingMovie.stop();
      endingMovie = null;
    }
    endingMovie = mov;
    loadMovie();
  }
}

void draw() {



  if (m != null) {
    image(m, displayWidth, 0);
  }
  if (resized != null) {
    image(resized, 0, 0);
  }
}

