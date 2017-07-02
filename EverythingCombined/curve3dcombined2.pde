void drawCurve(PGraphics pg, float startingTimeMillis) {
  pg.beginDraw();
  pg.lights();
  pg.background(0); 
  pg.translate(width/2,height/2,0); //change frame of reference to point (0,0,0)
  //camera(20, 138, 80, 0, 0, 0, 0, 0, -1);
  // camera(2*mouseX, 2*mouseY, 80, 0, 0, 0, 0, 0, -1); 
   
   //Ball b0 = new Ball();
   //b0.dropBall(pg, 5);
   pg.noFill();
   pg.stroke(255);
   float dt = millis()-startingTimeMillis; //time doesn't start at 0ms, so this -850 is to compensate
   float t=dt/float(1000); //the elapsed time from the start of the demo

  
   PVector origin=new PVector(0,0,0);
   float sizeX=100;
   float sizeY=100;
   int k=1;

    //camera starting position
   pg.camera(20/pow((2.3-2)/k,1), 30/pow((2.3-2)/k,1.5), -pow((2.3-2)/k,4)+100, 0, 0, -pow((2.3-2)/k,4)+100 - 100, 0, 0, -1);
    
    //camera stays in place for 2.3 and then starts to move
    if(t>=2.3){
   pg.camera(20/pow((t-2)/k,1), 30/pow((t-2)/k,1.5), -pow((t-2)/k,4)+100, 0, 0, -pow((t-2)/k,4)+100 - 100, 0, 0, -1);
    }

   //drawCoordinateSystem(origin,sizeX);
   drawFloor2(pg, origin);
    
   //start another time T2
   float T2=0;
  
    if (t>=3) {
      T2=t-3; 
      for (int i = 0; i <= 20; i+=1) {
        PVector ringloc1 = new PVector(50*cos(i*2*PI/20),50*sin(i*2*PI/20),0); 
        drawRing(pg, ringloc1, 0+1*log(i)*log(20*T2+1),50,1, exp(-T2+6));
        //drawRing(origin, i*200*exp(-pow(t-10,2)),50,1, 250);
      }
    }
  
    //start new time T1
    float T1=0;
  
    //if enough time has elapsed, then launch rings
    if (t>=5.1) {
       T1=t-5.1; 
       PVector ringloc2 = new PVector(origin.x,origin.y,-400);
       for (int i = 0; i <= 20; i+=1) {
         drawRing(pg, ringloc2, 0+8*log(i)*log(20*T1+1),50,1, exp(-T1+6));
         //drawRing(origin, i*200*exp(-pow(t-10,2)),50,1, 250);
       }
    }
    
      //pg.fill(100, 255, 100);
      
    //the sphere before camera start moving  
    if (t <= 2.5) {
        pg.sphereDetail(20);
           pg.sphere(5);  
    }
 
   //the sphere starts to drop
    if (t >= 2.5) {
     pg.sphereDetail(20);
    pg.pushMatrix();
    pg.translate(0,0,-100*(pow((t-2.5),1.3)));
     pg.sphere(5); 
     pg.popMatrix();
    }
    
   pg.endDraw();
   
}

void drawCoordinateSystem(PGraphics pg, PVector location, float size) {
  PVector origin = location;
  float sizeX = size;
  float sizeY = size;
  
  pg.strokeWeight(1);
  //draw x-axis
  pg.stroke(255,0,0);
  pg.line(origin.x,origin.y,origin.z,sizeX,origin.y,origin.z);
  //draw y-axis
  pg.stroke(0,255,0);
  pg.line(origin.x,origin.y,origin.z,origin.x,sizeX,origin.z);
  //draw z-axis
  pg.stroke(0,0,255);
  pg.line(origin.x,origin.y,origin.z,origin.x,origin.y,sizeX);

  pg.stroke(255);
  pg.strokeWeight(1);
  pg.rectMode(CENTER);
  pg.rect(origin.x,origin.y,sizeX,sizeY);
 
  float n=20;
  //set thickness for grid
  pg.strokeWeight(0.3);
  for (int i =0; i < 3; i+=1) {
    pg.line(origin.x - sizeX/2, origin.y + n*i, 0, origin.x+sizeX/2, origin.y+n*i,0);
    pg.line(origin.x +n*i,origin.y - sizeY/2, 0,origin.x +n*i,origin.y+sizeY/2,0);
    pg.line(origin.x - sizeX/2, origin.y - n*i, 0, origin.x+sizeX/2, origin.y-n*i,0);
    pg.line(origin.x -n*i,origin.y - sizeY/2, 0,origin.x -n*i,origin.y+sizeY/2,0);
  }
}

void drawFloor(PGraphics pg, PVector Origin) {
   PVector origin = Origin;
   int size = 100;
   pg.fill(255);
   pg.stroke(0);
   //strokeWeight(1);
   pg.rectMode(CENTER);
   pg.rect(origin.x,origin.y,size,size);
   pg.fill(0);
   pg.ellipse(origin.x, origin.y, 15,15);
 }
 
 void drawFloor2(PGraphics pg, PVector Origin) {
   PVector origin = Origin;
   int offset=50;
   pg.fill(100);
   pg.noStroke();
   pg.rectMode(CENTER);
   pg.rect(origin.x-offset, origin.y, 80,150);
   pg.rect(origin.x+offset,origin.y,80,150);
   pg.rect(origin.x,origin.y-offset,150,80);
   pg.rect(origin.x, origin.y+offset,150,80);
 }
 
 void drawRing(PGraphics pg, PVector centerPoint,float Radius,int Smoothness,float Thickness, float AlphaChannel){
   PVector[] points = new PVector[0]; 
   PVector center = centerPoint;      
   float radius =Radius;
   int smoothness=Smoothness;  
   pg.stroke(255, AlphaChannel);
   pg.strokeWeight(Thickness);
   
   for (int i = 0; i <= smoothness-1; i+=1) {
     points = (PVector[])append(points,new PVector(center.x+radius*cos(i*2*PI/smoothness),center.y+radius*sin(i*2*PI/smoothness),center.z));
   }
   for (int i = 0; i <= smoothness-2; i+=1) {
     pg.line(points[i].x,points[i].y,points[i].z,points[i+1].x,points[i+1].y,points[i+1].z);
   } 
   pg.line(points[smoothness-1].x,points[smoothness-1].y,points[smoothness-1].z,points[0].x,points[0].y,points[0].z);

}
 