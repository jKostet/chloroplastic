/*
 * An example of how to use
 * Processing's 3D features.
 *
 * Features:
 * - Setting up a 3D viewport
 * - Drawing plane and sphere primitives
 * - 3D-transformations
 */
 
int CANVAS_WIDTH = 1920;
int CANVAS_HEIGHT = 1080;

float secs;
Ball b;
Splat sp;

int cols, rows;
int scl = 20;
int w = 3000;
int h = 3000;

float[][] terrain;


void settings() {
  // The P3D parameter enables accelerated 3D rendering.
  fullScreen();
  size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
}

void setup() {
  rectMode(CENTER);
  this.secs = timer();
  b = new Ball();
  sp = new Splat();
  translate(0,0,0);
  
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

void cameraSetup() {
  // Center the view
  translate(width/2, height/2, 0);
  // Move up and backwards - away from the origin
  translate(0, 800, -2000);
  // Rotate the viewport a bit with mouse
  //rotateY((mouseX - width/2) * 0.001);
  //rotateX((mouseY - height/2) * -0.001);
}

void newCam(float s){
  //while
  camera(1,-5000+500*s,0,0,0,0,0,1,0);
}

void ground() {
  terGen();
  if (true) return;
  
  
  // Draw the ground plane
  stroke(0);
  fill(100); //plane colour
  
  pushMatrix();
  // Rotate the plane by 90 degrees so it's laying on the ground 
  rotateX(PI/2);
  scale(10.0);
  // Draw the plane
  rect(0, 0, 100, 100);
  popMatrix();
}

void axis() {
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  stroke(0);
}


float timer() {
    float secs = millis() / 1000.0;
    return secs;
}

void draw() {
  axis();

  if (secs < 13) background(0);
  //cameraSetup();
  lights();

  float secs = timer();
  
    newCam(secs);

  //secs += 2;
  
  
  ground();
  
  b.dropBall(secs);
  
  if (secs > 5 && secs < 7) {
    b.kill();
    sp.splash(secs);
  }
  
  if (secs > 7 && secs< 12) {
    fill(255,20);
    pushMatrix();
    translate(0,0,0);
    rect(0,0,width, height);
    popMatrix();
    //delay(30);
    //background(60);
    sp.up(secs);

  }
  if (secs > 12) {
    if (secs < 13) background(0);
    pushMatrix();
    
    translate(0,-600,0);
    sp.down();
    stroke(255);
    fill(0,255,0);
    sphereDetail(3);
    rotateY(PI/secs);
    sphere(200);
    
    popMatrix();
    
    
    pushMatrix();
      int j = 0;
      while (j<100+10*secs) {
        fill(255,20);
        translate(random(-width, width), random(-height,height),random(-1000,1000));
        sphere(random(150,300));
        j++;
      }
    popMatrix();
  }
}

void terGen() {
  
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    
    yoff += 0.2;
  }

  stroke(255,0,0);
  //noFill();

  pushMatrix();
    translate(-width, 0,-width);
    rotateX(PI/2);
    for (int y = 0; y < rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      }
      endShape();
    }
  popMatrix();
}