
//Start 
COROUTINE 
  scoped: false
BEGIN 

  DELAY 2 FRAMES 
  WHILE true THEN //Repeat forever!
    //Randomize our position and angle
    image_angle = random(360);
    x = xprevious + random_range(-5, 5);
    y = yprevious + random_range(-5, 5);

    //Wait about 120ms before doing this again
    //DELAY random_range(110, 130) MILLIS
    DELAY 10 FRAMES

  END
FINISH DISPATCH
