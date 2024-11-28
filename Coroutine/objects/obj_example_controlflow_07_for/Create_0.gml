/// @desc FOR.


// Basic iterative loop, similar to GML one.
// This will iterate until condition is false.
COROUTINE BEGIN

  FOR  i = 0;
  COND i < 10;
  ITER i++;
  THEN
    show_debug_message($"For loop iteration [{i}]");
    DELAY 3 FRAMES
  END
  
  show_debug_message("Loop finished!");

FINISH DISPATCH 

