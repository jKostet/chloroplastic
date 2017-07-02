class Ball {
  float ypos = 0.0;
  boolean dead = false;
  float sphereRadius = 100;

   
  void kill(){
    dead = true;
  }
   
  void dropBall(PGraphics pg, float s) {
    if (dead) return;
        
    pg.fill(100, 255, 100);
    pg.pushMatrix();
    
      //float sphereY = abs(sin(s*-1.0)) * -10000.0 / 10*s;
      float sphereY = -5000 +1000*s;
      
      // Move the sphere up so it doesn't intersect with the plane
      pg.translate(0, -sphereRadius);
      // Apply the bouncing motion trajectory
      pg.translate(0, sphereY, 0);
      
      // Note that this rotation should be considered happening *before* the
      // translations specified above. The transformations are written in the reverse
      // order they are actually applied to the rendered object. Yes, it's confusing.
      pg.rotateY(s*5);
      
      // Draw the sphere
      pg.stroke(255);
      pg.rotateX(s*5);
      pg.sphereDetail(10);
      pg.sphere(sphereRadius);
    pg.popMatrix();
    
    //println(sphereY + ", " + s + ", " + secs);
  }
  
  
}