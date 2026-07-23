

/**
* Directly destroyes the coroutine without triggering onCancel.
* 
* @context __KorutiiniTask
* @returns {Struct.__KorutiiniTask}
*/ 
function __KorutiiniTask__Destroy()
{
  static poolActive   = __KorutiiniRuntime_PoolActive();
  static poolPaused   = __KorutiiniRuntime_PoolPaused();
  static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
  
  
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
  
  
  // Trigger Cleanup.
  onCleanup();
  
  
  // Put itself into right state, and remove data.
  paused    = false;
  delayed   = false;
  finished  = true;
  ds_map_delete(poolActive,   identifier);
  ds_map_delete(poolPaused,   identifier);
  ds_map_delete(poolDelayed,  identifier);
  
  
  // Remove itself from all childs.
  var _childTasks = ds_map_keys_to_array(childTasks);
  array_foreach(_childTasks, function(_identifier, i)
  {
    childTasks[? _identifier].parentTask = undefined;
  });
  array_resize(_childTasks, 0);
  ds_map_destroy(childTasks);
  
  
  // Remove all async requests.
  var _childRequests = ds_map_keys_to_array(childRequests);
  array_foreach(_childRequests, function(_identifier, i)
  {
    childRequests[? _identifier].Destroy();
  });
  array_resize(_childRequests, 0);
  ds_map_destroy(childRequests);
  
  
  // Remove all async listeners.
  var _childListeners = ds_map_keys_to_array(childListeners);
  array_foreach(_childListeners, function(_identifier, i)
  {
    childListeners[? _identifier].Destroy();
  });
  array_resize(_childListeners, 0);
  ds_map_destroy(childListeners);
  
  
  // Destroy the delay-timer.
  time_source_destroy(delaySource);
  if (parentTask != undefined) 
  {
    ds_map_delete(parentTask.childTasks, identifier);
  }
  
  
  return self;
}