/// @desc PASS.


// PASS is a keyword, which is required separator on some situations.
// But it can be used independently to split GML code in chunks.
COROUTINE BEGIN
  show_debug_message("First");
  PASS
  show_debug_message("Second");
  PASS
  show_debug_message("Third");
  PASS
  show_debug_message("Fourth");
  PASS
FINISH DISPATCH


// PASS, and other Coroutine syntax works as forced yielding points whenever frame-budget is exceeding.
// Splitting GML code can be useful, if overall code would otherwise take too long time.
// Note, that PASS doesn't give room for other tasks like YIELD does.


// Following example would normally stutter game for several frames, 
// but manager can split execution to several frames because of PASS. 
COROUTINE BEGIN
  show_debug_message("Begin long execution.");
  
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS
  time = current_time; while((current_time - time) < 16) {} PASS

  show_debug_message("Finished execution.");
  
FINISH DISPATCH