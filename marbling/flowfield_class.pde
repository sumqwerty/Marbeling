class Flowfield
{
  float inc = 0.1;
  float zoff = 0;
  public PVector[] flowfields;
  color debug_col;
  int fact;
  Flowfield()
  {
    
    fact = int(random(1,5));
    inc = 0.5;
    scl = 20;
    flowfields = new PVector[cols*rows];
  }
  
  
  Flowfield(color _col, int _fact)
  {
    debug_col = _col;
    fact = _fact;
    inc = 0.1;
    scl = 20;
    flowfields = new PVector[cols*rows];
  }
  
  void run()
  {
    float yoff = 0;
    for(int y=0; y < rows; ++y)
    {
      float xoff = 0;
      for(int x=0; x < cols; ++x)
      {
        
        int index = (x + y * cols);
        float angle = noise(xoff,yoff,zoff)*TWO_PI*fact;
        //if(debug_col == color(255,0,0))angle = noise(xoff,yoff,zoff)*TWO_PI;
        //else angle = noise(xoff,yoff,zoff)*TWO_PI*2;
        PVector v = PVector.fromAngle(angle);
        v.setMag(0.5);
        flowfields[index] = v;
        xoff += inc;
        if(debug)
        {
          stroke(debug_col);
          strokeWeight(1);
          push();
          translate(x * scl, y * scl);
          rotate(v.heading());
          line(0,0,scl,0);
          pop();
        }

      }
      yoff += inc;
      zoff += 0.0003;
    }
  }
    
}
