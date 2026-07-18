

/**
* 
* 
* @param {Struct} _params
*/
function __CoroutineAsyncListener(_params) constructor 
{
  // Static variables.
  static counter = 0;
  
  
  // Static methods.
  static Destroy    = __CoroutineAsyncListener__Destroy;
  static Get        = __CoroutineAsyncListener__Get;
  static IsFinished = __CoroutineAsyncListener__IsFinished;
  
  
  // Unique identifier.
  identifier = counter++;
  
  
  // Async variables.
  type      = _params.option[$ "type"];
  name      = _params.option[$ "name"] ?? $"ASYNC Listener[{identifier}]";
  desc      = _params.option[$ "desc"] ?? "";
  this      = _params.option[$ "this"] ?? other; 
  timeout   = _params.option[$ "timeout"]; // seconds.
  result    = undefined;
  paused    = false;
  finished  = false;
  parent    = undefined;
  timer     = undefined;
  
  
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
    
  if (ds_map_exists(COROUTINE_ASYNC_LISTENERS, type) == false)
  {
    throw($"ASYNC Listener: async event type is invalid: '{type}'.");
  }
  
  onListen = method(this, onListen);
  
  COROUTINE_ASYNC_LISTENERS[? type][? identifier] = self;
  
  
  // To upkeep what asyncs have been initialized within coroutine.
  if (COROUTINE_CURRENT_TASK != undefined)
  {
    parent = COROUTINE_CURRENT_TASK;
    parent.asyncListeners[? identifier] = self;
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




