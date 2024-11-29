/// @desc SUBTASKS.


// Subtasks are tasks launched within another task.
// They are counted for you automatically, so you don't need to worry.
// Note that subtask is executed independently from main task, and it might finish before or after main task.
COROUTINE BEGIN 

  COROUTINE BEGIN 
    DELAY 0.2 SECONDS
    PRINT "print from subtask[0]"
  FINISH DISPATCH

  COROUTINE BEGIN 
    DELAY 0.7 SECONDS
    PRINT "print from subtask[1]"
  FINISH DISPATCH
  
  DELAY 0.5 SECONDS
  PRINT "print from main task"

FINISH DISPATCH


// To wait for subtasks to finish before continuing, you should use AWAIT
// one way is to wait each subtask separately: AWAIT subtask.isFinished() PASS
// Another is to use AWAIT_SUBTASKS


// AWAIT_SUBTASKS awaits all subtasks, and doesn't need handles.
// So, if task has launched subtasks, it awaits them all before continuing.
COROUTINE BEGIN

  DELAY 1.0 SECONDS

  // Launch subtasks.
  COROUTINE BEGIN PRINT "subtask[0] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[0] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[1] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[1] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[2] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[2] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[3] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[3] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[4] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[5] end" FINISH DISPATCH
  show_debug_message("Task launched subtasks!");

  // Wait subtasks to finish.
  AWAIT_SUBTASKS
  show_debug_message("All subtasks are done!");
  
FINISH DISPATCH

