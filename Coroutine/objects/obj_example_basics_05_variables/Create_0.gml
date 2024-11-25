/// @desc VARIABLES.

// In coroutines, you usually cannot use local variables "var i = 0;" because what macros generate.
// So all variables must be assigned as instance variables.



coroutine = COROUTINE BEGIN
  DELAY random(value) + 15.0 MICROS 
  PRINT "Hello world";
FINISH DISPATCH




