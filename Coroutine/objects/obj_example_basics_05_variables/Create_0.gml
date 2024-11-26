/// @desc VARIABLES.

// In coroutines, you usually cannot use local variables "var i = 0;" because of code that macros generate.
// So the best practice is to just always to use instance/struct variables.


coroutine = COROUTINE BEGIN
  DELAY random(value) + 15.0 MICROS 
  PRINT "Hello world";
FINISH DISPATCH




