float dt=1f/60f;//time step
float t=0.0;//time keeper

void physicsTick()
{
   t+=dt;
 
}

void constantDeltaTime(float constantTime)
{
    float delta=1/constantTime;  
    dt= delta;
}
long currentTime=System.currentTimeMillis();
long end=0;

void variableDeltaTime()
{
   long newTime=System.currentTimeMillis();
          end = newTime - currentTime; // Delta time in ms
          currentTime = newTime;
          float delta = end / 100f; 
          dt= delta;
}

void semiFixedDeltaTime()
{
  long newTime=System.currentTimeMillis();
  float frameTime=newTime-currentTime;
  currentTime=newTime;
  while(frameTime>0.0)
  {
     float deltaTime=min(frameTime,dt);
     physicsCalculate();
     frameTime-=deltaTime;
     t+=deltaTime;
  }
}

void fixedDeltaTime()
{
  
}
