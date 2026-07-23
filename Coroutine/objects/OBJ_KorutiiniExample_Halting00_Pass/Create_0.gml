/// @desc PASS.


// PASS is a keyword, which is required separator on some situations.
// But it can be used independently to split GML code in chunks.
// PASS does not halt execution by itself, it just helps split GML code into chunks.
KORUTIINI BEGIN
  KorutiiniExample_Log("First");
  PASS
  KorutiiniExample_Log("Second");
  PASS
  KorutiiniExample_Log("Third");
  PASS
  KorutiiniExample_Log("Fourth");
  PASS
FINISH DISPATCH


// PASS, and other Coroutine syntax, splits code into parts.
// These chunks are executed one by one, until nothing more can be executed.
// But chunk transitions works as yielding points whenever frame-budget is exceeding.

// Splitting GML code can be useful, if overall code would otherwise take too long time.
// Note, that PASS doesn't give room for other tasks like YIELD does. PASS will not halt task execution, it splits into chunks.
// It's the coroutine task manager, which may decide to halt at PASS.


// Following example would normally stutter game for long time, 
// but manager is able to split execution to several frames because of PASS. 
KORUTIINI BEGIN
  KorutiiniExample_Log("Begin long execution.");
  
  // This function loops 15-32 ms
  // -> This means it can take multiple frames.
  self.counter = 0;
  self.LongLoop = function() 
  {
    var _time = current_time + irandom_range(50, 100); 
    while(current_time < _time) { };
    KorutiiniExample_Log($"Loop [{self.counter}] done!");
    self.counter += 1;
  };
  
  // Execute loop several times.
  // -> Each call cann multiple frames, and together several seconds.
  //    That's long time game to be paused, which is undesireable.
  // -> With coroutines their execution is split instead, allowing regular game logic to execute in-between.
  //    This means game doesn't have long pause, but smaller stutters (as LongLoop itself isn't coroutine).
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS
  self.LongLoop(); PASS

  KorutiiniExample_Log("Finished execution.");
  KorutiiniExample_Log(" -> With coroutine splitting, game didn't freeze.");
  
FINISH DISPATCH