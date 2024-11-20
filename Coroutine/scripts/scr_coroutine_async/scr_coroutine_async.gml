
/// @func CoroutineAsync(_params);
/// @desc
/// @param {Struct} _params
function CoroutineAsync(_params) constructor 
{
  // Async variables.
  self.handle = undefined;
  self.type = _params[$ "type"];
  self.name = _params[$ "name"] ?? $"ASYNC Request [{handle}]";
  self.desc = _params[$ "desc"] ?? $"";
  self.timeout = _params[$ "timeout"] ?? 300.0; // in seconds.
  self.retries = _params[$ "retries"] ?? 0;
  self.timeInitialized = current_time;
  
  
  // Callbacks.
  self.onRequest = function() { };
  self.onWaiting = function() { };
  self.onSuccess = function() { };
  self.onFailure = function() { };
  self.onTimeout = function() { };
  
  
  // Sanity check .
  if (type == undefined)
  {
    throw("ASYNC: async event type is required.");
  }
  
  type = string_lower(type);
  if (ds_map_exists(COROUTINE_HASH_ASYNC, type) == false)
  {
    throw($"ASYNC: async event type is invalid: '{type}'.");
  }
  
  
  /// @func isFinished();
  /// @desc 
  /// @returns {Bool} 
  static isFinished = function()
  {
    var _requests = COROUTINE_HASH_ASYNC[? type];
    return !ds_map_exists(_requests, handle);
  };
  
  
  /// @func isTimedOut();
  /// @desc 
  /// @returns {Bool} 
  static isTimedOut = function()
  {
    if (current_time >= timeInitialized + timeout * 1_000.0)
    {
      onTimeout();
      if (retries > 0)
      {
        self.retries--;
        DoRequest();
      }
      return true;
    }
    return false;
  };
  
  
  /// @func DoRequest();
  /// @desc 
  static DoRequest = function()
  {
    self.handle = onRequest();
    if (handle == -1)
    || (handle == undefined)
    {
      onFailure();
      return self;
    }
    
    self.timeInitialized = current_time;
    COROUTINE_HASH_ASYNC[? type][? handle] = self;
    return self;
  };
  
  
  /// @func SetFinished();
  /// @desc
  static SetFinished = function()
  {
    ds_map_delete(COROUTINE_HASH_ASYNC[? type], handle);
    return self;
  };
  
  
  /// @func SetRequest(_func);
  /// @desc 
  /// @param {Function} _func
  static SetRequest = function(_func)
  {
    self.onRequest = _func;
    return self;
  };
  
  
  /// @func SetWaiting(_func);
  /// @desc 
  /// @param {Function} _func
  static SetWaiting = function(_func)
  {
    self.onWaiting = _func;
    return self;
  };
  
  
  /// @func SetSuccess(_func);
  /// @desc 
  /// @param {Function} _func
  static SetSuccess = function(_func)
  {
    self.onSuccess = _func;
    return self;
  };
  
  
  /// @func SetFailure(_func);
  /// @desc 
  /// @param {Function} _func
  static SetFailure = function(_func)
  {
    self.onFailure = _func;
    return self;
  };
  
  
  /// @func SetTimeout(_func);
  /// @desc 
  /// @param {Function} _func
  static SetTimeout = function(_func)
  {
    self.onTimeout = _func;
    return self;
  };
}