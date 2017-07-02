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

void newCam(PGraphics pg, float s){
  //while
  pg.camera(200*s,-5000+500*s,200*cos(s),0,50*s,0,0,1,0);

  if(s>= 8) {
    //println(s);
    float T3=s-8;
    pg.camera(200*8 +50*T3,-5000+500*8+500*cos(T3),200*cos(8)+5000*sin(T3),0,50*8,0,0,1,0); 
  }
  
  if(s>=12) {
    float T4=s-12;
    pg.camera(200*8 +50*12,-5000+500*8+500*cos(12),200*cos(8)+5000*sin(12),0,50*8,0,0,1,0);
  }
  
  if(s>= 16) {
    //println(s);
    float T3=s-8;
    pg.camera(200*8 +50*T3,-5000+500*8+500*cos(T3),200*cos(8)+5000*sin(T3),0,50*8,0,0,1,0); 
  }
}

void axis(PGraphics pg) {
  pg.stroke(255, 0, 0);
  pg.line(-1000, 0, 0, 1000, 0, 0);
  pg.stroke(0, 255, 0);
  pg.line(0, -1000, 0, 0, 1000, 0);
  pg.stroke(0, 0, 255);
  pg.line(0, 0, -1000, 0, 0, 1000);
  pg.stroke(0);
}

float timer(float startingTimeMillis) {
  float secs = (millis()-startingTimeMillis) / 1000.0;
  return secs;
}

void drawSplash(PGraphics pg, float startingTimeMillis) {
  pg.beginDraw();
  float secs = timer(startingTimeMillis);
  //  axis();
  pg.lights();
  newCam(pg, secs);

  if (secs < 13) pg.background(0);

  terGen(pg);

  b.dropBall(pg, secs);
  
  if (secs > 5 && secs < 7) {
    b.kill();
    sp.splash(pg, secs);
  }
  
  if (secs > 7 && secs< 12) {
    pg.fill(255,20);
    pg.pushMatrix();
    pg.translate(0,0,0);
    //pg.rect(0,0,width, height);
    pg.popMatrix();
    //delay(30);
    //background(60);
    sp.up(pg, secs);
  }
  
  if (secs > 12) {
    if (secs < 13) pg.background(0);
    pg.pushMatrix();
    
    pg.translate(0,-600,0);
    sp.down();
    pg.stroke(255);
    pg.fill(0,255,0);
    pg.sphereDetail(7);
    pg.rotateY(PI/secs);
    pg.sphere(200);
    
    pg.popMatrix();
    
    pg.pushMatrix();
      int j = 0;
      while (j<100+10*secs) {
        pg.fill(255,20);
        pg.translate(random(-width, width), random(-height,height),random(-1000,1000));
        pg.sphere(random(150,300));
        j++;
      }
    pg.popMatrix();
  }
  pg.endDraw();
}

void terGen(PGraphics pg) {
  
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    
    yoff += 0.2;
  }

  pg.stroke(255,0,0);
  //noFill();

  pg.pushMatrix();
  pg.translate(-width, 0,-width);
  pg.rotateX(PI/2);
  for (int y = 0; y < rows-1; y++) {
    pg.beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      pg.vertex(x*scl, y*scl, terrain[x][y]);
      pg.vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
      pg.endShape();
    }
  pg.popMatrix();
}