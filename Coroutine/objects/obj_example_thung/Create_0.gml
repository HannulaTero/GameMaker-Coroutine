

//Start 
coroutine = COROUTINE 
  scoped: false 
  
BEGIN 

  LOOP
    DELAY 0.5 SECONDS
    
    speed = 0;
    REPEAT 9 THEN
      if (keyboard_check(vk_space))
        BREAK
      direction += 10;
      image_angle = direction;
      YIELD 
    END
    speed = 4;
  END
  
FINISH DISPATCH 
