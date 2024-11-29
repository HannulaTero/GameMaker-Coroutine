/// @desc SYNTAX.

// You can mix coroutine Macro-syntax and GML in limited amount
// The code editor "should" warn about you most cases whenever it is not possible to something.


// Most of keywords generate graph, but there are couple runtime-executed keywords.
// 
// BREAK;           Similar to GML break. Must be called inside any loop-statement.
// CONTINUE;        Similar to GML continue. Must be called inside any loop-statement.
// RESTART;         Jumps directly to the start of the task, doesn't do any checking.
// CANCEL;          Stops task and triggers onCancel.
// EXIT;            Stops task and triggers onComplete, doesn't change task result -value.
// RETURN "value";  Stops task and triggers onComplete, and sets result -value.
// GOTO "label";    Jump directly to any defined label within task.
// PRINT "Hello!"   Just convenience, same as: show_debug_message("Hello!");
    

// Usually THEN requires closing END, but in few expections (LOOP, SWITCH)
COROUTINE BEGIN 
  EXIT // Exit to not actually execute following code.

  IF THEN END
  IF THEN ELSE END
  IF THEN ELIF THEN END
  IF THEN ELIF THEN ELSE END
  
  LOOP END
  
  WHILE THEN END
  REPEAT THEN END
  FOR COND ITER THEN END
  
  SWITCH END 
  SWITCH CASE 0 THEN END
  SWITCH CASE 0 THEN DEFAULT END
  SWITCH CASE 0 THEN CASE 1 THEN CASE 2 THEN DEFAULT END

FINISH DISPATCH