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


// Also there are other AWAIT_* types, look for other related examples.
// Following will await all task's own subtasks, requests or listeners.
// AWAIT_SUBTASKS, AWAIT_REQUESTS, AWAIT_LISTENERS























