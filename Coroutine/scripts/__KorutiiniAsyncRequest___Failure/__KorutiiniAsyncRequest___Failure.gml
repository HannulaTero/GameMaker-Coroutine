

/**
* Make Async request fail.
* 
* @context __KorutiiniAsyncRequest
* @returns {__KorutiiniAsyncRequest}
*/ 
function __KorutiiniAsyncRequest__Failure()
{
  failed = true;
  onFailure(self);
  Destroy();
  return self;
}