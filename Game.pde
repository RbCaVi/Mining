float scale, gameScale;
Screen game;
Screen waterPlanet, earthPlanet, airPlanet;

float[] txh=new float[10], tyh=new float[10];
float tx, ty;
int thi;

void translateT(float x, float y) {
  translate(x,y);
  tx+=x;
  ty+=y;
  for(TouchEvent.Pointer p:touches){
    p.x-=x;
    p.y-=y;
  }
}
void pushTMat() {
  pushMatrix();
  txh[thi]=tx;
  tyh[thi]=ty;
  tx=0;
  ty=0;
  thi++;
}
void popTMat() {
  popMatrix();
  thi--;
  for(TouchEvent.Pointer p:touches){
    p.x+=tx;
    p.y+=ty;
  }
  tx=txh[thi];
  ty=tyh[thi];
}

void setup() {
  scale=displayDensity;
  gameScale=scale*50;
  
  TabbedScreen ts= new TabbedScreen ();

  Joystick j=new JoystickArea(new RectArea(width/2, 0, width, height), 50);
  Controller controls=new Controller(new Button(new RectArea(0, 3*height/4, width/2, height/4)), new Button(new RectArea(width/2, 3*height/4, width/2, height/4)), j);
  Player p=new WaterPlayer(controls);
  Terrain t=new Terrain(5, 5);
  t.get(2, 2).filled=true;
  p.terrain=t;

  waterPlanet=new PlanetScreen(controls, t, p);
  
  ts.addTab(new NoneIcon(100*scale,20*scale),waterPlanet);
  
  j=new JoystickArea(new RectArea(width/2, 0, width, height), 50);
  controls=new Controller(new Button(new RectArea(0, 3*height/4, width/2, height/4)), new Button(new RectArea(width/2, 3*height/4, width/2, height/4)), j);
  p=new WaterPlayer(controls);
  t=new Terrain(5, 5);
  t.get(2, 2).filled=true;
  p.terrain=t;

  waterPlanet=new PlanetScreen(controls, t, p);

  ts.addTab(new NoneIcon(100*scale,20*scale),waterPlanet);

  game=ts;
}
void draw() {
  background(0, 40, 120, 255);
  game.draw();
  game.update();
}

void touchStarted() {
  game.touchStart();
}

void touchMoved() {
  game.touchMove();
}

void touchEnded() {
  game.touchEnd();
}
