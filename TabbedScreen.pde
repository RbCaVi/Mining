class TabbedScreen extends Screen {
  Icon[] icons;
  Screen[] screens;
  int activeScreen;
  private float pad=20*scale;
  float tabHeight=50*scale;

  TabbedScreen () {
    icons=new Icon[0];
    screens=new Screen[0];
  }

  void draw(float wid, float hei) {
    super.draw(wid, hei);
    float th=tabRows()*tabHeight;
    drawTabs();
    pushTMat();
    translateT(pad, pad+th);
    screens[activeScreen].draw(w-2*pad, h-2*pad-th);
    popTMat();
  }

  void drawTabs() {
    float tw=0;
    int row=0;
    for (Icon i : icons) {
      tw+=i.w;
      if (tw>this.w-2*pad) {
        tw=i.w;
        row++;
      }
      rect(tw-i.w+pad, pad+row*tabHeight, i.w, tabHeight);
      i.draw(tw-i.w, row*tabHeight);
    }
  }

  int tabRows() {
    float w=0;
    int rows=1;
    for (Icon i : icons) {
      w+=i.w;
      if (w>this.w-2*pad) {
        w=i.w;
        rows++;
      }
    }
    return rows;
  }

  void addTab(Icon i, Screen s) {
    icons=(Icon[])append(icons, i);
    screens=(Screen[])append(screens, s);
  }
  
  void removeTab(int i){
    icons=(Icon[])remove(icons, i);
    screens=(Screen[])remove(screens, i);
  }

  void touchStart(float w, float h) {
    float th=tabRows()*tabHeight;
    float tx=touches[touches.length-1].x;
    float ty=touches[touches.length-1].y;
    if (tx>pad&&tx<w-pad&&ty>pad&&ty<pad+th) {
      float x=pad, y=pad;
      for (int i=0; i<icons.length; i++) {
        Icon icon=icons[i];
        x+=icon.w;
        if (x>this.w-2*pad) {
          x=icon.w+pad;
          y+=tabHeight;
        }
        if(tx>x-icon.w&&tx<x&&ty>y&&ty<y+tabHeight){
          activeScreen=i;
          return;
        }
      }
    }
    pushTMat();
    translateT(pad, pad+th);
    screens[activeScreen].touchStart(w-2*pad, h-2*pad-th);
    popTMat();
  }
  void touchMove(float w, float h) {
    float th=tabRows()*tabHeight;
    pushTMat();
    translateT(pad, pad+th);
    screens[activeScreen].touchMove(w-2*pad, h-2*pad-th);
    popTMat();
  }
  void touchEnd(float w, float h) {
    float th=tabRows()*tabHeight;
    pushTMat();
    translateT(pad, pad+th);
    screens[activeScreen].touchEnd(w-2*pad, h-2*pad-th);
    popTMat();
  }
  void update() {
    screens[activeScreen].update();
  }
}
