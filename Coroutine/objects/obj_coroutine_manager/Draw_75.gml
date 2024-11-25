/// @desc COROUTINE EXECUTION.
//
// In Draw GUI event, so it would be last thing to do.
// But also as draw event, so coroutines can draw.


// No active coroutines, quit early.
var _count = ds_map_size(COROUTINE_POOL_ACTIVE);
if (_count <= 0)
{
  exit;
}


// Fetch the coroutine.
var _index = 0;
var _coroutines = ds_map_keys_to_array(COROUTINE_POOL_ACTIVE);
array_shuffle_ext(_coroutines); // To give coroutines equal change.

with(_coroutines[_index])
{
  // Preparations.
  COROUTINE_CURRENT_TASK    = self;
  COROUTINE_CURRENT_EXECUTE = execute;
  COROUTINE_CURRENT_LOCAL   = local;
  COROUTINE_CURRENT_SCOPE   = scope;
  COROUTINE_CURRENT_YIELDED = false;
  
  // Launch the coroutine.
  onLaunch();
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
    COROUTINE_CURRENT_EXECUTE();
  
    // Check whether coroutine yielded.
    if (COROUTINE_CURRENT_YIELDED)
    {
      // Yield current coroutine.
      COROUTINE_CURRENT_TASK.execute = COROUTINE_CURRENT_EXECUTE;
      COROUTINE_CURRENT_TASK.onYield();
        
      // Check whether there are more coroutines available.
      if (++_index >= _count) break;
    
      // Fetch next coroutine.
      with(_coroutines[_index])
      {
        // Preparations.
        COROUTINE_CURRENT_TASK    = self;
        COROUTINE_CURRENT_EXECUTE = execute;
        COROUTINE_CURRENT_LOCAL   = local;
        COROUTINE_CURRENT_SCOPE   = scope;
        COROUTINE_CURRENT_YIELDED = false;
      
        // Launch the coroutine.
        onLaunch();
      }
    }
  }
  
  // As this check is regularly done, it should be optimized.
  // So even though separate function exists, this is how it's done now.
  until(((current_time - _timeBegin) / _gameSpeed) >= margin);
} 

// Something wrong happened while executing coroutine.
// Coroutine tries to jump over action which caused error.
catch(_error)
{
  show_debug_message("\n{1}\n\n{0}\n\n{1}\n\n", _error, string_repeat("=", 64));
  COROUTINE_CURRENT_TASK.execute = method_get_self(COROUTINE_CURRENT_EXECUTE).next;
  COROUTINE_CURRENT_TASK.onError();
}
  
  
// Check if time ran out and Coroutine was forced to yield.
if (COROUTINE_CURRENT_YIELDED == false)
{
  COROUTINE_CURRENT_TASK.execute = COROUTINE_CURRENT_EXECUTE;
  COROUTINE_CURRENT_TASK.onYield();
}


// Clean up the things.
COROUTINE_CURRENT_TASK    = undefined;
COROUTINE_CURRENT_EXECUTE = undefined;
COROUTINE_CURRENT_LOCAL   = undefined;
COROUTINE_CURRENT_SCOPE   = undefined;
COROUTINE_CURRENT_YIELDED = undefined;
array_resize(_coroutines, 0);









