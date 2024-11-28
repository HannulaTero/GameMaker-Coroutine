/// @desc SWITCH.


COROUTINE BEGIN

  SWITCH irandom(10) 
    CASE 0 THEN show_debug_message("Case 0");
    CASE 1 THEN show_debug_message("Case 1"); 
    CASE 2 THEN show_debug_message("Case 2");
    CASE 3 THEN show_debug_message("Case 3");
    CASE 4 THEN show_debug_message("Case 4");
    CASE 5 THEN show_debug_message("Case 5");
    CASE 6 THEN show_debug_message("Case 6");
    CASE 7 THEN show_debug_message("Case 7");
    CASE 8 THEN show_debug_message("Case 8"); 
    CASE 9 THEN show_debug_message("Case 9");
    DEFAULT show_debug_message("Default case");
  END

FINISH DISPATCH