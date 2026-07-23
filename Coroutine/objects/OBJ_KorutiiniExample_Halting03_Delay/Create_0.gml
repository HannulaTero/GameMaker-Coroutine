/// @desc DELAY.


// DELAY allows halting execution for given period of time.
// Delay only ensures delaying "atleast" given amount, but it is not exactly accurate.
// Also it depends on whether manager is busy with other tasks.


// Macro syntax provides different units to do the delay.
// It uses timesource behind the scenes, so timesource related rules apply. 
KORUTIINI BEGIN

  KorutiiniExample_Log("Let's count seconds!");
  
  // Microseconds.
  DELAY 1_000_000.0 MICROS
  KorutiiniExample_Log("First second.");
  
  // Milliseconds.
  DELAY 1_000.0 MILLIS
  KorutiiniExample_Log("Second second.");
  
  // Seconds.
  DELAY 1.0 SECONDS
  KorutiiniExample_Log("Third second.");
  
  // Frames.
  DELAY 60 FRAMES // assumes 60fps.
  KorutiiniExample_Log("Fourth second!");
  
  
  DELAY 1.0 SECONDS
  KorutiiniExample_Log("That's all folks!");

FINISH DISPATCH



