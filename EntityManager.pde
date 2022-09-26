class EntityManager{
  ArrayList<Entity> entities;
  
  EntityManager(){
    entities=new ArrayList<Entity>();
  }
  
  void tick(){
    for(int i=entities.size()-1; i>=0; i--){
      Entity e=entities.get(i);
      e.tick();
      if(e.toremove){
        entities.remove(i);
      }
    }
  }
  
  void add(Entity e){
    entities.add(e);
  }
  
  void reset(){
    entities=new ArrayList<Entity>();
  }
  
  void draw(Camera c){
    for(Entity e:entities){
      e.draw(c);
    }
  }
}