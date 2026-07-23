

/**
* 
* 
* @context __KorutiiniAsyncRequest
* @returns {Any}
*/ 
function __KorutiiniAsyncRequest__DoRequest()
{
  static asyncRequests = __KorutiiniRuntime_AsyncRequests();
  
  
  if (onRequest != undefined)
  {
    request = onRequest();
  }
  
  
  if (request == -1)
  || (request == undefined)
  {
    onFailure();
    Destroy();
    return self;
  }
  
  
  asyncRequests[? request] = self;
  return self;
}