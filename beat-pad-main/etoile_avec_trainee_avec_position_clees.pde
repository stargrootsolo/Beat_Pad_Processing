//étoile, translation, rotation, trainée

class Star
{
  ArrayList<Square> squareTrails;
  Square mainSquare;

  float starX, starY;
  float xStartPosition, yStartPosition;
  float starAngle;
  int colorStroke = 255;
  float radiuss = 6;
  float i; //lerp position counter 

  boolean isActivated = false;

  Star()
  {
    xStartPosition = 1240.0f;
    yStartPosition = 710.0f;

    starX = xStartPosition;

    mainSquare = new Square(xStartPosition, yStartPosition);
    squareTrails = new ArrayList<Square>();

    reset();
  }

  void update()
  {
    if(isActivated)
    {
      mainSquare.move();
      mainSquare.display();
      squareTrails.add(new Square(mainSquare.px, mainSquare.py));
      SquareTrail();
      
      starTranslateEtRotate();
      strokeWeight(radiuss);
      stroke(colorStroke);
      point(starX, starY);
    }
    
  }

  void star(float x, float y, float radius1, float radius2, int npoints) 
  {
    fill(255,255,0);
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
      
  }


  void starTranslateEtRotate()
  {
    starY = lerp(720, 0, i/720);
    i++;

    starAngle -= (PI/130.0);
    
    pushMatrix();
      translate(starX, starY);
      rotate(starAngle);
      star(0, 0, 10, 30, 5);
    popMatrix();

  }

  void reset()
  {
    i = 0;
    starY = 1000;

    //clear the trail
    for(Square square : squareTrails)
    {
      square.opacity = 0;
    }
  }


  void SquareTrail()
  {
    for(int i = squareTrails.size() - 1; i >= 0 ; i--)
    {
      Square square = squareTrails.get(i);
      square.fade();
      square.display();

      if(square.opacity < 0)
      {
        squareTrails.remove(i);
      }
    }
  }
}


class Square
{
  float px, py;
  int opacity;
  int squareWidth, squareHeight;
  
  Square(float tempX, float tempY)
  {
   px = tempX;
   py = tempY;
   
   opacity = 255;

   squareWidth = 20;
   squareHeight = 20;
  }
  
  void display()
  {
    fill(253, opacity);
    noStroke();
    rectMode(CENTER);
    rect(px, py, squareWidth, squareHeight);
  }
  
  void move()
  {
    py = star.starY;
  }
  
  void fade()
  {
    opacity -= 0.5;
  }
}
