

/**
* Make Async request succeed.
* 
* @context __KorutiiniAsyncRequest
* @returns {__KorutiiniAsyncRequest}
*/ 
function __KorutiiniAsyncRequest__Success()
{
  onSuccess(self);
  Destroy();
  return self;
}

