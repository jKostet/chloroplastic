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
  rows = h / scl;
  terrain = new float[cols][rows];
}

void newCam(float s){
  //while
  camera(200*s,-5000+500*s,200*cos(s),0,50*s,0,0,1,0);



  if(s>= 8) {
      println(s);
    float T3=s-8;
   camera(200*8 +50*T3,-5000+500*8+500*cos(T3),200*cos(8)+5000*sin(T3),0,50*8,0,0,1,0); 
  }
  
    if(s>=12) {
   float T4=s-12;
   camera(200*8 +50*12,-5000+500*8+500*cos(12),200*cos(8)+5000*sin(12),0,50*8,0,0,1,0);
  }
  
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
  float secs = timer();
//  axis();
  lights();
  newCam(secs);

  if (secs < 13) background(0);

  terGen();

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