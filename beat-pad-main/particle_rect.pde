class rectparticle extends Particle {

  float theta;

  rectparticle(PVector l, color c) {
   
    super(l, c);
 
    theta = 0.0;
  }

  void update() {
    super.update();
  
    float theta_vel = (velocity.x * velocity.mag()) / 10.0f;
    theta += theta_vel;
  }


  void display() {
     noStroke();
    fill(255, lifespan);
    rect(position.x, position.y, 4, 4);
  }

  boolean isDead() {
    return (lifespan < 0.0);
  }
}
