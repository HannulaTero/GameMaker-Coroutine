/// @desc IF-ELIF-ELSE.



COROUTINE BEGIN

  IF choose(true, false) THEN
    show_debug_message("THEN-branch");
    
  ELIF choose(true, false) THEN
    show_debug_message("ELIF[0]-branch");
    
  ELIF choose(true, false) THEN
    show_debug_message("ELIF[1]-branch");
    
  ELIF choose(true, false) THEN
    show_debug_message("ELIF[2]-branch");
    
  ELIF choose(true, false) THEN
    show_debug_message("ELIF[3]-branch");
    
  ELSE
    show_debug_message("ELSE-branch");
    
  END

FINISH DISPATCH