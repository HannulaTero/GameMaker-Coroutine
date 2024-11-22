


function test_suite_syntax()
{
  // This is meant to just check syntax correctness.
  // It is not actually executable, as all expressions are empty.
  COROUTINE

  ON_INIT
    
  ON_YIELD
    
  ON_PAUSE
    
  ON_CANCEL
    
  ON_RESUME
    
  ON_LAUNCH
    
  ON_COMPLETE
    
  ON_ERROR

  BEGIN 
    LABEL "goto target" PASS

    IF THEN END
    IF THEN PASS END
    IF THEN ELSE END
    IF THEN ELIF THEN END
    IF THEN ELIF THEN ELIF THEN END
    IF THEN ELIF THEN ELSE END
    IF THEN ELIF THEN ELIF THEN ELSE END
  
    IF THEN IF THEN END END
    IF THEN IF THEN END PASS END
    IF THEN IF THEN END ELSE END
    IF THEN IF THEN END ELIF THEN END
    IF THEN IF THEN END ELIF THEN ELIF THEN END
    IF THEN IF THEN END ELIF THEN ELSE END
    IF THEN IF THEN END ELIF THEN ELIF THEN ELSE END
  
    FOR COND ITER THEN END
    FOR COND ITER THEN IF THEN END END
    FOR COND ITER THEN FOR COND ITER THEN END END
    
    FOR COND ITER THEN BREAK END
    FOR COND ITER THEN CONTINUE END
    FOR COND ITER THEN RETURN undefined; END
    FOR COND ITER THEN EXIT END
    
  
    WHILE THEN END
    REPEAT THEN END
    FOREACH IN THEN END
    FOREACH key IN THEN END
    FOREACH key, value IN THEN END
    FOREACH value, key IN THEN END
    FOREACH i: key, value IN THEN END
    FOREACH i: key, item: value IN THEN END
    FOREACH i: key, item: value IN VIEW() THEN END
    FOREACH i: key, item: value IN RANGE() THEN END

    AWAIT PASS
    DELAY SECONDS 
    YIELD PASS
    PAUSE PASS
  
    FOR COND ITER THEN
      AWAIT PASS
      DELAY MILLIS 
      YIELD PASS
      PAUSE PASS
  
    END
    
    LOOP END
    LOOP LOOP END END
    
    SWITCH END
    SWITCH CASE THEN END
    SWITCH CASE THEN CASE THEN END
    SWITCH CASE THEN CASE THEN DEFAULT END
    
    
    
    AWAIT true PASS
    
    AWAIT_ASYNC
    AWAIT_COROUTINE
    AWAIT_BROADCAST
    AWAIT_CHILDRENS
    
    GOTO "goto target";
    
  FINISH DISPATCH
}




