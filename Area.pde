interface Area {
  boolean contains(float x, float y);
  void draw();
}

class RectArea implements Area {
  float x, y, w, h;
  RectArea(float xIn, float yIn, float wIn, float hIn) {
    x=xIn;
    y=yIn;
    w=wIn;
    h=hIn;
  }

  boolean contains(float mx, float my) {
    return mx>x&&
      my>y&&
      mx<x+w&&
      my<y+h;
  }
  
  void draw(){
    rect(x,y,w,h);
  }
}

class CircleArea implements Area{
  float x, y, r;
  CircleArea(float xIn, float yIn, float rIn) {
    x=xIn;
    y=yIn;
    r=rIn;
  }

  boolean contains(float mx, float my) {
    return dist(x,y,mx,my)<r;
  }
  
  void draw(){
    ellipse(x,y,r*2,r*2);
  }
}