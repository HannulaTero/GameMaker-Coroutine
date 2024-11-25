/// @desc DISPATCH.

// After creating prototype, you can immediately use "DISPATCH" to create active coroutine task.
// Task-handle is returned to control task outside the coroutine execution.
coroutine = COROUTINE BEGIN 
  DELAY irandom_range(20, 30) FRAMES 
  show_debug_message("I think, therefore I am.");
FINISH DISPATCH


// Prototype can be used to dispatch new active tasks.
// You can think prototype as a function, and active task as execution of function.
prototype = COROUTINE BEGIN 
  DELAY irandom_range(40, 60) FRAMES 
  show_debug_message("You think, therefore you are?");
FINISH

coroutine = prototype.Dispatch();


// When you use "DISPATCH", caller will always be implicitly the current "self".
// With prototype Dispatch -call you can define explicit "this". 
coroutine = prototype.Dispatch(self);


// For convenience, you can make new task dispatches of same coroutine task.
// This is same as using task's prototype to dispatch new task.
another = coroutine.prototype.Dispatch();
another = coroutine.Dispatch();


// All tasks of same prototype utilizes same shared structure and settings of prototype.
// So be careful if you tinker tasks in non-intended ways.









