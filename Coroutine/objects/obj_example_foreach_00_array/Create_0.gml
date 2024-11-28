/// @desc FOREACH.


// There is no foreach -statement in GM, just array_foreach and struct_foreach -functions.
// FOREACH will accept usual iterable items, and iterate each item.
COROUTINE BEGIN 

  array = [10, 20, 30, 40];

  // Iterating over array.
  PRINT "iterating over array.";
  FOREACH key, value IN array THEN
    show_debug_message($"array[{key}] = {value};");
    DELAY 3 FRAMES
  END

  // Iterating keys are both optional.
  PRINT "iterating over another array.";
  FOREACH value IN [11, 22, 33, 44] THEN
    show_debug_message($"item in array: {value}");
    DELAY 3 FRAMES
  END


FINISH DISPATCH 













