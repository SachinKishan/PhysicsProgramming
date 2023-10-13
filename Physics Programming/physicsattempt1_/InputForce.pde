//using a select and click, the ball has an impulse applied to it that pushes it in the direction of the mouse point from its current position
Ball selectedBall;
int findBallAtMousePosition(ArrayList<Ball> balls) {
  for (int i = 0; i < balls.size(); i++) {
    Ball ball = balls.get(i);
    float distance = dist(mouseX, mouseY, ball.currentState.position.x, ball.currentState.position.y);
    if (distance < ball.radius) {
      // Mouse click is inside the current ball
      selectedBallChange(ball);
      return i; // Return the index of the matching ball
    }
  }
  return -1; // Return -1 if no ball is found at the mouse position
  
  
}

void mousePressed() {
  int index = findBallAtMousePosition(balls);
  if (index != -1) {
    println("Mouse click inside ball at index: " + index);
  }
  else 
  {
    if(selectedBall==null)
      println("No ball clicked");
    else
    {
      mouseClickImpulse(3);
      selectedBallChange(null);
    }
  }
}

void selectedBallChange(Ball b)
{
  if(selectedBall!=null)
  {
    
     selectedBall.c=255;
     selectedBall=b;
  }
  else
  {
     selectedBall=b;
  }    
  if(selectedBall!=null)selectedBall.c=100;
}

void mouseClickImpulse(float forceMultiply)
{
  Vec2 ballPos=selectedBall.currentState.position;
  Vec2 dir=ballPos.sub(new Vec2(mouseX,mouseY));
  dir=dir.normalize(dir);
  dir=dir.mul(-forceMultiply);
  dir=dir.div(selectedBall.currentState.mass);
  selectedBall.currentState.velocity=selectedBall.currentState.velocity.add(dir);
}
Vec2 mouseVelocity;
float prevMouseX;
float prevMouseY;
void updateMouseVelocity() {
  // Calculate the mouse movement vector
  float deltaX = mouseX - prevMouseX;
  float deltaY = mouseY - prevMouseY;
  
  // Create a velocity vector based on mouse movement
  mouseVelocity=new Vec2(deltaX, deltaY);
  println(deltaX);
  
  // Update the ball's previous mouse position
  prevMouseX = mouseX;
  prevMouseY = mouseY;
}
void mouseDrag()
{
  if(selectedBall!=null)
  {
  Vec2 dir=mouseVelocity.normalize(mouseVelocity);
  dir=dir.mul(0.001);
  dir=dir.div(selectedBall.currentState.mass);
  selectedBall.currentState.velocity=selectedBall.currentState.velocity.add(dir);
  }
}
