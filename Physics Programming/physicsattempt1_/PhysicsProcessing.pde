
State explicitEuler(State oldState, Vec2 force)
{
  State newState=new State();
  newState.position=oldState.position.add(oldState.velocity.mul(dt));
  newState.velocity=oldState.velocity.add(force.div(oldState.mass).mul(dt));
    
  return newState;
}

State semiImplicitEuler(State oldState, Vec2 force)
{
  State newState=new State();
  newState.velocity=oldState.velocity.add(force.div(oldState.mass).mul(dt));
  
  newState.position=oldState.position.add(oldState.velocity.mul(dt));

  return newState;
}

Vec2 accelerationSpring( State state, double t )
{
   float k = 15.0f;
   float b = 0.1f;
  return state.position.mul(-k).sub(state.velocity.mul(b));
}

Vec2 accelerationGeneral(State s, Vec2 force)
{
  return force.div(s.mass);
}  
  

State evaluate(  State initial, double t, float dt, State d)
{
  State state=new State();
  state.position = initial.position.add(d.position.mul(dt));
  state.velocity = initial.velocity.add(d.velocity.mul(dt));
  State output=new State();
  output.position = state.velocity;
  output.velocity = accelerationSpring( state, t+dt );
  return output;
}

State integrate( State state, double t, float dt )
{
        State a,b,c,d;

        a = evaluate( state, t, 0.0f, new State() );
        b = evaluate( state, t, dt*0.5f, a );
        c = evaluate( state, t, dt*0.5f, b );
        d = evaluate( state, t, dt, c );

      
            
        b.position=b.position.mul(2.0f);    
        c.position=c.position.mul(2.0f);    
        
        Vec2 dxdt=a.position.add(b.position.add(c.position.add(d.position)));
        dxdt=dxdt.mul(1.0f/6.0f);
            
            
         b.velocity=b.velocity.mul(2.0f);    
        c.velocity=c.velocity.mul(2.0f);    
        
        Vec2 dvdt=a.velocity.add(b.velocity.add(c.velocity.add(d.velocity)));
        dvdt=dvdt.mul(1.0f/6.0f);

        state.position = state.position.add(dxdt.mul(dt));
        state.velocity = state.velocity.add(dvdt.mul(dt));
        return state;
}
