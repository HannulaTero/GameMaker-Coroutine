/// @desc REPEAT.


// Repeat -statement, similar to GML one.
// This will iterate as many times the expression states.
COROUTINE BEGIN

  index = 0;
  repeats = irandom(20);
  show_debug_message($"Example will do {repeats} repeats!");
  REPEAT repeats THEN
    show_debug_message($"Repeat at [{++index}]");
    DELAY 3 FRAMES
  END
  show_debug_message("Loop finished!");

FINISH DISPATCH 

