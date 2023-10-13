class Vec2
{
   float x;
   float y;
   Vec2(){x=0;y=0;}
   Vec2(float _x, float _y)
   {
         x=_x;
         y=_y;
   }
   
   Vec2(Vec2 v)
   {
     x=v.x;
     y=v.y;
   }

   Vec2 add(Vec2 v)
   {
     return new Vec2(x+v.x,y+v.y);
   }
   Vec2 add(float v)
   {
     return new Vec2(x+v,y+v);
   }
   Vec2 sub(Vec2 v)
   {
        return new Vec2(x-v.x,y-v.y);
   }
   Vec2 mul(float f)
   {
        return new Vec2(x*f,y*f);
   }
   Vec2 div(float f)
   {
        return new Vec2(x/f,y/f);
   }
   


float mag(Vec2 v) {
  return sqrt(v.x*v.x + v.y*v.y);
}


  Vec2 normalize(Vec2 v) 
  {
   float m = mag(v);
   if (m != 0) {
   return div(m);
  }
  return new Vec2(0,0);
  }

float dot(Vec2 v) {
    return x * v.x + y * v.y;
  }

}

float dist(Vec2 v1, Vec2 v2) {
  float dx = v1.x - v2.x;
  float dy = v1.y - v2.y;
  return sqrt(dx * dx + dy * dy);
}
