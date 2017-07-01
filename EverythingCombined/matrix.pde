void drawMatrix(float startTimeMillis) {
  background(64, 64, 80);
      
  float secs = (millis()-startTimeMillis) / 1000.0;

  // Center the view
  translate(width/2, height/2, 0);
  // Move up and backwards - away from the origin
  float pi = 3.1415926535;
  float time = 20;
  float mult = 2*pi/time;
  if (secs < time) {
    translate(0, 200, (sin(mult*secs)*-200)-200);
  } else {
    translate(0, 200, (abs(sin(mult*secs))*-200)-200);
  }
  // Rotate the viewport a bit with mouse
  //rotateY((mouseX - width/2) * 0.001);
  //rotateX((mouseY - height/2) * -0.001);
  //rotateY(sin(secs) * - 0.5);
  rotateY(sin(0.2*log(secs)*secs)* 0.5);
  
  pushMatrix();
  
  scale(6.0);
  float time2 = 64;
  if (secs < time2) {
    stroke(0, 255, 100, (4*secs)%255);
  } else {
    float period = 5;
    mult = 2*pi/period;
    stroke(0, 255, 100, abs(cos(mult*(secs-time2)))*255);
  }
  for (int k = 0; k <= 2; k++) {
    strokeWeight(1);
    
    translate(0, 0, (1.8*(secs*secs))%(2*25));
    
    if (k == 1) {
      strokeWeight(0.1);
      //translate(0, 0, ((secs*secs))%(4*25));
      rotateX(PI/2);
    }
    if (k == 2) {
      rotateZ(PI/2);
    }
    for (int i = -10; i <= 10; i = i+2) {
      for (int j = -10; j <= 10; j = j+2) {
        translate(0, 0, 25*i);
        line(25*j, 4*CANVAS_HEIGHT, 25*j, -4*CANVAS_HEIGHT);
        translate(0, 0, -25*i);
      }
    }
  }
  
  popMatrix();

  lights();
  stroke(127, 127, 127);
  fill(127, 127, 127);
  
  
  // Draw the sphere
  
  pushMatrix();
  // Calculate the sphere trajectory
  float sphereX = sin(1.2*log(secs-time)*(secs-time)) * -200.0;
  float sphereRadius = 100;
  
  // Move the sphere up so it doesn't intersect with the plane
  translate(0, -sphereRadius);
  // Apply the bouncing motion trajectory
  if (secs >= time) {
    translate(sphereX, 100*sin(1.2*secs-time), 0);
  }
  if (secs >= time2) {
    translate(0, 0, -300*(secs-time2));
  }
  // Note that this rotation should be considered happening *before* the
  // translations specified above. The transformations are written in the reverse
  // order they are actually applied to the rendered object. Yes, it's confusing.
  rotateY(secs);
  
  // Draw the sphere
  sphere(sphereRadius);
  popMatrix();

  fill(255, 255, 255);
  
  // Draw one comet cube
  pushMatrix();
  
  float distance = -40000;
  float boxv = -distance/time;
  translate(0, -sphereRadius, distance+boxv*secs);
  box(100);
  
  popMatrix();
  
  // Draw moarrr comets!!
  if (secs > time && secs < time2) {
    pushMatrix();
    for (int i = 0; i < 4; i++) {
      // Some deep mathemagic follows
      float z = -40000-2000*i;
      float time0 = 1+2*i;
      float radius = 200;
      float boxv0 = z/time0;
      float x0 = 0;
      float y0 = -400;
      translate(x0+(i%2)*radius, y0+(round(1/(2*abs(i-2.5))))*radius, z-boxv0*(secs%time));
      box(100);
    }
  
    popMatrix();
  }
   
}