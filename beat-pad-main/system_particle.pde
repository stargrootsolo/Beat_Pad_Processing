class ParticleSystem {

  ArrayList<Particle> particles;    
  PVector origin;
  float systemLifeSpan;
  color pColor;                   

  ParticleSystem(int num, PVector v, color c) {
    particles = new ArrayList<Particle>();  
    origin = v.copy();
    systemLifeSpan = 100.0f;
    pColor = c;                       
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, pColor));   
    }
  }


  void run() {
  
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
    systemLifeSpan -= 2.0f;
  }

  void addParticle() {
    if(!dead()){
      Particle p;
      if (int(random(0, 2)) == 0) {
        p = new Particle(origin, pColor);
      } 
      else {
        p = new rectparticle(origin, pColor);
      }
      particles.add(p);
    }
  }

  void addParticle(Particle p) {
    particles.add(p);
  }

  boolean dead() {
    return (systemLifeSpan < 0.0f);
  }
}
