class Splat {
  boolean dead = false;
  boolean up = false;
  float pos;
  
  void kill() {
    this.dead = true;
  }
  
  void up(float s) {
    up = true;
    bounce(s);
  }
  
  void down() {
    up = false;
  }
  
  void splash(float s) {
    if (dead || up) return;
    
    pushMatrix();
    
      rotateY(PI/5);
      //axis();
      fill(100, 255, 100);
    
      sphereDetail(3);
      int i = 1;
      stroke(255);
      while (i<30) {
        pushMatrix();
          pos = 100*s;
          translate(100*s,0,0);
          //translate(abs((s*10)) * -2000 / s,0,0);
          sphere(50);
          i++;
        popMatrix();
        rotateY(PI/5);
      } 
      i=1;

    popMatrix();
  }
  
   void bounce(float s) {
    if (!up) return;
    
    pushMatrix();

      rotateY(PI/5);
      axis();
      fill(100, 255, 100);
    
      sphereDetail(1);
      int i = 1;
      while (i<s+30) {
        rotateY(s*(PI/4));
        translate(0,0,0);
        
        pushMatrix();
          translate(pos-50*s,-100*s+pos,0);
          stroke(255,200,200);
          sphere(50);
          i++;
        popMatrix();
        
        rotateY(PI/5);
      }
      i=1;
           
    popMatrix();
  }
}