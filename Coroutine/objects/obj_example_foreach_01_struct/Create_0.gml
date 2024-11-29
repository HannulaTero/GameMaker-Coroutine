/// @desc FOREACH IN STRUCT.


COROUTINE BEGIN 
  // Initializing iterable structure.
  struct = { 
    text: "hello world!", 
    number: 123, 
    a: 0, 
    b: 1, 
    c: 2 
  }; 
  
  // Using foreach with struct works same as the array.
  // Note, that structs are unordered, so key-order can be anything.
  // Key is always a string.
  PRINT "iterating over struct.";
  FOREACH key, value IN struct THEN
    show_debug_message($"struct.{key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "iterating done!";


FINISH DISPATCH 













