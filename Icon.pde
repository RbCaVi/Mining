abstract class Icon{
  float w,h;
  abstract void draw(float x, float y);
}

class NoneIcon extends Icon{
  NoneIcon(float wid,float hei){
    w=wid;
    h=hei;
  }
  void draw(float x,float y){}
}