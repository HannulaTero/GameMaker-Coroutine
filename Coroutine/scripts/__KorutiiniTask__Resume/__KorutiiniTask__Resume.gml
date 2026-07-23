

/**
* 
* @context __KorutiiniTask
* @returns {Struct.__KorutiiniTask}
*/ 
function __KorutiiniTask__Resume()
{
  static poolActive   = __KorutiiniRuntime_PoolActive();
  static poolPaused   = __KorutiiniRuntime_PoolPaused();
  static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
  
  // Can't resume if it's not paused or destroyed.
  if (finished == true) 
  || (delayed == true)
  || (paused == false)
  {
    return self;
  }
      
  // Return to the usual action.
  paused = false;
  onResume();
  ds_map_delete(poolPaused, identifier);
  poolActive[? identifier] = self;
  return self;
}