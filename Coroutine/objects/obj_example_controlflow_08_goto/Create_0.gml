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



// Gotos are useful to break out nested loops.
COROUTINE BEGIN

  DELAY 1.0 SECONDS
  PRINT $"Jumping out of nested loops with goto";
  
  WHILE true THEN
    show_debug_message("1st loop: while") 
    
    FOR i = 0 COND i < 10 ITER i++ THEN
      show_debug_message("2nd loop: for")  
      
      LOOP 
        show_debug_message("3rd loop: loop")  
        
        REPEAT 10 THEN
          show_debug_message("4th loop: repeat")  
          GOTO "quit nested loop";
          
        END 
      END 
    END 
  END
  
  LABEL "quit nested loop" PASS
  show_debug_message("Broke out of all loops in one go.");  
  
FINISH DISPATCH 











