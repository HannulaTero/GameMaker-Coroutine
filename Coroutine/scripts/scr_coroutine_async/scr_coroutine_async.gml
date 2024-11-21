
/// @func CoroutineAsync(_params);
/// @desc
/// @param {Struct} _params
function CoroutineAsync(_params) constructor 
{
  static counter = 0;
  
  // Async variables.
  self.type = _params[$ "type"];
  self.name = _params[$ "name"] ?? $"ASYNC[{ptr(self)}]";
  self.desc = _params[$ "desc"] ?? "";
  self.request = undefined;
  self.timeout = _params[$ "timeout"]; // seconds.
  self.retries = _params[$ "retries"] ?? 0;
  self.timer = undefined;
  
  
  // Callbacks.
  self.onListen = undefined;
  self.onRequest = undefined;
  self.onWaiting = function() {};
  self.onSuccess = function() {};
  self.onFailure = function() {};
  self.onTimeout = function() {};
  
  
  // Sanity check:
  if (type == undefined)
    throw($"ASYNC expects a async event -type.");
  
  
  /// @func isFinished();
  /// @desc Check whether request has been finished.
  /// @returns {Bool} 
  static isFinished = function()
  {
    var _finished = true;
    if (onListen != undefined)
      _finished = _finished && (ds_map_exists(COROUTINE_ASYNC_LISTENERS, type) == false);
    if (onRequest != undefined)
     _finished = _finished && (ds_map_exists(COROUTINE_ASYNC_REQUESTS, type) == false);
    return _finished;
  };
  
  
  /// @func AsyncDispatch();
  /// @desc 
  /// @returns {Struct.CoroutineAsync}
  static AsyncDispatch = function()
  {
    // Async listener has been made.
    if (onListen != undefined)
    {
      if (ds_map_exists(COROUTINE_ASYNC_LISTENERS, type) == false)
        throw($"ASYNC Listener: async event type is invalid: '{type}'.");
      COROUTINE_ASYNC_LISTENERS[? type][? self] = self;
    }
    
    // Async request has been made.
    if (onRequest != undefined)
    {
      if (ds_map_exists(COROUTINE_ASYNC_REQUESTS, type) == false)
        throw($"ASYNC Request: async event type is invalid: '{type}'.");
      DoRequest();
    }
     
    // Make timeout -timer.
    if (timeout != undefined)
    {
      timer = call_later(timeout, time_source_units_seconds, function()
      {
        onTimeout();
        return (retries-- > 0) 
          ? DoRequest() // Still retries left, keep doing the request. Is this good action?
          : Remove();   // The retries has been exhausted.
      }, true);
    }
    
    return self;
  };
  
  
  /// @func Remove();
  /// @desc Async action is removed.
  /// @returns {Struct.CoroutineAsync}
  static Remove = function()
  {
    if (onListen != undefined)
      ds_map_delete(COROUTINE_ASYNC_LISTENERS[? type], self);
      
    if (onRequest != undefined)
      ds_map_delete(COROUTINE_ASYNC_REQUESTS[? type], self);
      
    if (timer != undefined)
      call_cancel(timer);
      
    return self;
  };
  
  
  /// @func DoRequest();
  /// @desc 
  /// @returns {Struct.CoroutineAsync}
  static DoRequest = function()
  {
    if (onRequest == undefined)
      return;
    
    self.request = onRequest();
    if (request == -1)
    || (request == undefined)
    {
      onFailure();
      Remove();
    }
    COROUTINE_ASYNC_REQUESTS[? type][? request] = self;
    return self;
  };
  
  
  /// @func SetRequest(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetRequest = function(_func)
  {
    self.onRequest = _func;
    return self;
  };
  
  
  /// @func SetWaiting(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetWaiting = function(_func)
  {
    self.onWaiting = _func;
    return self;
  };
  
  
  /// @func SetSuccess(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetSuccess = function(_func)
  {
    self.onSuccess = _func;
    return self;
  };
  
  
  /// @func SetFailure(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetFailure = function(_func)
  {
    self.onFailure = _func;
    return self;
  };
  
  
  /// @func SetTimeout(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetTimeout = function(_func)
  {
    self.onTimeout = _func;
    return self;
  };
  
  
  /// @func SetListen(_func);
  /// @desc 
  /// @param {Function} _func
  /// @returns {Struct.CoroutineAsync}
  static SetListen = function(_func)
  {
    self.onListen = _func;
    return self;
  };
}




