class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color particleColor;

  Particle(PVector l, color c) {
    particleColor = c;
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-5, 5), random(-5, 5));
    position = l.copy();
    lifespan = 200.0;

  }

  void run() {
    update();
    display();
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }


  void display() {
    noStroke();
    fill(particleColor, lifespan);
    ellipse(position.x, position.y, 10, 10);
  }


  boolean isDead() {
    return (lifespan < 0.0);
  }
}
