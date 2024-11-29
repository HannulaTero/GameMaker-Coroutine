/// @desc FOREACH IN RANGE.



COROUTINE BEGIN 

  // Iterating over number can be useful, but it is rather limited.
  // So this coroutine system provides way to iterate over given range.
  // Note, that start-value is inclusive, stop-value is exclusive.
  
  // RANGE accepts 1 to 3 arguments, or struct holding arguments.
  // RANGE expects start, stop and step.
  
  // When you give single argument, it acts like you have given number to iterate.
  // So it starts from 0 and iterates to given number with step-size 1.
  PRINT "iterating over RANGE(10).";
  FOREACH key, value IN RANGE(10) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // When you give second argument, they act as "start, end" -values.
  // The step-size still stays 1.
  PRINT "iterating over RANGE(5, 15).";
  FOREACH key, value IN RANGE(5, 15) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // You can also iterate backwars by placing larger value first.
  // The step-size still stays 1.
  PRINT "iterating over RANGE(15, 5).";
  FOREACH key, value IN RANGE(15, 5) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // The third argument will be the step-size, which cannot be 0.
  // 
  PRINT "iterating over RANGE(-15, 15, 3).";
  FOREACH key, value IN RANGE(-15, 15, 3) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";
  
  
  // Finally, you can also do the same, but give values with struct.
  // The values are optional. Using struct can be helpful, if it is used elsewhere.
  PRINT "iterating over RANGE({ start: -50, stop: 50, step: 10 }).";
  FOREACH key, value IN RANGE({ start: -50, stop: 50, step: 10 }) THEN
    show_debug_message($"range {key} = {value};");
    DELAY 3 FRAMES
  END
  PRINT "done.";


FINISH DISPATCH 













