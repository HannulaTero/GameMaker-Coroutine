/// @desc PAUSE.


// Pause halts task execution until it is manually resumed with ".Resume();".
// This does mean, that you must assign task handle into variable to be able to do so.
// You can utilize triggers to handle what coroutine will do, when it is paused/unpaused.
coroutine = KORUTIINI 

ON_PAUSE  
  KorutiiniExample_Log("Trigger: Coroutine paused.");
  
ON_RESUME 
  KorutiiniExample_Log("Trigger: Coroutine resumed.");
  
BEGIN
  KorutiiniExample_Log("Coroutine started!");
  PAUSE
  KorutiiniExample_Log("Coroutine finished!.");
FINISH DISPATCH


// This other coroutine will unpause first coroutine in 2 seconds.
// 
KORUTIINI BEGIN
  DELAY 2 SECONDS
  this.coroutine.Resume();
FINISH DISPATCH
