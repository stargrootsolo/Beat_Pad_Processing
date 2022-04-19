import processing.sound.*;

import processing.video.*;
Movie myMovie;

Tunnel tunnel;
Star star;

JSONArray instrumentData;

Button[] buttons;

PFont font1;
PFont font2;
PImage note;

ArrayList<ParticleSystem> systems;

void setup()
{
  font2=createFont("MANOLETE.ttf",30);
   font1=createFont("Nectar.ttf",90);
   
   tunnel = new Tunnel();
   star = new Star();
   
 myMovie = new Movie(this, "prog_background.mp4");
  myMovie.loop();
  
   note = loadImage("music_note.png");

systems = new ArrayList<ParticleSystem>();

    setupButtons();

   size(1280,720);
   frameRate(60);
}

void draw()
{
image(myMovie, 0, 0);
   tunnel.display();
   star.update();
   
    image(note,850,70,40,50);
    
    fill(0);
  textFont(font1);
  text("BEAT PAD",640,80);
  
   fill(0);
  textFont(font2);
  text("Appuie sur les touches du clavier",640,140);
    
  for(int i = 0; i < buttons.length; i++)
  {
     buttons[i].update();
  }
  
   for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }
  if (systems.isEmpty()) {
  }
}

void mousePressed()
{

  systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY), color(#ffff31)));
  
    for(int i = 0; i < buttons.length; i++)
    {
        if(buttons[i].isHovered)
            buttons[i].mouseHold(true);
    }
}

void mouseReleased()
{
    for(int i = 0; i < buttons.length; i++)
    {
        if(buttons[i].mouseIsPressed)
            buttons[i].mouseHold(false);
    }
}

void keyPressed()
{
    for(int i = 0; i < buttons.length; i++)
    {
        if(buttons[i].key.equals(str(key)))
            buttons[i].keyHold(true);
    }
    if(key == ' ')
    {
       tint(#ff1493);
    }
}

void keyReleased()
{
    for(int i = 0; i < buttons.length; i++)
    {
      if(buttons[i].key.equals(str(key)))
        buttons[i].keyHold(false);
    }
     if(key == ' ')
    {
      tint(#ffffff);
    }
}

void movieEvent(Movie m) {
  m.read();
}
