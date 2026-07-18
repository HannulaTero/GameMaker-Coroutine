

/**
* Async listener is removed.
* 
* @context __CoroutineAsyncRequest
* @returns {__CoroutineAsyncRequest}
*/ 
function __CoroutineAsyncListener__Destroy()
{
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
      
  // Put itself into right state, and remove data.
  paused = false;
  finished = true;
  ds_map_delete(COROUTINE_ASYNC_LISTENERS[? type], identifier);
  
  if (timer != undefined)
  {
    call_cancel(timer);
  }
    
  if (parent != undefined)
  {
    ds_map_delete(parent.asyncListeners, identifier);
  }
  
  return self;
}