class Button implements GUIObject {
  Area area;
  PressListener press=null;
  ReleaseListener release=null;
  boolean pressed;

  Button(Area a) {
    area=a;
  }
  Button(Area a, PressListener p) {
    area=a;
    press=p;
  }
  Button(Area a, ReleaseListener r) {
    area=a;
    release=r;
  }
  Button(Area a, PressListener p, ReleaseListener r) {
    area=a;
    press=p;
    release=r;
  }

  void update() {
    boolean wasPressed=pressed;
    pressed=false;
    for (TouchEvent.Pointer p : touches) {
      if (area.contains(p.x, p.y)) {
        pressed=true;
        break;
      }
    }
    if (!wasPressed&&pressed&&press!=null) {
      press.press();
    }
    if (wasPressed&&!pressed&&release!=null) {
      release.release();
    }
  }

  void touchStart() {
    update();
  }
  void touchMove() {
    update();
  }
  void touchEnd() {
    update();
  }
  
  void draw(){
    area.draw();
  }
}

interface PressListener {
  void press();
}

interface ReleaseListener {
  void release();
}
