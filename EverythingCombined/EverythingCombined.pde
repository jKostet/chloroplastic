void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  fullScreen();
  size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
}

void setup() {
  rectMode(CENTER);
  this.secs = timer(0);
  b = new Ball();
  sp = new Splat();
  translate(0,0,0);
  
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw() {
    float t1 = 10;
    float t2 = 70+t1;
    if (millis()/1000.0 < t1) {
      drawCurve();
    } else if (millis()/1000.0 < t2) {
      drawMatrix(0);
    } else {
      drawSplash(0);
    }
}