
/// @func CoroutineAsyncListener(_params);
/// @desc
/// @param {Struct} _params
function CoroutineAsyncListener(_params) constructor 
{
  static counter = 0;
  identifier = counter++;
  
  // Async variables.
  type = _params.option[$ "type"];
  name = _params.option[$ "name"] ?? $"ASYNC Listener[{identifier}]";
  desc = _params.option[$ "desc"] ?? "";
  this = _params.option[$ "this"] ?? other; 
  timeout = _params.option[$ "timeout"]; // seconds.
  result = undefined;
  paused = false;
  finished = false;
  parent = undefined;
  timer = undefined;
  
  
  // Callbacks.
  var _nop = function() {};
  onListen = _params[$ "onListen"];
  onTimeout = _params[$ "onTimeout"] ?? _nop;
  
  
  // Sanity check:
  if (onListen == undefined)
    throw($"ASYNC Listener: onListen must be defined.");
  onListen = method(this, onListen);
  
  if (type == undefined)
    throw($"ASYNC Listener: expected a async event -type.");
    
  if (ds_map_exists(COROUTINE_ASYNC_LISTENERS, type) == false)
    throw($"ASYNC Listener: async event type is invalid: '{type}'.");
  COROUTINE_ASYNC_LISTENERS[? type][? identifier] = self;
  
  
  // To upkeep what asyncs have been initialized within coroutine.
  if (COROUTINE_CURRENT_TASK != undefined)
  {
    parent = COROUTINE_CURRENT_TASK;
    parent.asyncListeners[? identifier] = self;
  }
  
     
  // Make timeout -timer.
  if (timeout != undefined)
  {
    timer = call_later(timeout, time_source_units_seconds, function()
    {
      timer = undefined;
      onTimeout();
      Destroy();
    });
  }
  
  
  /// @func Get();
  /// @desc Async listen current result.
  /// @returns {Any}
  static Get = function()
  {
    return result;
  };
  
  
  /// @func isFinished();
  /// @desc 
  /// @returns {Bool}
  static isFinished = function() 
  { 
    return finished;
  };
  
  
  /// @func Destroy();
  /// @desc Async listen is removed.
  /// @returns {Struct.CoroutineAsyncListener}
  static Destroy = function()
  {
    // Can't destroy what has already been destroyed.
    if (finished == true) 
      return self;
      
    // Put itself into right state, and remove data.
    paused = false;
    finished = true;
    ds_map_delete(COROUTINE_ASYNC_LISTENERS[? type], identifier);
    if (timer != undefined)
      call_cancel(timer);
    if (parent != undefined)
      ds_map_delete(parent.asyncListeners, identifier);
    return self;
  };
}




