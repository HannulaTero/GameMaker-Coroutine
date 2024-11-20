/// @desc COROUTINE EXECUTION.


// No active coroutines, quit early.
if (COROUTINE_LIST_ACTIVE.head == undefined)
{
  exit;
}


// Fetch and launch the coroutine.
var _link = COROUTINE_LIST_ACTIVE.head;
var _coroutine = _link.item;
COROUTINE_CURRENT = _coroutine;
COROUTINE_EXECUTE = _coroutine.execute;
COROUTINE_LOCAL = _coroutine.local;
COROUTINE_SCOPE = _coroutine.scope;
COROUTINE_YIELD = false;

with(_coroutine)
{
  coroutine_execute(trigger.onLaunch);
  COROUTINE_YIELD = false;
}

// Do-until to ensure something happens, even if frame-budget is exceeded.
do 
{
  //try
  //{
  //  COROUTINE_EXECUTE();
  //}
  //
  //// Something wrong happened while executing coroutine.
  //catch(_error)
  //{
  //  var _line = string_repeat("=", 64);
  //  show_debug_message(_line);
  //  show_debug_message(_error);
  //  show_debug_message(_line);
  //  coroutine_execute(_coroutine.trigger.onError);
  //}
  
  // Check whether coroutine yielded.
  COROUTINE_EXECUTE();
  if (COROUTINE_YIELD)
  {
    // Yield current coroutine.
    coroutine_execute(_coroutine.trigger.onYield);
    _coroutine.execute = COROUTINE_EXECUTE;
        
    // Check whether there is next action.
    _link = _link.next;
    if (_link == undefined)
    {
      break;
    }
    
    // Launch the coroutine.
    _coroutine = _link.item;
    COROUTINE_CURRENT = _coroutine;
    COROUTINE_EXECUTE = _coroutine.execute;
    COROUTINE_LOCAL = _coroutine.local;
    COROUTINE_SCOPE = _coroutine.scope;
    with(COROUTINE_CURRENT)
    {
      coroutine_execute(trigger.onLaunch);
      COROUTINE_YIELD = false;
    }
  }
}
until(coroutine_frame_time_usage() >= margin);


// Check if time ran out and Coroutine was forced to yield.
if (COROUTINE_YIELD == false)
{
  coroutine_execute(_coroutine.trigger.onYield);
  _coroutine.execute = COROUTINE_EXECUTE;
}

COROUTINE_CURRENT = undefined;
COROUTINE_EXECUTE = undefined;
COROUTINE_LOCAL = undefined;
COROUTINE_SCOPE = undefined;
COROUTINE_YIELD = undefined;
