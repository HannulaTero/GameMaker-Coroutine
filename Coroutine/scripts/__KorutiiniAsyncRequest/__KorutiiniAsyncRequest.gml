

/**
* 
* 
* @param {Struct} _params
*/
function __KorutiiniAsyncRequest(_params) constructor 
{
  // Static variables.
  static counter = 0;
  
  
  // Static methods.
  static Destroy    = __KorutiiniAsyncRequest__Destroy;
  static DoRequest  = __KorutiiniAsyncRequest__DoRequest;
  static Failure    = __KorutiiniAsyncRequest__Failure;
  static Get        = __KorutiiniAsyncRequest__Get;
  static HasFailed  = __KorutiiniAsyncRequest__HasFailed;
  static IsFinished = __KorutiiniAsyncRequest__IsFinished;
  static Success    = __KorutiiniAsyncRequest__Success;
  
  
  // Unique identifier.
  identifier = counter++;
  
  
  // Async variables.
  type        = _params.option[$ "type"];
  name        = _params.option[$ "name"] ?? $"ASYNC Request[{identifier}]";
  desc        = _params.option[$ "desc"] ?? "";
  this        = _params.option[$ "this"] ?? other; 
  timeout     = _params.option[$ "timeout"]; // seconds.
  retries     = _params.option[$ "retries"] ?? 0;
  request     = _params.option[$ "request"];
  result      = undefined;
  paused      = false;
  failed      = false;
  finished    = false;
  parentTask  = undefined;
  timer       = undefined;
  
  
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
  if (KORUTIINI_CURRENT_TASK != undefined)
  {
    parentTask = KORUTIINI_CURRENT_TASK;
    parentTask.childRequests[? identifier] = self;
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




