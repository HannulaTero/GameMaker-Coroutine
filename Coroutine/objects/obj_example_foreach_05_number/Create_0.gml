/// @desc FOREACH IN NUMBER.



COROUTINE BEGIN 

  numberA = 10;
  numberB = -8;
  
  
  // You can iterate over number.
  // It starts from zero and goes towards to the number with step-size 1.
  // Note, that start-value is inclusive, stop-value is exclusive.
  PRINT $"iterating over number: {numberA}.";
  FOREACH key, value IN numberA THEN
    show_debug_message($"{key} => {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // You can also iterate over negative number.
  // It starts from zero and goes towars number like positive number.
  PRINT $"iterating over number: {numberB}.";
  FOREACH key, value IN numberB THEN
    show_debug_message($"{key} => {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";


FINISH DISPATCH 













