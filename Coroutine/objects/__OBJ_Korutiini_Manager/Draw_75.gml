/// @desc KORUTIINI EXECUTION.
//
// In Draw GUI event, so it would be last thing to do.
// But also as draw event, so coroutines can draw


// Preparations.
var _poolActive = __KorutiiniRuntime_PoolActive();


// Get the maximum time used for coroutines.
// Rescale margin to accommodate heavy GPU calculations, which usage time can't be directly calculated.
var _gameSpeed = game_get_speed(gamespeed_microseconds) / 1_000.0;
var _timeBegin = __Korutiini_FrameTime_FrameBegin();

self.margin = lerp(self.margin, 0.9 * sqr(_gameSpeed / max(_gameSpeed, delta_time / 1_000.0)), 0.1);
var _maxTime = (current_time + self.margin * _gameSpeed);


// No active coroutines, quit early.
var _count = ds_map_size(_poolActive);
if (_count <= 0)
{
  exit;
}


// Get the list of coroutines.
var _index = 0;
var _coroutines = ds_map_keys_to_array(_poolActive);
array_shuffle_ext(_coroutines); // To give coroutines equal change. 


// Trigger Launch-event for the first one.
with(_poolActive[? _coroutines[_index]])
{
  // Preparations.
  KORUTIINI_CURRENT_TASK    = self;
  KORUTIINI_CURRENT_EXECUTE = execute;
  KORUTIINI_CURRENT_LOCAL   = local;
  KORUTIINI_CURRENT_SCOPE   = scope;
  KORUTIINI_CURRENT_YIELDED = false;
  
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
    KORUTIINI_CURRENT_EXECUTE();
  
    // Check whether coroutine yielded.
    if (KORUTIINI_CURRENT_YIELDED)
    {
      // Yield current coroutine.
      KORUTIINI_CURRENT_TASK.execute = KORUTIINI_CURRENT_EXECUTE;
      KORUTIINI_CURRENT_TASK.onYield();
        
      // Check whether there are more coroutines available.
      if (++_index >= _count) break;
    
      // Fetch next coroutine.
      with(_poolActive[? _coroutines[_index]])
      {
        // Preparations.
        KORUTIINI_CURRENT_TASK    = self;
        KORUTIINI_CURRENT_EXECUTE = execute;
        KORUTIINI_CURRENT_LOCAL   = local;
        KORUTIINI_CURRENT_SCOPE   = scope;
        KORUTIINI_CURRENT_YIELDED = false;
      
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
  KORUTIINI_CURRENT_TASK.execute = method_get_self(KORUTIINI_CURRENT_EXECUTE).next;
  KORUTIINI_CURRENT_TASK.onError();
}


// Check if time ran out and Coroutine was forced to yield.
// -> Have to call the yield separately.
if (KORUTIINI_CURRENT_YIELDED == false)
{
  KORUTIINI_CURRENT_TASK.execute = KORUTIINI_CURRENT_EXECUTE;
  KORUTIINI_CURRENT_TASK.onYield();
}


// Clean up the things.
KORUTIINI_CURRENT_TASK    = undefined;
KORUTIINI_CURRENT_EXECUTE = undefined;
KORUTIINI_CURRENT_LOCAL   = undefined;
KORUTIINI_CURRENT_SCOPE   = undefined;
KORUTIINI_CURRENT_YIELDED = undefined;
array_resize(_coroutines, 0);









