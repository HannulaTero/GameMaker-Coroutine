/// @desc WHILE.


// Basic conditional loop, similar to GML one.
// This will iterate until condition is false.
COROUTINE BEGIN

  index = 0;
  WHILE (irandom(20) != 0) THEN
    show_debug_message($"Loopity loop! [{index++}]");
    DELAY 3 FRAMES
  END
  show_debug_message("Loop finished!");

FINISH DISPATCH 

