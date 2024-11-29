/// @desc SWITCH.


// Simplest switch-statement does not have cases or default action.
// Practically this example does nothing.
COROUTINE BEGIN
  show_debug_message("First example.");
  SWITCH 0 
  END
  show_debug_message("done.");
FINISH DISPATCH


// You can have default case, which will be selected whenever no matching case is found.
// In following example default action is always selected.
COROUTINE BEGIN
  DELAY 0.5 SECONDS
  show_debug_message("Second example.");
  SWITCH irandom(5) 
    DEFAULT show_debug_message(" - Default case");
  END
  show_debug_message("done.");
FINISH DISPATCH


// You add cases defining them as "CASE x THEN", there should be no duplicate cases.
// In following example if case is not found, then it does not select anything, as default is not defined.
COROUTINE BEGIN
  DELAY 1.0 SECONDS
  show_debug_message("Third example.");
  SWITCH irandom(5) 
    CASE 0 THEN show_debug_message(" - Case 0");
    CASE 1 THEN show_debug_message(" - Case 1"); 
    CASE 2 THEN show_debug_message(" - Case 2");
    CASE 3 THEN show_debug_message(" - Case 3");
  END
  show_debug_message("done.");
FINISH DISPATCH


// Finally, you can define multiple cases by giving case-values in array.
// In following example cases are defined between 0 to 8, and default value is chosen otherwise., 
COROUTINE BEGIN
  DELAY 1.5 SECONDS
  show_debug_message("Fourth example.");
  SWITCH irandom(10) 
    CASE [0, 1, 2] THEN show_debug_message(" - Case 0 to 2");
    CASE [3, 4, 5] THEN show_debug_message(" - Case 3 to 5"); 
    CASE 6 THEN show_debug_message(" - Case 6");
    CASE 7 THEN show_debug_message(" - Case 7");
    CASE 8 THEN show_debug_message(" - Case 8");
    DEFAULT show_debug_message(" - Default case");
  END
  show_debug_message("done.");
FINISH DISPATCH


// Note! Cases are evaluated during executable graph-generation, which means they are practically "compile-time constants".
// Therefore you cannot have dynamic cases. 
// Switch acts like jump table, not as if-else chain.