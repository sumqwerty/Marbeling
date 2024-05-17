import java.util.Iterator;
ArrayList<Drop> drops;
float angle = 0;
int sz = 0;
boolean dir=false;
boolean capture=true;
boolean debug = false;
Flowfield f1;
int scl = 10;
int cols, rows;


void setup(){
  size(500,500);
  cols = width/scl;
  rows = height/scl;
  f1 = new Flowfield(color(0,0,255),5);
  drops = new ArrayList<Drop>();
  //blendMode(DIFFERENCE);
  //for (int i = 0; i < 50; i++) {
  //  addInk(random(width),random(height),random(20,80));
  //}
  
  //for (int i = 0; i < 10; i++) {
  //  addInk(width/2,height/2,50);
  //}
  
  //f1.run();
  //tineField();
  //for (int x = 0; x < 800; x+=10) {
  //  addInk(400+x,400+(sin(x)*100),20);
  //}
}

void tineField(){
  f1.run();
  for(int y=0; y < rows; ++y)
    {
      for(int x=0; x < cols; ++x){
        //println(y,"/",rows);
        int index = (x + y * cols);
        tineLine(f1.flowfields[index],x*scl,y*scl,6,20);
        
      }
    }
}

void keyPressed(){
  if(key=='b')dir=!dir;
  else if(key=='c')capture=!capture;
  else if(key == 't')tineField();
}

void mouseDragged(){
  PVector v1 = new PVector(pmouseX,pmouseY);
  PVector v2 = new PVector(mouseX,mouseY);
  v2.sub(v1);
  if(v2.mag() > 0.1){
    v2.normalize();
    tineLine(v2,mouseX,mouseY,2,10);
  }
}

void tineLine(PVector v, float x, float y, float z, float c){
  for(Drop drop : drops){
    drop.tine(v,x,y,z,c);
  }
}

void tineArc(float r, float x, float y, float z, float c){
  noFill();
  stroke(255,0,0);
  circle(x,y,r);
  for(Drop drop : drops){
    drop.tarc(r,x,y,z,c);
  }
}
void addInk(float x, float y, float r){
  for(int i=0; i<1; ++i){
    Drop drop = new Drop(x,y,r);
    for(Drop other : drops){
      other.marble(drop);
    }
    drops.add(drop);
  }
}

void clearDrops(){
  if(drops.size() > 500){
    for(int i=0; i<100; ++i){
      drops.remove(0);
    }
  }
  else{
    Iterator<Drop> iter = drops.iterator();
    while (iter.hasNext()) {
        Drop drop = iter.next();
        if(drop.centerOfMass.x < -2*drop.radius || drop.centerOfMass.x > (width+(2*drop.radius)) || drop.centerOfMass.y < -2*drop.radius || drop.centerOfMass.y > (height+(2*drop.radius)))
            iter.remove();
    }
  }
  //if(drops.size() < 10){
  //  for (int i = 0; i < 40; i++) {
  //    addInk(random(width),random(height),random(20,80));
  //  }
  //}
}

void draw(){
  background(255);
  addInk(width/2,height/2,random(10,60));
  //addInk(width/2,height/2,random(20,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(10,80));  
  //addInk(random(width),random(height),random(10,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(20,80));  
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(20,80));
  //addInk(random(width),random(height),random(10,80));
  //addInk(random(width),random(height),random(10,80));

  //addInk(width/2,height/2,random(10,80));
  //PVector v;
  //PVector v2; 
  //angle+=10;
  //if(angle > 360)angle=0;
  //if(dir){
  //  v = new PVector(cos(radians(angle)),-sin(radians(angle)));
  //  v2 = new PVector(-sin(radians(angle)),cos(radians(angle))/2);
  //}
  //else{
  //  v = new PVector(cos(radians(angle)),sin(radians(angle)));
  //  v2 = new PVector(-sin(radians(angle)),cos(radians(angle))/2);
  //}
  //v.normalize();
  //v2.normalize();
  //tineLine(v,height/2,width/2,20,50);
  //tineLine(v2,height/2,width/2,20,50);
  //tineArc(600,width/2-450,height/2,20,20);
  for(Drop drop : drops){
    drop.show();
  }
  tineField();
  clearDrops();
  if(capture)saveFrame("output13/#####.png");
}
