/// @desc DO-UNTIL.


// Do-until -statement, similar to GML one.
// This will execute atleast once, and then conditionally executes.
// In following example, condition is immediately met, but it does it atleast once.
KORUTIINI BEGIN

  DO 
    KorutiiniExample_Log($"Dododoo!");
  UNTIL 
    true
  END
  
  KorutiiniExample_Log("Loop finished!");

FINISH DISPATCH 


// Here just another one.
KORUTIINI BEGIN

  DO 
    KorutiiniExample_Log($"Duupiduu!");
    YIELD
  UNTIL 
    (irandom(10) == 0)
  END
  
  KorutiiniExample_Log("Loop finished!");

FINISH DISPATCH 
