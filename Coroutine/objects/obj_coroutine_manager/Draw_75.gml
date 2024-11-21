/// @desc COROUTINE EXECUTION.


// No active coroutines, quit early.
var _count = ds_map_size(COROUTINE_POOL_ACTIVE);
if (_count <= 0)
{
  exit;
}


// Fetch the coroutine.
var _index = 0;
var _coroutines = ds_map_keys_to_array(COROUTINE_POOL_ACTIVE);
var _coroutine = _coroutines[_index];
with(_coroutine)
{
  // Preparations.
  COROUTINE_CURRENT = self;
  COROUTINE_EXECUTE = execute;
  COROUTINE_LOCAL = local;
  COROUTINE_SCOPE = scope;
  COROUTINE_YIELD = false;
  
  // Launch the coroutine.
  coroutine_execute(trigger.onLaunch);
}


// Fetch these beforehand for slight optimization.
var _gameSpeed = game_get_speed(gamespeed_microseconds) / 1_000.0;
var _timeBegin = COROUTINE_FRAME_TIME_BEGIN;


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
      }
        
      // Check whether there are more coroutines available.
      if (_index >= _count) break;
    
      // Fetch next coroutine.
      _coroutine = _coroutines[_index++];
      with(_coroutine)
      {
        // Preparations.
        COROUTINE_CURRENT = self;
        COROUTINE_EXECUTE = execute;
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
// Store error in coroutine result, and jump over action which caused error.
catch(_error)
{
  COROUTINE_CURRENT.result = _error;
  COROUTINE_CURRENT.execute = method_get_self(COROUTINE_EXECUTE).next;
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


// Clear up the things.
COROUTINE_CURRENT = undefined;
COROUTINE_EXECUTE = undefined;
COROUTINE_LOCAL = undefined;
COROUTINE_SCOPE = undefined;
COROUTINE_YIELD = undefined;
array_resize(_coroutines, 0);









