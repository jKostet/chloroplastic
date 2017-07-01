class Ball {
  float ypos = 0.0;
  boolean dead = false;
   
  void kill(){
    dead = true;
  }
   
  void dropBall(float s) {
    if (dead) return;
        
    fill(100, 255, 100);
    pushMatrix();
    
      float sphereRadius = 100;
      //float sphereY = abs(sin(s*-1.0)) * -10000.0 / 10*s;
      float sphereY = -5000 +1000*s;
      
      // Move the sphere up so it doesn't intersect with the plane
      translate(0, -sphereRadius);
      // Apply the bouncing motion trajectory
      translate(0, sphereY, 0);
      
      // Note that this rotation should be considered happening *before* the
      // translations specified above. The transformations are written in the reverse
      // order they are actually applied to the rendered object. Yes, it's confusing.
      rotateY(s*5);
      
      // Draw the sphere
      stroke(255);
      rotateX(s*5);
      sphereDetail(10);
      sphere(sphereRadius);
    popMatrix();
    
    //println(sphereY + ", " + s + ", " + secs);
  }
  
  
}