

/**
* Async request is removed.
* 
* @context __CoroutineAsyncRequest
* @returns {__CoroutineAsyncRequest}
*/ 
function __CoroutineAsyncRequest__Destroy()
{
  // Can't destroy what has already been destroyed.
  if (finished == true) 
  {
    return self;
  }
      
  // Put itself into right state, and remove data.
  paused = false;
  finished = true;
  ds_map_delete(COROUTINE_ASYNC_REQUESTS, request);
  
  if (timer != undefined)
  {
    call_cancel(timer);
  }
  
  if (parent != undefined)
  {
    ds_map_delete(parent.asyncRequests, identifier);
  }
  
  return self;
}