

/**
* 
* 
* @param {Struct} _params
*/
function __KorutiiniAsyncListener(_params) constructor 
{
  // Static variables.
  static counter = 0;
  
  
  // Static methods.
  static Destroy    = __KorutiiniAsyncListener__Destroy;
  static Get        = __KorutiiniAsyncListener__Get;
  static IsFinished = __KorutiiniAsyncListener__IsFinished;
  
  
  // Unique identifier.
  identifier = counter++;
  
  
  // Async variables.
  type        = _params.option[$ "type"];
  name        = _params.option[$ "name"] ?? $"ASYNC Listener[{identifier}]";
  desc        = _params.option[$ "desc"] ?? "";
  this        = _params.option[$ "this"] ?? other; 
  timeout     = _params.option[$ "timeout"]; // seconds.
  result      = undefined;
  paused      = false;
  finished    = false;
  parentTask  = undefined;
  timer       = undefined;
  
  
  // Callbacks.
  var _nop  = function() {};
  onListen  = _params[$ "onListen"];
  onTimeout = _params[$ "onTimeout"] ?? _nop;
  
  
  // Sanity check:
  if (onListen == undefined)
  {
    throw($"ASYNC Listener: onListen must be defined.");
  }
  
  if (type == undefined)
  {
    throw($"ASYNC Listener: expected a async event -type.");
  }
  
  var _asyncListeners = __KorutiiniRuntime_AsyncListeners();
  if (ds_map_exists(_asyncListeners, type) == false)
  {
    throw($"ASYNC Listener: async event type is invalid: '{type}'.");
  }
  
  onListen = method(this, onListen);
  
  _asyncListeners[? type][? identifier] = self;
  
  
  // To upkeep what asyncs have been initialized within coroutine.
  if (KORUTIINI_CURRENT_TASK != undefined)
  {
    parentTask = KORUTIINI_CURRENT_TASK;
    parentTask.childListeners[? identifier] = self;
  }
  
     
  // Make timeout -timer.
  // This is not repeated.
  if (timeout != undefined)
  {
    timer = call_later(timeout, time_source_units_seconds, function()
    {
      timer = undefined;
      onTimeout();
      Destroy();
    });
  }
}




