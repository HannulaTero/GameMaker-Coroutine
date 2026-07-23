/// @desc FOR.


// Basic iterative loop, similar to GML one.
// This will iterate until condition is false.
KORUTIINI BEGIN

  FOR  i = 0;
  COND i < 10;
  ITER i++;
  THEN
    KorutiiniExample_Log($"For loop iteration [{i}]");
    DELAY 3 FRAMES
  END
  
  KorutiiniExample_Log("Loop finished!");

FINISH DISPATCH 

