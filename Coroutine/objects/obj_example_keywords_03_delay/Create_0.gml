/// @desc DELAY.


// DELAY allows halting execution for given period of time.
// Delay only ensures delaying "atleast" given amount, but it is not exactly accurate.
// Also it depends on whether manager is busy with other tasks.


// Macro syntax provides different units to do the delay.
// It uses timesource behind the scenes, so timesource related rules apply. 
COROUTINE BEGIN

  show_debug_message("Let's count seconds!");
  
  // Microseconds.
  DELAY 1_000_000.0 MICROS
  show_debug_message("First second.");
  
  // Milliseconds.
  DELAY 1_000.0 MILLIS
  show_debug_message("Second second.");
  
  // Seconds.
  DELAY 1.0 SECONDS
  show_debug_message("Third second.");
  
  // Frames.
  DELAY 60 FRAMES // assumes 60fps.
  show_debug_message("Fourth second!");
  
  
  DELAY 1.0 SECONDS
  show_debug_message("That's all folks!");

FINISH DISPATCH



