/// @desc SWITCH.


// Simplest switch-statement does not have cases or default action.
// Practically this example does nothing.
KORUTIINI BEGIN
  KorutiiniExample_Log("First example.");
  SWITCH 0 
  END
  KorutiiniExample_Log("done.");
FINISH DISPATCH


// You can have default case, which will be selected whenever no matching case is found.
// In following example default action is always selected.
KORUTIINI BEGIN
  DELAY 0.5 SECONDS
  KorutiiniExample_Log("Second example.");
  SWITCH irandom(5) 
    DEFAULT KorutiiniExample_Log(" - Default case");
  END
  KorutiiniExample_Log("done.");
FINISH DISPATCH


// You add cases defining them as "CASE x THEN", there should be no duplicate cases.
// In following example if case is not found, then it does not select anything, as default is not defined.
KORUTIINI BEGIN
  DELAY 1.0 SECONDS
  KorutiiniExample_Log("Third example.");
  SWITCH irandom(5) 
    CASE 0 THEN KorutiiniExample_Log(" - Case 0");
    CASE 1 THEN KorutiiniExample_Log(" - Case 1"); 
    CASE 2 THEN KorutiiniExample_Log(" - Case 2");
    CASE 3 THEN KorutiiniExample_Log(" - Case 3");
  END
  KorutiiniExample_Log("done.");
FINISH DISPATCH


// Finally, you can define multiple cases by giving case-values in array.
// In following example cases are defined between 0 to 8, and default value is chosen otherwise., 
KORUTIINI BEGIN
  DELAY 1.5 SECONDS
  KorutiiniExample_Log("Fourth example.");
  SWITCH irandom(10) 
    CASE [0, 1, 2] THEN KorutiiniExample_Log(" - Case 0 to 2");
    CASE [3, 4, 5] THEN KorutiiniExample_Log(" - Case 3 to 5"); 
    CASE 6 THEN KorutiiniExample_Log(" - Case 6");
    CASE 7 THEN KorutiiniExample_Log(" - Case 7");
    CASE 8 THEN KorutiiniExample_Log(" - Case 8");
    DEFAULT KorutiiniExample_Log(" - Default case");
  END
  KorutiiniExample_Log("done.");
FINISH DISPATCH


// Note! Cases are evaluated during executable graph-generation, which means they are practically "compile-time constants".
// Therefore you cannot have dynamic cases. 
// Switch acts like jump table, not as if-else chain.