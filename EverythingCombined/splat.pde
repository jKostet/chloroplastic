class Splat {
  boolean dead = false;
  boolean up = false;
  float pos;
  
  void kill() {
    this.dead = true;
  }
  
  void up(PGraphics pg, float s) {
    up = true;
    bounce(pg, s);
  }
  
  void down() {
    up = false;
  }
  
  void splash(PGraphics pg, float s) {
    if (dead || up) return;
    
    pg.pushMatrix();
    
      pg.rotateY(PI/5);
      //axis();
      pg.fill(100, 255, 100);
    
      pg.sphereDetail(3);
      int i = 1;
      pg.stroke(255);
      while (i<30) {
        pg.pushMatrix();
          pos = 100*s;
          pg.translate(100*s,0,0);
          //translate(abs((s*10)) * -2000 / s,0,0);
          pg.sphere(50);
          i++;
        pg.popMatrix();
        pg.rotateY(PI/5);
      } 
      i=1;

    pg.popMatrix();
  }
  
   void bounce(PGraphics pg, float s) {
    if (!up) return;
    
    pg.pushMatrix();

      pg.rotateY(PI/5);
      axis(pg);
      pg.fill(100, 255, 100);
    
      pg.sphereDetail(1);
      int i = 1;
      while (i<s+30) {
        pg.rotateY(s*(PI/4));
        pg.translate(0,0,0);
        
        pg.pushMatrix();
        pg.translate(pos-50*s,-100*s+pos,0);
        pg.stroke(255,200,200);
        pg.sphere(50);
        i++;
        pg.popMatrix();
        
        pg.rotateY(PI/5);
      }
      i=1;
           
    pg.popMatrix();
  }
}