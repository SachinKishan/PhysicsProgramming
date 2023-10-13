

int numberOfBalls=30;
float minRad=5;
float maxRad=30;
//Vec2 gravity=new Vec2(1, 10);
Vec2 gravity=new Vec2(0.00, 0.00009);
Vec2 rise=new Vec2(0.00, -0.00001);

//Vec2 gravity=new Vec2(10, 1000);

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  size(600, 900);
  frameRate(60);
  smooth();
  background(180);

  stroke(2);
  strokeWeight(1);
  fill(255);
  createBalls();
}

void createBalls()
{
  for (int i=0; i<numberOfBalls; i++)
  {
    balls.add(new Ball(random(minRad, maxRad)));
  }
  //balls.add(new Ball(175));
}

void physicsCalculate()
{
  for (int i = 0; i < balls.size(); i++)
  {
    Ball ball=balls.get(i);
    if (key == ' ')
    {
      //State ballState=semiImplicitEuler(ball.currentState, gravity);
      State ballState=explicitEuler(ball.currentState, gravity);

      ball.setState(ballState);
    }
    else 
    {
      //State ballState=semiImplicitEuler(ball.currentState, gravity);
            State ballState=explicitEuler(ball.currentState, rise);

      ball.setState(ballState);
    }
    ball.checkEdges();
    
    for (int j = i+1; j < balls.size(); j++)
    {
      Ball other = balls.get(j);
      float massB=other.currentState.mass;
      float distance=dist(other.currentState.position, ball.currentState.position);
      float minDistance=ball.radius+other.radius;
      if (distance<=minDistance)
      {

        Vec2 normal = other.currentState.position.sub(ball.currentState.position);
        normal=normal.normalize(normal);
        Vec2 relativeVelocity = other.currentState.velocity.sub(ball.currentState.velocity);

        Vec2 impulse = normal.mul(relativeVelocity.dot(normal)/(ball.currentState.mass+massB));

        Vec2 a=impulse.div(ball.currentState.mass);
        ball.currentState.velocity=ball.currentState.velocity.add(a);
        Vec2 b=impulse.div(massB);
        other.currentState.velocity=other.currentState.velocity.sub(b);

        Vec2 repulsion = normal.mul(minDistance - distance);
        a=repulsion.div(ball.currentState.mass);
        ball.currentState.position=balls.get(i).currentState.position.sub(a);
        b=repulsion.div(massB);
        other.currentState.position=balls.get(j).currentState.position.add(b);
      }
    }
  }
}

void render()
{
  for (Ball ball : balls) {
    if(ball.currentState.velocity.y>0)
    {
      if(ball.radius>=5)
        ball.radius-=0.1;
    }
    else 
      if(ball.radius<=45)ball.radius+=0.1;  
     
//    ball.radius+=random(-1,1);
    ball.renderBody();
  }
}

void border()
{
  strokeWeight(5);

  line(0, 0, width, 0);  // Top border
  line(0, 0, 0, height);  // Left border
  line(0, height, width, height);  // Bottom border
  line(width, 0, width, height);  // Right border
  strokeWeight(1);
}

void addForce()
{
}

void draw() {
  if (t<=1000000)
  {
    background(180);
    
    border();
    if(selectedBall!=null)line(selectedBall.currentState.position.x,selectedBall.currentState.position.y,mouseX,mouseY);
    //constantDeltaTime(60);
    semiFixedDeltaTime();
    //variableDeltaTime();
    //physicsCalculate();
    render();
  }    

}
