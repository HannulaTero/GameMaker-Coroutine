

/**
* Make Async request fail.
* 
* @context __CoroutineAsyncRequest
* @returns {__CoroutineAsyncRequest}
*/ 
function __CoroutineAsyncRequest__Failure()
{
  failed = true;
  onFailure(self);
  Destroy();
  return self;
}