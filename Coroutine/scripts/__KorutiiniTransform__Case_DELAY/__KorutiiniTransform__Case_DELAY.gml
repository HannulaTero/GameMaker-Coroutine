

/**
* Pauses coroutine execution until given time is passed.
* Allows different units of time to be used.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_DELAY(_node, _next, _break, _continue)
{
  // Cases for different delay-types.
  static rates = __Korutiini_Mapping(
    "micros",   function() { return 1_000_000.0; }, 
    "millis",   function() { return 1_000.0; }, 
    "frames",   function() { return 1.0; }, 
    "seconds",  function() { return 1.0; }, 
  );
  
  
  static units = __Korutiini_Mapping(
    "micros",   function() { return time_source_units_seconds; }, 
    "millis",   function() { return time_source_units_seconds; }, 
    "frames",   function() { return time_source_units_frames; }, 
    "seconds",  function() { return time_source_units_seconds; }, 
  );
  
  
  return {
    next: _next.execute,
    call: _node.call,
    rate: rates[$ _node.type](),
    unit: units[$ _node.type](),
    execute: function()
    {
      static poolActive   = __KorutiiniRuntime_PoolActive();
      static poolPaused   = __KorutiiniRuntime_PoolPaused();
      static poolDelayed  = __KorutiiniRuntime_PoolDelayed();
      
      var _unit   = unit;
      var _delay  = __Korutiini_Execute(call) / rate;
      
      with(KORUTIINI_CURRENT_TASK)
      {
        // Delete from active and yield. 
        ds_map_delete(poolActive, identifier);
        poolDelayed[? identifier] = self;
        delayed = true;
          
        // Return back to active after delay.
        time_source_reconfigure(delaySource, _delay, _unit, delayResume);
        time_source_start(delaySource);
      }
          
      KORUTIINI_CURRENT_EXECUTE = next;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
}