

/**
* 
* @context __KorutiiniTask
* @returns {Struct.__KorutiiniTask}
*/ 
function __KorutiiniTask__Pause()
{
  static poolActive   = __KorutiiniRuntime_PoolActive();
  static poolPaused   = __KorutiiniRuntime_PoolPaused();
  static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
  
  // Can't pause if it's already paused or destroyed.
  if (finished == true) 
  || (paused == true)
  {
    return self;
  }
      
  // Take a undeterminated break.
  paused = true;
  onPause();
  
  ds_map_delete(poolActive, identifier);
  ds_map_delete(poolDelayed, identifier);
  poolPaused[? identifier] = self;
  
  if (time_source_get_state(delaySource) != time_source_state_stopped)
  {
    time_source_stop(delaySource);
  }
    
  return self;
}