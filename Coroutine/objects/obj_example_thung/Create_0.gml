

//Start 
COROUTINE scoped: false BEGIN 

  speed = 4;
  LOOP
    DELAY 0.5 SECONDS
    REPEAT 9 THEN
      direction += 10;
      image_angle = direction;
      YIELD
    END
  END
  
FINISH DISPATCH
