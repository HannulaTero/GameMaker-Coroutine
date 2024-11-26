/// @desc PAUSE.


// Pause just pauses task execution, and it won't resume without user calling.
// This means you require take the handle to use ".Resume();" method on the task.
// You can utilize triggers to handle what coroutine will when it is paused/unpaused.
coroutine = COROUTINE 

ON_PAUSE  
  show_debug_message("Trigger: Coroutine paused.");
  
ON_RESUME 
  show_debug_message("Trigger: Coroutine resumed.");
  
BEGIN
  show_debug_message("Coroutine started!");
  PAUSE
  show_debug_message("Coroutine finished!.");
FINISH DISPATCH


// This other coroutine will unpause first coroutine in 2 seconds.
// 
COROUTINE BEGIN
  DELAY 2 SECONDS
  this.coroutine.Resume();
FINISH DISPATCH
