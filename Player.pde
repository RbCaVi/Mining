abstract class Player {
  float x, y,px,py, health,w=0.5,h=0.5;
  Terrain terrain;
  Controller c;
  Direction minedir;
  boolean mining;

  Player(Controller control) {
    JumpListener lis=new JumpListener(this);
    c=control;
    c.setListener(lis);
  }

  abstract void jump();

  private class JumpListener implements PressListener {
    Player player;
    JumpListener(Player p) {
      player=p;
    }
    void press() {
      player.jump();
    }
  }
  
  abstract void reset();
  
  abstract void draw(Camera c);
  
  abstract void update();
  
  final void tick(EntityManager e){
    px=x;
    py=y;
    if(!mining){
      update();
      collision();
    }else{
      updateMining();
    }
    x=x%terrain.wid;
    x+=x<0?terrain.wid:0;
  }
  
  void collision(){
    int xi=floor(px);
    int yi=floor(py);
    int xi2=ceil(px+w)-1;
    int yi2=ceil(py+h)-1;
    if(terrain.get(xi+1,yi).filled||terrain.get(xi+1,yi2).filled){
      if(x+w>xi+1){x=xi+1-w;}
      if(c.dig.pressed&&c.dir.dx>0.5){
        mining=true;
        minedir=Direction.RIGHT;
      }
    }
    if(terrain.get(xi-1,yi).filled||terrain.get(xi-1,yi2).filled){
      if(x<xi){x=xi;}
      if(c.dig.pressed&&c.dir.dx<-0.5){
        mining=true;
        minedir=Direction.LEFT;
      }
    }
    if(terrain.get(xi,yi+1).filled||terrain.get(xi2,yi+1).filled){
      if(y+h>yi+1){y=yi+1-h;}
      if(c.dig.pressed&&c.dir.dy>0.5){
        mining=true;
        minedir=Direction.DOWN;
      }
    }
    if(terrain.get(xi,yi-1).filled||terrain.get(xi2,yi-1).filled){
      if(y<yi){y=yi;}
      if(c.dig.pressed&&c.dir.dy<-0.5){
        mining=true;
        minedir=Direction.UP;
      }
    }
  }
  
  private void updateMining(){}
  
  Camera getCamera(float scrW,float scrH){
    return new Camera(x+w/2,y+h/2);
  }
}

class FloatPlayer extends Player{
  FloatPlayer(Controller control) {
    super(control);
  }
  void jump(){}
  void draw(Camera c){
    pushMatrix();
    translate(width/2,height/2);
    rect(gameScale*(x-c.x),gameScale*(y-c.y),w*gameScale,h*gameScale);
    popMatrix();
  }
  void update(){
    PVector d=new PVector(c.dir.dx,c.dir.dy);
    x+=d.x*0.1;
    y+=d.y*0.1;
  }
  void reset(){}
}

class WaterPlayer extends Player{
  float vx,vy;
  WaterPlayer(Controller control) {
    super(control);
  }
  void jump(){}
  void draw(Camera c){
    translate(width/2,height/2);
    fill(255);
    rect(gameScale*(x-c.x),gameScale*(y-c.y),w*gameScale,h*gameScale);
  }
  void update(){
    float speed=.1;
    PVector d=new PVector(c.dir.dx,c.dir.dy);
    if(mag(d.x,d.y)>.2){
      vx+=0.1*(d.x*speed-vx);
      vy+=0.1*(d.y*speed-vy);
    }
    x+=vx;
    y+=vy;
    vx*=0.95;
    vy*=0.95;
    float m=mag(vx,vy);
    vx=abs(m)<0.01*speed?0:vx;
    vy=abs(m)<0.01*speed?0:vy;
  }
  void reset(){}
}