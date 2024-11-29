
image_blend = c_dkgray;
image_alpha = 0.5;
image_xscale = 0.5;
image_yscale = 0.5;
instance_deactivate_object(self);


// Start moving around. 
coroutine = COROUTINE scoped: false BEGIN 

  DELAY random(1.0) SECONDS
  instance_activate_object(self);
  
  COROUTINE scoped: false BEGIN
    DELAY 5.0 SECONDS
    instance_destroy();
    coroutine.Destroy();
  FINISH DISPATCH 
  
  
  WHILE true THEN // Repeat forever!
    //Randomize our position and angle
    image_angle = random(360);
    x = xprevious + random_range(-5, 5);
    y = yprevious + random_range(-5, 5);

    //Wait about 120ms before doing this again
    DELAY random_range(110, 130) MILLIS

  END
FINISH DISPATCH


 