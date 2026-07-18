

/**
* Pauses coroutine execution until given time is passed.
* Allows different units of time to be used.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_DELAY(_node, _next, _break, _continue)
{
  // Cases for different delay-types.
  static rates = __Coroutine_Mapping(
    "<MICROS>",   function() { return 1_000_000.0; }, 
    "<MILLIS>",   function() { return 1_000.0; }, 
    "<FRAMES>",   function() { return 1.0; }, 
    "<SECONDS>",  function() { return 1.0; }, 
  );
  
  static units = __Coroutine_Mapping(
    "<MICROS>",   function() { return time_source_units_seconds; }, 
    "<MILLIS>",   function() { return time_source_units_seconds; }, 
    "<FRAMES>",   function() { return time_source_units_frames; }, 
    "<SECONDS>",  function() { return time_source_units_seconds; }, 
  );
      
  return {
    next: _next.execute,
    call: _node.call,
    rate: rates[$ _node.type](),
    unit: units[$ _node.type](),
    execute: function()
    {
      // feather ignore GM1041
      // feather ignore GM1049
      var _unit = unit;
      var _delay = __Coroutine_Execute(call) / rate;
      with(COROUTINE_CURRENT_TASK)
      {
        // Delete from active and yield. 
        ds_map_delete(COROUTINE_POOL_ACTIVE, identifier);
        COROUTINE_POOL_DELAYED[? identifier] = self;
        delayed = true;
          
        // Return back to active after delay.
        time_source_reconfigure(delaySource, _delay, _unit, delayResume);
        time_source_start(delaySource);
      }
          
      COROUTINE_CURRENT_EXECUTE = next;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
}