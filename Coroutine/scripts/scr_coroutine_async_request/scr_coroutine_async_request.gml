
/// @func CoroutineAsyncRequest(_params);
/// @desc
/// @param {Struct} _params
// feather ignore GM2043
function CoroutineAsyncRequest(_params) constructor 
{
  static counter = 0;
  identifier = counter++;
  
  // Async variables.
  type = _params.option[$ "type"];
  name = _params.option[$ "name"] ?? $"ASYNC Request[{identifier}]";
  desc = _params.option[$ "desc"] ?? "";
  scope = _params.option[$ "scope"] ?? other; 
  timeout = _params.option[$ "timeout"]; // seconds.
  retries = _params.option[$ "retries"] ?? 0;
  request = _params.option[$ "request"];
  result = undefined;
  paused = false;
  failed = false;
  finished = false;
  parent = undefined;
  timer = undefined;
  
  
  // Sanity check:
  if (request == undefined)
  && (struct_exists(_params, "onRequest") == false)
    throw($"ASYNC Request: request or onRequest must be defined.");
  
  
  // Callbacks.
  var _nop = function() {};
  onRequest = _params[$ "onRequest"];
  onPending = method(scope, _params[$ "onPending"] ?? _nop);
  onSuccess = method(scope, _params[$ "onSuccess"] ?? _nop);
  onFailure = method(scope, _params[$ "onFailure"] ?? _nop);
  onTimeout = method(scope, _params[$ "onTimeout"] ?? _nop);
  
  if (onRequest != undefined) 
    onRequest = method(scope, _params[$ "onRequest"]);
  
  
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
  
  
  /// @func DoRequest();
  /// @desc 
  /// @returns {Any}
  static DoRequest = function()
  {
    if (onRequest != undefined)
      request = onRequest();
    
    if (request == -1)
    || (request == undefined)
    {
      onFailure();
      Destroy();
      return;
    }
    COROUTINE_ASYNC_REQUESTS[? request] = self;
    return self;
  };
  
  
  /// @func Get();
  /// @desc Async request current result.
  /// @returns {Any}
  static Get = function()
  {
    return result;
  };
  
  
  /// @func Success();
  /// @desc Make Async request succeed.
  /// @returns {Any}
  static Success = function()
  {
    onSuccess(self);
    Destroy();
    return self;
  };
  
  
  /// @func Failure();
  /// @desc Make Async request fail.
  /// @returns {Any}
  static Failure = function()
  {
    failed = true;
    onFailure(self);
    Destroy();
    return self;
  };
    
  
  /// @func hasFailed();
  /// @desc Check whether request has failed.
  /// @returns {Bool} 
  static hasFailed = function()
  {
    return failed;
  }; 
    
  
  /// @func isFinished();
  /// @desc Check whether request has been finished.
  /// @returns {Bool} 
  static isFinished = function()
  {
    return finished;
  }; 
  
  
  /// @func Destroy();
  /// @desc Async request is removed.
  /// @returns {Struct.CoroutineAsyncRequest}
  static Destroy = function()
  {
    // Can't destroy what has already been destroyed.
    if (finished == true) 
      return self;
      
    // Put itself into right state, and remove data.
    paused = false;
    finished = true;
    ds_map_delete(COROUTINE_ASYNC_REQUESTS, request);
    if (timer != undefined)
      call_cancel(timer);
    if (parent != undefined)
      ds_map_delete(parent.asyncRequests, identifier);
    return self;
  };
}




