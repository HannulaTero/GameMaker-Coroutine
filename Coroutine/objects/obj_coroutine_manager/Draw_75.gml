/// @desc COROUTINE EXECUTION.


// No active coroutines, quit early.
if (__COROUTINE_ACTIVE.head == undefined)
{
  exit;
}


// Flag that manager is executing coroutines.
__COROUTINE_FLAG_EXECUTING = true;


// Fetch and launch the coroutine.
link = __COROUTINE_ACTIVE.head;
coroutine = link.item;
with(coroutine)
{
  Execute(trigger.onLaunch);
  yield = false;
}

// Do-until to ensure something happens, even if frame-budget is exceeded.
do 
{
  // Get the op-code and execute it. 
  // Return value tells whether continue with current coroutine.
  try
  {
    with(coroutine) 
    {
      current = current(self);
    }
  }
  
  // Something wrong happened while executing coroutine.
  catch(_error)
  {
    var _line = string_repeat("=", 64);
    show_debug_message(_line);
    show_debug_message(_error);
    show_debug_message(_line);
    with coroutine Execute(trigger.onError);
  }
  
  // Check whether coroutine yielded.
  if (coroutine.yield == true)
  {
    // Yield current coroutine.
    with coroutine Execute(trigger.onYield);
        
    // No more active coroutines.
    if (link.next == undefined)
    {
      break;
    }
    
    // Launch the coroutine.
    link = link.next;
    coroutine = link.item;
    with(coroutine)
    {
      Execute(trigger.onLaunch);
      yield = false;
    }
  }
}
until(coroutine_frame_time_usage() >= margin);


// Check if time ran out and Coroutine was forced to yield.
if (coroutine.yield == false)
{
  with coroutine Execute(trigger.onYield);
}


// Flag that manager is not executing coroutines anymore.
__COROUTINE_FLAG_EXECUTING = false;
