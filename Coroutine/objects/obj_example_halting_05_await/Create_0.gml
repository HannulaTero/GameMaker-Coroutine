/// @desc AWAIT


// AWAIT, and it's cousins, are ways to halt execution until some condition is met.
// The regular AWAIT requirement is boolean value: true.


// Here is example task, which waits until another one is one.
taskA = COROUTINE BEGIN 
  show_debug_message("Task A is waiting...");
  AWAIT choose(true, false) PASS
  
  show_debug_message("Task A is working...");
  DELAY 0.5 SECONDS
  show_debug_message("Task A is done!");
FINISH DISPATCH


// Coroutine tasks have "isFinished()" -method, which can be utilized for waiting other task to finish first..
taskB = COROUTINE BEGIN
  // Wait previous task to finish.
  show_debug_message("Task B is waiting...");
  AWAIT this.taskA.isFinished() PASS
  
  // Begin working.
  show_debug_message("Task B is working...");
  DELAY 1.5 SECONDS
  show_debug_message("Task B is done!");
FINISH DISPATCH


// AWAIT_COROUTINE awaits given task, so it does not require "isFinished".
// This also accepts array of tasks, so it can wait for multiple coroutines at once.
taskC = COROUTINE BEGIN
  // Wait previous task to finish.
  show_debug_message("Task C is waiting...");
  AWAIT_COROUTINE this.taskB PASS
  
  // Begin working.
  show_debug_message("Task C is working...");
  DELAY 1.5 SECONDS
  show_debug_message("Task C is done!");

FINISH DISPATCH


// AWAIT_SUBTASKS awaits that all subtasks of given tasks, and doesn't need handles.
// So, if task has launched other tasks, it awaits them all before continuing.
taskD = COROUTINE BEGIN

  // Wait previous task to finish.
  show_debug_message("Task C is waiting...");
  AWAIT_COROUTINE this.taskC PASS

  // Launch subtasks.
  COROUTINE BEGIN PRINT "subtask[0] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[0] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[1] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[1] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[2] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[2] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[3] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[3] end" FINISH DISPATCH
  COROUTINE BEGIN PRINT "subtask[4] begin" DELAY random_range(0.2, 5.0) SECONDS PRINT "subtask[5] end" FINISH DISPATCH

  // Wait subtasks to finish.
  show_debug_message("Task D launched subtasks!");
  AWAIT_SUBTASKS
  
  // Begin working after first one.
  show_debug_message("Task D is working...");
  DELAY 1.5 SECONDS
  show_debug_message("Task D is done!");

FINISH DISPATCH

























