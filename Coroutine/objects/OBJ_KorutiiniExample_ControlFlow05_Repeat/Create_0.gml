/// @desc REPEAT.


// Repeat -statement, similar to GML one.
// This will iterate as many times the expression states.
KORUTIINI BEGIN

  index = 0;
  repeats = irandom(20);
  KorutiiniExample_Log($"Example will do {repeats} repeats!");
  REPEAT repeats THEN
    KorutiiniExample_Log($"Repeat at [{++index}]");
    DELAY 3 FRAMES
  END
  KorutiiniExample_Log("Loop finished!");

FINISH DISPATCH 

