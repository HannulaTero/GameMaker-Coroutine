

/**
* Make Async request succeed.
* 
* @context __CoroutineAsyncRequest
* @returns {__CoroutineAsyncRequest}
*/ 
function __CoroutineAsyncRequest__Success()
{
  onSuccess(self);
  Destroy();
  return self;
}

