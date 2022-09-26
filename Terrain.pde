class Terrain {
  private Tile[][] tiles;
  int wid,hei;

  Terrain(int x, int y) {
    wid=x;
    hei=y;
    tiles=new Tile[x][y];
    for (int xi=0; xi<tiles.length; xi++) {
      for (int yi=0; yi<tiles[0].length; yi++) {
        tiles[xi][yi]=emptyTile();
      }
    }
  }

  Tile get(int x, int y) {
    if (y>=tiles.length) {
      return hardTile();
    }
    if (y<0) {
      return emptyTile();
    }
    x%=tiles.length;
    x+=x>=0?0:tiles.length;
    return tiles[x][y];
  }

  void set(int x, int y, Tile t) {
    if (y>=tiles.length||y<0) {
      return;
    }
    x%=tiles.length;
    x+=x>0?0:tiles.length;
    tiles[x][y]=t;
  }

  void draw(Camera c) {
    for (int xi=round(c.x-width/(gameScale))-2; xi<round(c.x+width/(2*gameScale))+2; xi++) {
      for (int yi=0; yi<tiles[0].length; yi++) {
        pushMatrix();
        get(xi,yi).draw(xi,yi,c);
        popMatrix();
      }
    }
  }
  void tick(EntityManager e) {
    for (int xi=0; xi<tiles.length; xi++) {
      for (int yi=0; yi<tiles[0].length; yi++) {
        tiles[xi][yi].tick(e);
      }
    }
  }
}

class Tile {
  boolean filled;
  PImage image;

  void draw(int xi,int yi,Camera c) {
    pushMatrix();
    if(filled){
      fill(180);
    }else{
      fill(128,50);
      stroke(0,120);
    }
    translate(width/2,height/2);
    translate(gameScale*(xi-c.x),gameScale*(yi-c.y));
    rect(0, 0, gameScale, gameScale);
    popMatrix();
    stroke(0);
  }
  void tick(EntityManager manager) {
  }
  boolean canmine(Direction dir) {
    return true;
  }
}

enum Direction {
  UP, DOWN, LEFT, RIGHT
}

class HardTile extends Tile {
  HardTile(boolean f) {
    filled=f;
  }
  boolean canmine(Direction dir) {
    return false;
  }
}

Tile emptyTile() {
  Tile t=new Tile();
  t.filled=false;
  return t;
}
Tile hardTile() {
  return new HardTile(true);
}
