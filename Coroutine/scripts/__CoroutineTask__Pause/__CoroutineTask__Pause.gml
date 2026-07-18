

/**
* 
* @context __CoroutineTask
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Pause()
{
  // Can't pause if it's already paused or destroyed.
  if (finished == true) 
  || (paused == true)
  {
    return self;
  }
      
  // Take a undeterminated break.
  paused = true;
  onPause();
  ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
  ds_map_delete(COROUTINE_POOL_DELAYED, identifier);
  COROUTINE_POOL_PAUSED[? identifier] = self;
  if (time_source_get_state(delaySource) != time_source_state_stopped)
  {
    time_source_stop(delaySource);
  }
    
  return self;
}