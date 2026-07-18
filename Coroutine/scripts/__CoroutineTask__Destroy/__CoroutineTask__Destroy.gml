

/**
* Directly destroyes the coroutine without triggering onCancel.
* 
* @context __CoroutineTask
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Destroy()
{
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
  
  
  // Trigger Cleanup.
  onCleanup();
  
  
  // Put itself into right state, and remove data.
  paused = false;
  delayed = false;
  finished = true;
  ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
  ds_map_delete(COROUTINE_POOL_PAUSED, identifier);
  ds_map_delete(COROUTINE_POOL_DELAYED, identifier);
  
  
  // Remove itself from all childs.
  var _childTasks = ds_map_keys_to_array(childTasks);
  array_foreach(_childTasks, function(_identifier, i)
  {
    childTasks[? _identifier].parent = undefined;
  });
  array_resize(_childTasks, 0);
  ds_map_destroy(childTasks);
  
  
  // Remove all async requests.
  var _asyncRequests = ds_map_keys_to_array(asyncRequests);
  array_foreach(_asyncRequests, function(_identifier, i)
  {
    asyncRequests[? _identifier].Destroy();
  });
  array_resize(_asyncRequests, 0);
  ds_map_destroy(asyncRequests);
  
  
  // Remove all async listeners.
  var _asyncListeners = ds_map_keys_to_array(asyncListeners);
  array_foreach(_asyncListeners, function(_identifier, i)
  {
    asyncListeners[? _identifier].Destroy();
  });
  array_resize(_asyncListeners, 0);
  ds_map_destroy(asyncListeners);
  
  
  // Destroy the delay-timer.
  time_source_destroy(delaySource);
  if (parent != undefined) 
  {
    ds_map_delete(parent.childTasks, identifier);
  }
  
  
  return self;
}