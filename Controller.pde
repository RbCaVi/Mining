class Controller implements GUIObject{
  Button jump, dig;
  Joystick dir;

  Controller(Button jumpIn, Button digIn, Joystick dirIn) {
    jump=jumpIn;
    dig=digIn;
    dir=dirIn;
  }

  void setListener(PressListener lis) {
    jump.press=lis;
  }
  
  void touchStart(){
    jump.touchStart();
    dig.touchStart();
    dir.touchStart();
  }
  void touchMove(){
    jump.touchMove();
    dig.touchMove();
    dir.touchMove();
  }
  void touchEnd(){
    jump.touchEnd();
    dig.touchEnd();
    dir.touchEnd();
  }
  void draw(){
    jump.draw();
    dig.draw();
    dir.draw();
  }
}