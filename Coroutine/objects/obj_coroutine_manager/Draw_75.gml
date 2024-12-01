/// @desc COROUTINE EXECUTION.
//
// In Draw GUI event, so it would be last thing to do.
// But also as draw event, so coroutines can draw


// Get the maximum time used for coroutines.
// Rescale margin to accommodate heavy GPU calculations, which usage time can't be directly calculated.
var _gameSpeed = game_get_speed(gamespeed_microseconds) / 1_000.0;
var _timeBegin = COROUTINE_FRAME_TIME_BEGIN;

margin = lerp(margin, 0.9 * sqr(_gameSpeed / max(_gameSpeed, delta_time / 1_000.0)), 0.1);
var _maxTime = current_time + margin * _gameSpeed;


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

with(COROUTINE_POOL_ACTIVE[? _coroutines[_index]])
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
      with(COROUTINE_POOL_ACTIVE[? _coroutines[_index]])
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
  until(current_time >= _maxTime);
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









