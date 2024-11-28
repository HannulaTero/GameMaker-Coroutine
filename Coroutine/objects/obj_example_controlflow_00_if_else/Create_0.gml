/// @desc IF-ELSE.



COROUTINE BEGIN

  IF choose(true, false) THEN
    show_debug_message("THEN-branch");
  ELSE
    show_debug_message("ELSE-branch");
  END

FINISH DISPATCH