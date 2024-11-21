/// @desc COROUTINE EXECUTION.


// No active coroutines, quit early.
if (ds_list_size(COROUTINE_LIST_ACTIVE) <= 0)
{
  exit;
}

// Fetch these beforehand for slight optimization.
var _gameSpeed = game_get_speed(gamespeed_microseconds) / 1_000.0;
var _timeBegin = COROUTINE_FRAME_TIME_BEGIN;

// Fetch the coroutine.
COROUTINE_INDEX = 0;
var _coroutine = COROUTINE_LIST_ACTIVE[| COROUTINE_INDEX];
with(_coroutine)
{
  // Preparations.
  COROUTINE_CURRENT = self;
  COROUTINE_EXECUTE = execute;
  COROUTINE_RESULT = undefined;
  COROUTINE_LOCAL = local;
  COROUTINE_SCOPE = scope;
  COROUTINE_YIELD = false;
  
  // Launch the coroutine.
  coroutine_execute(trigger.onLaunch);
}


// Do-until to ensure something happens, even if frame-budget is exceeded.
// try-catch block to catch any errors and not to crash.
try 
{ 
  do 
  {  
    // Execute current coroutine.
    COROUTINE_EXECUTE();
  
    // Check whether coroutine yielded.
    if (COROUTINE_YIELD)
    {
      // Yield current coroutine.
      with(_coroutine)
      {
        coroutine_execute(trigger.onYield);
        execute = COROUTINE_EXECUTE;
        result = COROUTINE_RESULT;
      }
        
      // Check whether there are more coroutines available.
      if (++COROUTINE_INDEX >= ds_list_size(COROUTINE_LIST_ACTIVE))
      {
        break;
      }
    
      // Fetch next coroutine.
      _coroutine = COROUTINE_LIST_ACTIVE[| COROUTINE_INDEX];
      with(_coroutine)
      {
        // Preparations.
        COROUTINE_CURRENT = self;
        COROUTINE_EXECUTE = execute;
        COROUTINE_RESULT = undefined;
        COROUTINE_LOCAL = local;
        COROUTINE_SCOPE = scope;
        COROUTINE_YIELD = false;
      
        // Launch the coroutine.
        coroutine_execute(trigger.onLaunch);
      }
    }
  }
  
  // As this check is regularly done, it should be optimized.
  // So even though separate function exists, this is how it's done now.
  until(((current_time - _timeBegin) / _gameSpeed) >= margin);
} 

// Something wrong happened while executing coroutine.
catch(_error)
{
  var _line = string_repeat("=", 64);
  show_debug_message(_line);
  show_debug_message(_error);
  show_debug_message(_line);
  coroutine_execute(_coroutine.trigger.onError);
}
  
  
// Check if time ran out and Coroutine was forced to yield.
if (COROUTINE_YIELD == false)
{
  with(_coroutine)
  {
    coroutine_execute(trigger.onYield);
    execute = COROUTINE_EXECUTE;
  }
}

// Clear the globals.
COROUTINE_CURRENT = undefined;
COROUTINE_EXECUTE = undefined;
COROUTINE_RESULT = undefined;
COROUTINE_LOCAL = undefined;
COROUTINE_SCOPE = undefined;
COROUTINE_YIELD = undefined;
