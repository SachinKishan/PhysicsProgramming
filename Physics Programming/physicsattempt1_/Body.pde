class Body
{
   State currentState;
   State initialState;
   color c;
   Body()
   {
      currentState=new State();
      initialState=new State();
      c=255;
   }
   void renderBody()
   {
     print("parent");
   }
void setState(State newState)
  {
      
      currentState=newState;
  }
  void setColor(color col)
  {
  
   c=col; 
  }
  void checkEdges(){}
}

class Ball extends Body
{
  
  float radius;
  Ball()
  {
    radius=1;
    currentState.mass=radius*3;

  }
  Ball(float r)
  {
      radius=r;
      currentState.mass=r*3;
  }
  void renderBody()
  {
    fill(c);
    ellipse(currentState.position.x,currentState.position.y,radius*2,radius*2);
    fill(0);
  }
  public void checkEdges() 
  {
    if((this.currentState.velocity.mag(this.currentState.velocity)<0.00001))this.currentState.velocity=new Vec2(0,0);

    if (this.currentState.position.x - this.radius < 0) 
    {
      this.currentState.position.x = this.radius; // Prevent from leaving the canvas from the left side
      this.currentState.velocity.x *= -1;
    } 
    else if (this.currentState.position.x + this.radius > width) 
    {
      this.currentState.position.x = width - this.radius; // Prevent from leaving the canvas from the right side
      this.currentState.velocity.x *= -1;
    }
    if (this.currentState.position.y - this.radius < 0) 
    {
      this.currentState.position.y = this.radius; // Prevent from leaving the canvas from the top
      this.currentState.velocity.y *= -1;
    } 
    else if (this.currentState.position.y+ this.radius > height) 
    {
      this.currentState.position.y = height - this.radius; // Prevent from leaving the canvas from the bottom
      this.currentState.velocity.y *= -1;
    }      

  }
  boolean isCollidingWithBall(Ball other)
  {
          currentState.mass=radius*3;

      if(dist(other.currentState.position, currentState.position)<=radius+other.radius)
      {
     
         return true;
      }else return false;
  }
}
