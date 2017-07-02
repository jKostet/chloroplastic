//import moonlander.library.*;
import ddf.minim.*;

PGraphics pg1, pg2, pg3;

//Moonlander moonlander;

void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  fullScreen();
  size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
  //size(640, 480, P3D);
}

//MinimController minimcontrol;

void setup() {
  rectMode(CENTER);
  //this.secs = timer();
  b = new Ball();
  sp = new Splat();
  translate(0,0,0);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  pg1 = createGraphics(displayWidth, displayHeight, P3D);
  pg2 = createGraphics(displayWidth, displayHeight, P3D);
  pg3 = createGraphics(displayWidth, displayHeight, P3D);
  Minim minim = new Minim(this);
  AudioPlayer song = minim.loadFile("chassis.mp3");
  /*minimcontrol = new MinimController(song, 205, 8);
  moonlander = new Moonlander(this, minimcontrol);
  moonlander.start();
  //minimcontrol.play();*/
  song.play();
}

void draw() {
    //minimcontrol.play();
    //moonlander.update();
    //double bg_red = moonlander.getValue("background_red");
    //println(minimcontrol.getCurrentTime());
    float t1 = 10;
    float t2 = 70+t1;
    if (millis()/1000.0 < t1) {
      drawCurve(pg1, 850);
      image(pg1, 0, 0);
    } else if (millis()/1000.0 < t2) {
      drawMatrix(pg2, t1*1000.0);
      image(pg2, 0, 0);
    } else {
      drawSplash(pg3, t2*1000.0);
      image(pg3, 0, 0);
    }
}