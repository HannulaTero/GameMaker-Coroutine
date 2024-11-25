/// @desc PROTOTYPE.

// When you define coroutine, you are actually creating a "prototype" for it.
// This prototype is cached and reused across different dispatches of same prototype.
show_debug_message("Prototypes don't do execution.");


// Following code will only create coroutine prototype.
// Notice the missing "DISPATCH", which would create a new active coroutine task.
COROUTINE BEGIN 
  show_debug_message("To be or not to be.");
FINISH


// To make use of prototype, you need to obtain a handle for it.
// Note, since prototype has not been dispatched, it does not have any active tasks yet.
prototype = COROUTINE BEGIN 
  DELAY irandom_range(30, 120) FRAMES 
  show_debug_message("That's the question.");
FINISH


// The GML Coroutine implementation is not compile-time process, 
// therefore creating prototypes will take some time, though only once during runtime.
// As creating prototypes and dispatching tasks are separate activities,
// you could pre-create coroutines when game is initialized.





