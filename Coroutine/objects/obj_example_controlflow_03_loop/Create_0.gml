/// @desc LOOP.


// Simplest loop, which will not stop by itself.
// It will keep repeating contents until either breaks out with keyword, or task is destroyed.
// -> Note! Without YIELD it would loop until frame-budget is consumed, and then it is forced to yield
//    And it will do that every frame whenever it gets turn from manager.
//    So it can be good thing to put yield in a loop somewhere.
task = COROUTINE BEGIN

  LOOP 
    show_debug_message("Hello world!");
    YIELD
  END
  show_debug_message("It will never get here!");

FINISH DISPATCH 



// Helper coroutine to smother first one.
COROUTINE BEGIN 
  DELAY 1.0 SECONDS 
  this.task.Destroy();
  show_debug_message("Another coroutine broke the loop!");
FINISH DISPATCH