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
  img = loadImage("chloroplastic.png");
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
  AudioPlayer song = minim.loadFile("beatdoctorshot.mp3");
  /*minimcontrol = new MinimController(song, 205, 8);
  moonlander = new Moonlander(this, minimcontrol);
  moonlander.start();
  //minimcontrol.play();*/
  song.play();
  song.setGain(10);
}

void draw() {
    //minimcontrol.play();
    //moonlander.update();
    //double bg_red = moonlander.getValue("background_red");
    //println(minimcontrol.getCurrentTime());
    float t1 = 10;
    float t2 = 34+t1;
    float t3 = 20+t2;
    
    float se = millis()/1000.0;
    
    if (se < t1) {
      drawCurve(pg1, 850);
      image(pg1, 0, 0);
    } else if (se < t2) {
      drawMatrix(pg2, t1*1000.0);
      image(pg2, 0, 0);
    } else if (se < t3 + 5) {
      drawSplash(pg3, t2*1000.0);
      image(pg3, 0, 0);
    /*} else {*/
       //pg3.clear();
       /*background(0);
       translate(displayWidth/2, displayHeight/2, 0);
       sphereDetail(1);
       sphere(50);
       fill(255);
       textSize(122);
       text("Fin.", 100, 300);*/
    }
    
    hud(se);
}

PImage img;

void hud(float s) {
  
  
  
  pushMatrix();
    camera();
    //  hint(DISABLE_DEPTH_MASK);
    hint(DISABLE_DEPTH_TEST);
    textMode(MODEL);
    textSize(50);
    fill(100,255,100);
    if (s > 3 && s < 6) text("handle1", 70, 700); // curve
    if (s > 12 && s < 15) text("Dr. Phoenix", 70, 100);
    if (s > 50 && s < 53) text("jkostet", 1100, 700);
    
    if (s > 60) image(img, 300, 600);
    
    

    hint(ENABLE_DEPTH_TEST);
    
  popMatrix();
}