

/**
* 
* @context __CoroutineTask
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Resume()
{
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
  ds_map_delete(COROUTINE_POOL_PAUSED, identifier);
  COROUTINE_POOL_ACTIVE[? identifier] = self;
  return self;
}