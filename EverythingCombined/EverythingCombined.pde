PGraphics pg1, pg2, pg3;

void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  fullScreen();
  size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
}

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
}

void draw() {
    float t1 = 10;
    float t2 = 70+t1;
    //drawSplash(pg1, 0);
    //image(pg1, 0, 0);
    //float timer1 = 0;
    //float timer2 = 0;
    if (millis()/1000.0 < t1) {
      drawCurve(pg1, 850);
      image(pg1, 0, 0);
      //timer1 = millis();
      //println(timer1);
    } else if (millis()/1000.0 < t2) {
      drawMatrix(pg2, t1*1000.0);
      image(pg2, 0, 0);
      //timer2 = millis();
    } else {
      drawSplash(pg3, t2*1000.0);
      image(pg3, 0, 0);
    }
}