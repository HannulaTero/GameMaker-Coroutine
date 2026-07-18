

/**
* 
* 
* @param {Struct} _params
*/
function __CoroutineAsyncRequest(_params) constructor 
{
  // Static variables.
  static counter = 0;
  
  
  // Static methods.
  static Destroy    = __CoroutineAsyncRequest__Destroy;
  static DoRequest  = __CoroutineAsyncRequest__DoRequest;
  static Failure    = __CoroutineAsyncRequest__Failure;
  static Get        = __CoroutineAsyncRequest__Get;
  static HasFailed  = __CoroutineAsyncRequest__HasFailed;
  static IsFinished = __CoroutineAsyncRequest__IsFinished;
  static Success    = __CoroutineAsyncRequest__Success;
  
  
  // Unique identifier.
  identifier = counter++;
  
  
  // Async variables.
  type      = _params.option[$ "type"];
  name      = _params.option[$ "name"] ?? $"ASYNC Request[{identifier}]";
  desc      = _params.option[$ "desc"] ?? "";
  this      = _params.option[$ "this"] ?? other; 
  timeout   = _params.option[$ "timeout"]; // seconds.
  retries   = _params.option[$ "retries"] ?? 0;
  request   = _params.option[$ "request"];
  result    = undefined;
  paused    = false;
  failed    = false;
  finished  = false;
  parent    = undefined;
  timer     = undefined;
  
  
  // Sanity check:
  if (request == undefined)
  && (struct_exists(_params, "onRequest") == false)
  {
    throw($"ASYNC Request: request or onRequest must be defined.");
  }
  
  
  // Callbacks.
  var _nop = function() {};
  onRequest = _params[$ "onRequest"];
  onPending = method(this, _params[$ "onPending"] ?? _nop);
  onSuccess = method(this, _params[$ "onSuccess"] ?? _nop);
  onFailure = method(this, _params[$ "onFailure"] ?? _nop);
  onTimeout = method(this, _params[$ "onTimeout"] ?? _nop);
  
  if (onRequest != undefined) 
  {
    onRequest = method(this, _params[$ "onRequest"]);
  }
  
  
  // Do the initialization steps.
  DoRequest();
  if (COROUTINE_CURRENT_TASK != undefined)
  {
    parent = COROUTINE_CURRENT_TASK;
    parent.asyncRequests[? identifier] = self;
  }
  
  
  // Make timeout -timer.
  // Try making request as many times as there are retries left.
  if (timeout != undefined)
  {
    timer = call_later(timeout, time_source_units_seconds, function()
    {
      if (retries-- > 0) 
      {
        DoRequest();
        return;
      }
      onTimeout(self);
      Destroy(); 
    }, true);
  }
}




