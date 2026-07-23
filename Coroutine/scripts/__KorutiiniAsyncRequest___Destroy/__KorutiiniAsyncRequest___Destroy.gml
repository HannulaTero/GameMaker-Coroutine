

/**
* Async request is removed.
* 
* @context __KorutiiniAsyncRequest
* @returns {__KorutiiniAsyncRequest}
*/ 
function __KorutiiniAsyncRequest__Destroy()
{
  static asyncRequests = __KorutiiniRuntime_AsyncRequests();
  
  
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
  
  
  // Put itself into right state, and remove data.
  paused = false;
  finished = true;
  ds_map_delete(asyncRequests, request);
  
  if (timer != undefined)
  {
    call_cancel(timer);
  }
  
  if (parentTask != undefined)
  {
    ds_map_delete(parentTask.childRequests, identifier);
  }
  
  return self;
}