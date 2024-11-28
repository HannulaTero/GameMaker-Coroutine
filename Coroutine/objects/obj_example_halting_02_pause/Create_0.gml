/// @desc PAUSE.


// Pause halts task execution until it is manually resumed with ".Resume();".
// This does mean, that you must assign task handle into variable to be able to do so.
// You can utilize triggers to handle what coroutine will do, when it is paused/unpaused.
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
