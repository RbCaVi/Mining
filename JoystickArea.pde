class JoystickArea extends Joystick {
  Area area;
  JoystickArea(Area a, float radius) {
    area=a;
    r=radius*scale;
    hatrad=20*scale;
  }

  void draw() {
    pushMatrix();
    if (touched) {
      stroke(127, 127);
      strokeWeight(3);
      noFill();
      ellipse(x, y, 2*r, 2*r);
      noStroke();
      fill(255,180);
      ellipse(x+dx*r, y+dy*r, hatrad*2, hatrad*2);
      strokeWeight(1);
      stroke(0);
      fill(255);
    }
    popMatrix();
  }

  void touchStart() {
    if (!touched) {
      touchid=touches[touches.length-1].id;
      touchx=touches[touches.length-1].x;
      touchy=touches[touches.length-1].y;
      rdx=0;
      rdy=0;
      update();
      if (area.contains(touchx, touchy)) {
        x=touchx;
        y=touchy;
        touched=true;
      }
    }
  }
  
  void touchMove() {
    if (touched) {
      int idx=-1;
      for (int i=0; i<touches.length; i++ ) {
        if (touches[i].id==touchid) {
          idx=i;
          break;
        }
      }
      if (idx==-1) {
        touched=false;
        rdx=0;
        rdy=0;
        return;
      }
      rdx-=touchx;
      rdy-=touchy;
      touchx=touches[idx].x;
      touchy=touches[idx].y;
      rdx+=touchx;
      rdy+=touchy;
      update();
    }
  }

  void touchEnd() {
    if (touched) {
      touched=false;
      for (int i=0; i<touches.length; i++ ) {
        touchid=touches[i].id;
        touchx=touches[i].x;
        touchy=touches[i].y;
        // can release the joystick when a
        // touch is released and the joystick
        // touch is moving at high speed
        // or link the joystick to the wrong
        // touch if it's too close to the
        // joystick touch
        if (dist(x+rdx, y+rdy, touchx, touchy)<20*scale) {
          touched=true;
          return;
        }
      }
      rdx=0;
      rdy=0;
      update();
      /*
      // Processing uses the index of the
       // touch as its id so just test all
       // touches to see if it's deleted
       int idx=-1;
       for (int i=0; i<touches.length; i++ ) {
       println(touches[i].id);
       if (touches[i].id==touchid) {
       idx=i;
       break;
       }
       }
       if (idx==-1) {
       touched=false;
       rdx=0;
       rdy=0;
       update();
       return;
       }*/
    }
  }

  protected void update() {
    dx=rdx/r;
    dy=rdy/r;
    if (mag(dx, dy)>1) {
      float m=mag(dx, dy);
      dx/=m;
      dy/=m;
    }
  }

  void release() {
    touched=false;
    rdx=0;
    rdy=0;
    update();
  }
}
