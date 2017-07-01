void setup() {
  size(1000,500, P3D);
 background(0); 
}

void draw() {
  lights();
  background(0); 
   translate(width/2,height/2,0); //change frame of reference to point (0,0,0)
  //camera(20, 138, 80, 0, 0, 0, 0, 0, -1);
  // camera(2*mouseX, 2*mouseY, 80, 0, 0, 0, 0, 0, -1); 
   
   noFill();
   stroke(255);
   float dt = millis()-850; //time doesn't start at 0ms, so this -850 is to compensate
   float t=dt/float(1000); //the elapsed time from the start of the demo

  
 PVector origin=new PVector(0,0,0);
  float sizeX=100;
   float sizeY=100;
  int k=1;

PVector path1=new PVector(20/pow(t/k,1),30/pow(t/k,1.5),-pow(t/k,4)+100);

 camera(path1.x, path1.y, path1.z, 0, 0, path1.z - 100, 0, 0, -1);
 
 //drawCoordinateSystem(origin,sizeX);
  drawFloor2(origin);
  
  //start another time T2
  float T2=0;
  
  if (t>=1) {
   T2=t-1; 
   for (int i = 0; i <= 20; i+=1) {
           PVector ringloc1 = new PVector(50*cos(i*2*PI/20),50*sin(i*2*PI/20),0); 
    drawRing(ringloc1, 0+1*log(i)*log(20*T2+1),50,1, exp(-T2+6));
    //drawRing(origin, i*200*exp(-pow(t-10,2)),50,1, 250);
  }
  }
  
  //start new time T1
  float T1=0;
  
  //if enough time has elapsed, then launch rings
  if (t>=3.1) {
   T1=t-3.1; 
     PVector ringloc2 = new PVector(origin.x,origin.y,-400);
   for (int i = 0; i <= 20; i+=1) {
    drawRing(ringloc2, 0+8*log(i)*log(20*T1+1),50,1, exp(-T1+6));
    //drawRing(origin, i*200*exp(-pow(t-10,2)),50,1, 250);
  }
 }

 
}

   

void drawCoordinateSystem(PVector location, float size) {
 PVector origin = location;
  float sizeX = size;
  float sizeY = size;
  
  strokeWeight(1);
 //draw x-axis
 stroke(255,0,0);
 line(origin.x,origin.y,origin.z,sizeX,origin.y,origin.z);
  //draw y-axis
 stroke(0,255,0);
  line(origin.x,origin.y,origin.z,origin.x,sizeX,origin.z);
  //draw z-axis
 stroke(0,0,255);
  line(origin.x,origin.y,origin.z,origin.x,origin.y,sizeX);
  

 stroke(255);
 strokeWeight(1);
  rectMode(CENTER);
 rect(origin.x,origin.y,sizeX,sizeY);
 
  float n=20;
    //set thickness for grid
  strokeWeight(0.3);
 for (int i =0; i < 3; i+=1) {
 line(origin.x - sizeX/2, origin.y + n*i, 0, origin.x+sizeX/2, origin.y+n*i,0);
 line(origin.x +n*i,origin.y - sizeY/2, 0,origin.x +n*i,origin.y+sizeY/2,0);
 line(origin.x - sizeX/2, origin.y - n*i, 0, origin.x+sizeX/2, origin.y-n*i,0);
 line(origin.x -n*i,origin.y - sizeY/2, 0,origin.x -n*i,origin.y+sizeY/2,0);
 }
}

 void drawFloor(PVector Origin) {
   PVector origin = Origin;
   int size = 100;
   fill(255);
   stroke(0);
 //strokeWeight(1);
  rectMode(CENTER);
 rect(origin.x,origin.y,size,size);
 fill(0);
  ellipse(origin.x, origin.y, 15,15);
 
   
 }
 
 void drawFloor2(PVector Origin) {
      PVector origin = Origin;
      int offset=50;
      fill(100);
    noStroke();
  rectMode(CENTER);
    rect(origin.x-offset, origin.y, 80,150);
    rect(origin.x+offset,origin.y,80,150);
    rect(origin.x,origin.y-offset,150,80);
    rect(origin.x, origin.y+offset,150,80);
 }
 
    void drawRing(PVector centerPoint,float Radius,int Smoothness,float Thickness, float AlphaChannel){
       PVector[] points = new PVector[0]; 
       PVector center = centerPoint;      
       float radius =Radius;
       int smoothness=Smoothness;  
       stroke(255, AlphaChannel);
       strokeWeight(Thickness);
   
    for (int i = 0; i <= smoothness-1; i+=1) {
    points = (PVector[])append(points,new PVector(center.x+radius*cos(i*2*PI/smoothness),center.y+radius*sin(i*2*PI/smoothness),center.z));
    }
      for (int i = 0; i <= smoothness-2; i+=1) {
      line(points[i].x,points[i].y,points[i].z,points[i+1].x,points[i+1].y,points[i+1].z);
      
    } 
    line(points[smoothness-1].x,points[smoothness-1].y,points[smoothness-1].z,points[0].x,points[0].y,points[0].z);

   }
 