

/**
* 
* 
* @context __CoroutineAsyncRequest
* @returns {Any}
*/ 
function __CoroutineAsyncRequest__DoRequest()
{
  if (onRequest != undefined)
  {
    request = onRequest();
  }
    
  if (request == -1)
  || (request == undefined)
  {
    onFailure();
    Destroy();
    return;
  }
  
  COROUTINE_ASYNC_REQUESTS[? request] = self;
  return self;
}