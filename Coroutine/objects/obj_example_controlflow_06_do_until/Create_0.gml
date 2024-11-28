/// @desc DO-UNTIL.


// Do-until -statement, similar to GML one.
// This will execute atleast once, and then conditionally executes.
// In following example, condition is immediately met, but it does it atleast once.
COROUTINE BEGIN

  DO 
    show_debug_message($"Dododoo!");
  UNTIL 
    true
  END
  
  show_debug_message("Loop finished!");

FINISH DISPATCH 


// Here just another one.
COROUTINE BEGIN

  DO 
    show_debug_message($"Duupiduu!");
    YIELD
  UNTIL 
    (irandom(10) == 0)
  END
  
  show_debug_message("Loop finished!");

FINISH DISPATCH 
