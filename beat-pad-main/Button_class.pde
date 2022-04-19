class Button
{
    SoundFile player;
    JSONObject json;

    float w, h; //width and height
    float x, y; //position
    float xDiff, yDiff;
    float scaleAmount;
    color defaultColor, pressedColor, hoveredColor, currentColor;
    color pColor; //particles color
    String key; //key that the button reacts to
    boolean mouseIsPressed, isHovered, keyIsPressed;

    Button(float xPos, float yPos, int tag, PApplet p)
    {
        w = 90.0f;
        h = 75.0f;
        x = xPos;
        y = yPos;

        //Décalage pour mettre la détection de collision au bon endroit
        xDiff = w / 2;
        yDiff = h / 2;

        scaleAmount = 1.0f;
        
        defaultColor = color(#ffa6c9);
        hoveredColor = color(#00b7eb);
        pressedColor = color(#b2ec5d);
        currentColor = defaultColor;
        
        json = instrumentData.getJSONObject(tag);

        setInstrument(p);
        setParticleColor();
    }

    void changeSize(float wd, float ht)
    {
        w = wd;
        h = ht;

        xDiff = w / 2;
        yDiff = h / 2;
    }

    void setInstrument(PApplet p)
    {
        player = new SoundFile(p, "samples/" + json.getString("link"));
        key = json.getString("key");
    }

    void setParticleColor()
    {
        String instrument = json.getString("type");

        switch (instrument.charAt(0))
        {
            case 'b': //bass
                pColor = color(#66ff00);
                break;
            case 'v': //voix
                pColor = color(#ebd8f9);
                break;
            case 'c': //cymbale
                pColor = color(#08e8de);
                break;
            case 'd': //drum
                pColor = color(#fff000);
                break;
            case 's': //synth
                pColor = color(#ffaa1d);
                break;
            case 'p': //piano
                pColor = color(#ffc0cb);
                break;
            case 'm': //music
                pColor = color(#fe73a7);
                break;
            default: 
                pColor = color(#9e3ea6);
                break;
        }
    }

    void update()
    {
        checkForHover();
        display();
    }

    void display()
    {
        noStroke();
        rectMode(CENTER);

        if(mouseIsPressed || keyIsPressed)
        {
            scaleAmount = 0.95f;
            currentColor = pressedColor;
        }
        else if(isHovered)
        {
            scaleAmount = 1.1f;
            currentColor = hoveredColor;
        }
        else
        {
            scaleAmount = 1.0f;
            currentColor = defaultColor;
        }

        pushMatrix();

            translate(x,y);
            scale(scaleAmount);
            
            fill(currentColor);
            rect(0, 0, w, h, 10);

            fill(255,225);
            textAlign(CENTER, CENTER);
            text(key.toUpperCase(), 0, -6);
        
        popMatrix();

    }

    void playNow()
    {
        if(player.isPlaying())
            player.stop();

        player.play();
        systems.add(new ParticleSystem(1, new PVector(x, y), pColor));
        
        if(key.equals(" "))
        {
            star.reset();
            star.isActivated = true;
        }
    }

    void checkForHover()
    {
        if( mouseX > x - xDiff && mouseX < x -xDiff + w &&
            mouseY > y - yDiff && mouseY < y - yDiff + h )
        {
            isHovered = true;
        }
        else
        {
            isHovered = false;
        }
    }

    void keyHold(boolean state)
    {
        if(state && !keyIsPressed)
        {
            keyIsPressed = true;
            playNow();
        }
        else if(!state)
        {
            keyIsPressed = false;
        }
    }

    void mouseHold(boolean state)
    {
        if(state && !mouseIsPressed)
        {
            mouseIsPressed = true;
            playNow();
        }
        else if(!state)
        {
            mouseIsPressed = false;
        }
    }
}

void setupButtons()
{
    instrumentData = loadJSONArray("Instrument_data.json");

    buttons = new Button[27];

    int xPosition = 40;
    int yPosition = 0;
    int increment = 110;

    for(int i = 0; i < 10; i++)
    {
        yPosition = height / 3;
        xPosition += increment;
        buttons[i] = new Button(xPosition, yPosition, i, this);
    }

    xPosition = 90;

    for(int i = 10; i < 19; i++)
    {
        yPosition = height / 1/2;
        xPosition += increment;
        buttons[i] = new Button(xPosition, yPosition, i, this);
    }

    xPosition = 180;

    for(int i = 19; i < buttons.length; i++)
    {
        yPosition = height * 2/3;
        xPosition += increment;
        buttons[i] = new Button(xPosition, yPosition, i, this);
    }

    //setup spacebar
    xPosition = width / 2;
    yPosition = height * 5 / 6;
    buttons[26] = new Button(xPosition, yPosition, 26, this);
    buttons[26].changeSize(650.0f, 75.0f);
}
