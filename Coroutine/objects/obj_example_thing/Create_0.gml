
image_blend = c_dkgray;


//Start 
coroutine = COROUTINE 
  scoped: false
  
BEGIN 

  DELAY random(120) MILLIS 
  WHILE true THEN // Repeat forever!
    //Randomize our position and angle
    image_angle = random(360);
    x = xprevious + random_range(-5, 5);
    y = yprevious + random_range(-5, 5);

    //Wait about 120ms before doing this again
    DELAY random_range(110, 130) MILLIS

  END
FINISH DISPATCH


 