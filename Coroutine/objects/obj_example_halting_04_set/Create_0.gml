/// @desc SET, YIELD_SET and PAUSE_SET

// SET does not halt execution, but acts like PASS.

// PASS, YIELD and PAUSE only affects execution timing.
// But sometimes it is useful to get mid-result elsewhere, a "return" value for coroutine.
// Therefore, following keywords provide same functionality, but also sets "return" value for coroutine.
//    SET, YIELD_SET and PAUSE_SET 


// This return value for coroutine can be accessed using ".Get()" method.
// One way to utilize this is to store what coroutine is currently doing.
coroutine = COROUTINE BEGIN

  show_debug_message("Coroutine started");
  
  SET "Started" PASS 
  DELAY 1.0 SECONDS
  
  YIELD_SET "Yielded" PASS
  DELAY 1.0 SECONDS
  
  PAUSE_SET "Paused" PASS
  DELAY 1.0 SECONDS
  
  
  // As you may have noticed, PASS is used after value for separating purposes.
  // This is not necessary, if next value is coroutine related syntax -keyword.
  show_debug_message("Coroutine finished");
  SET "Finished"
  DELAY 1.0 SECONDS

FINISH DISPATCH


// Helper cororutine for printing out current result of first coroutine.
// This showcases use of ".Get()" method.
COROUTINE BEGIN
  WHILE this.coroutine.isFinished() == false THEN
    DELAY 0.25 SECONDS
    show_debug_message(this.coroutine.Get());
  END
FINISH DISPATCH


// Helper cororutine for unpausing first coroutine one bit later.
COROUTINE BEGIN
  DELAY 4.0 SECONDS
  this.coroutine.Resume();
FINISH DISPATCH


