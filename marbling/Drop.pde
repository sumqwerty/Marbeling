class Drop{
  public int id = 0;
  public final int circleDetail;
  public PVector center;
  public PVector centerOfMass;
  public ArrayList<PVector> vertices;
  public float radius;
  boolean colorfull;
  color col;
  Drop(float x, float y, float r){
    id = sz;
    ++sz;
    circleDetail = 400;
    center = new PVector(x,y);
    centerOfMass = new PVector(x,y);
    radius = r;
    colorfull = true;
    vertices = new ArrayList<PVector>();
    
    for(int i=0; i<circleDetail; ++i){
      float angle = map(i,0,circleDetail,0,TWO_PI);
      PVector v = new PVector(cos(angle),sin(angle));
      v.mult(radius);
      v.add(center);
      vertices.add(v);
    }
    if(colorfull)col = color(random(0,255),random(0,255),random(0,255));
    else col = color(random(0,255));
  }
  
  void calcCOM(){
    float xcom = 0;
    float ycom = 0;
    for(PVector v : vertices){
        xcom += v.x;
        ycom += v.y;
    }
    xcom = xcom/circleDetail;
    ycom = ycom/circleDetail;
    centerOfMass.x = xcom;
    centerOfMass.y = ycom;
  }
  
  void tarc(float r, float x, float y, float z, float c){
    float u = 1 / pow(2,1/c);
    PVector b = new PVector(x,y);
    for(PVector v : vertices){
      PVector pb = PVector.sub(v,b);
      float d = abs(pb.mag()-r);
      float l = z * pow(u,d);
      float a = l / pb.mag();
      float finalX = pb.x*cos(degrees(a)) - pb.y*sin(degrees(a));
      float finalY = pb.x*sin(degrees(a)) + pb.y*cos(degrees(a));
      PVector finalV = new PVector(finalX,finalY);
      b.add(finalV);
      v.set(b);
    }
    calcCOM();
    
  }
  
  void tine(PVector m, float x, float y, float z, float c){
    float u = 1 / pow(2,1/c);
    PVector b = new PVector(x,y);
    for(PVector v : vertices){
      PVector pb = PVector.sub(v,b);
      //if(degrees(PVector.angleBetween(pb,m)) <= 90){
        PVector n = m.copy().rotate(HALF_PI);
        float d = abs(pb.dot(n));
        float mag = z * pow(u,d);
        v.add(m.copy().mult(mag));
      //}
    }
    calcCOM();
  }
  
  
  void marble(Drop other){
    for(PVector v : vertices){
      PVector c = other.center;
      float r = other.radius;
      PVector p = v.copy();
      p.sub(c);
      float m = p.mag();
      float root = sqrt(1 + ((r*r)/(m*m)));
      p.mult(root);
      p.add(c);
      v.set(p);
    }
    calcCOM();
  }
  
  void show(){
    fill(col);
    noStroke();
    //stroke(col);
    //noFill();
    beginShape();
    for(PVector v : vertices){
      vertex(v.x,v.y);
    }
    endShape();
  }
}
