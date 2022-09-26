class TabbedScreen extends Screen{
  Icon[] icons;
  Screen[] screens;
  int activeScreen;
  private float w,h;
  private float pad=5*scale;
  void draw(float wid,float hei){
    super.draw(w,h);
    float th=tabRows()*tabHeight;
    drawTabs();
    translate(pad,pad+th);
    screens[activeScreen].draw(w-2*pad,h-2*pad-th);
  }
  
  int tabRows(){
    float w=0;
    int rows=1;
    for(Icon i:icons){
      w+=i.w;
      if(w>this.w-2*pad){
        w=i.w;
        rows++;
      }
    }
    return rows;
  }
}