class State
{
  public Vec2 velocity;
  public Vec2 acceleration;
  public Vec2 position;
  public float mass;
  State()
  {
     velocity=new Vec2(); 
     acceleration=new Vec2();
     position=new Vec2(random(0,width-10),random(0,height-10));
     mass=1;
  }
  State(State s) 
  {
    velocity = new Vec2(s.velocity.x, s.velocity.y);
    acceleration = new Vec2(s.acceleration.x, s.acceleration.y);
    position = new Vec2(s.position.x, s.position.y);
    //mass = s.mass;
  }

  
}
