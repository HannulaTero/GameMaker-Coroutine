/// @desc WHILE.


// Basic conditional loop, similar to GML one.
// This will iterate until condition is false.
KORUTIINI BEGIN

  index = 0;
  WHILE (irandom(20) != 0) THEN
    KorutiiniExample_Log($"Loopity loop! [{index++}]");
    DELAY 3 FRAMES
  END
  KorutiiniExample_Log("Loop finished!");

FINISH DISPATCH 

