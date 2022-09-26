abstract class Screen {
  protected float w,h;
  final void draw() {
    draw(width, height);
  }
  final void touchStart() {
    touchStart(width, height);
  }
  final void touchMove() {
    touchMove(width, height);
  }
  final void touchEnd() {
    touchEnd(width, height);
  }
  void draw(float wid, float hei){
    w=wid;
    h=hei;
  };
  abstract void touchStart(float w, float h);
  abstract void touchMove(float w, float h);
  abstract void touchEnd(float w, float h);
  abstract void update();
}

class PlanetScreen extends Screen {
  Controller controls;
  Terrain terrain;
  Camera camera;
  Player player;
  EntityManager entities;
  PlanetScreen(Controller c, Terrain t, Player p) {
    controls=c;
    terrain=t;
    player=p;
    entities=new EntityManager();
  }

  void update() {
    player.tick(entities);
    terrain.tick(entities);
    entities.tick();
  }

  void draw(float w, float h) {
    super.draw(w,h);
    //background(255);
    camera=player.getCamera(w, h);
    pushMatrix();
    terrain.draw(camera);
    player.draw(camera);
    entities.draw(camera);
    popMatrix();
    controls.draw();
  }

  void touchStart(float w, float h) {
    controls.touchStart();
  }

  void touchMove(float w, float h) {
    controls.touchMove();
  }

  void touchEnd(float w, float h) {
    controls.touchEnd();
  }
}
