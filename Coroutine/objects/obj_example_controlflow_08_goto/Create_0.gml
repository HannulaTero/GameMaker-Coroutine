/// @desc GOTO.


// GOTO -statement is direct jump to given label, within coroutine.
// You have to mark jump-points with LABEL's.


// 
COROUTINE BEGIN

  PRINT "";
  PRINT "Do you want to skip dialogue?";
  
  // Note, that GOTO can be mixed with normal GML syntax.
  if (choose(true, false)) 
    GOTO "skip";
  
  PRINT " - Hello world!";
  PRINT " - How are you doing today?";
  PRINT " - Do you want to go for an adventure?";
  GOTO "quit";
  
  LABEL "skip" PASS
  PRINT " - Skipped!";
  
  LABEL "quit" PASS
  PRINT "done.";
  
FINISH DISPATCH



// Following example imitates basic for-loop.
COROUTINE BEGIN

  DELAY 0.5 SECONDS
  PRINT $"Starting a loop made with GOTO statements!";
  
  // Loop header.
  index = 0;
  LABEL "loop start" PASS

  // Loop Condition.
  if (index >= 5)
    GOTO "loop end";
  
  // Loop body.
  PRINT $"Current iteration: {index}";
  DELAY 4 FRAMES
  
  // Loop footer.
  index++;
  GOTO "loop start" PASS 
  LABEL "loop end" PASS
  
  
  PRINT $"Loop is finished!";
  

FINISH DISPATCH 

