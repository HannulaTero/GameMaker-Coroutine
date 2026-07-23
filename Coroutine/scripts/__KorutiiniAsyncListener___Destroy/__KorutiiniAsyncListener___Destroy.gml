

/**
* Async listener is removed.
* 
* @context __KorutiiniAsyncRequest
* @returns {__KorutiiniAsyncRequest}
*/ 
function __KorutiiniAsyncListener__Destroy()
{
  static asyncListeners = __KorutiiniRuntime_AsyncListeners();
  
  
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
  
  
  // Put itself into right state, and remove data.
  paused = false;
  finished = true;
  ds_map_delete(asyncListeners[? type], identifier);
  
  if (timer != undefined)
  {
    call_cancel(timer);
  }
    
  if (parentTask != undefined)
  {
    ds_map_delete(parentTask.childListeners, identifier);
  }
  
  return self;
}