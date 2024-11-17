
// No active coroutines, quit early.
if (COROUTINE_ACTIVE.head == undefined)
{
  exit;
}


// Start from first item in the list.
coroutine = COROUTINE_ACTIVE.head;
with(coroutine) Execute(triggers.onLaunch);


// Do-until to ensure something happens,
// even if frame-budget is exceeded.  
var _continue = false;
do 
{
  // Get the op-code and execute it. 
  // Return value tells whether continue with current coroutine.
  try
  {
    with(coroutine) _continue = code[index++](); 
  }
  catch(_error)
  {
    show_debug_message(_error);
    with(coroutine) Execute(triggers.onError);
  }
  
  // Check whether yielded, move to next coroutine.
  // Checks whether there exists any.
  if (_continue == false)
  {
    with(coroutine) Execute(triggers.onYield);
    coroutine = coroutine.next;
    if (coroutine == undefined) 
    {
      break;
    }
    with(coroutine) Execute(triggers.onLaunch);
  }
}
until(coroutine_frame_time_usage() >= margin);


// Check for forced yield because time ran out.
if (_continue == true)
{
  with(coroutine) Execute(triggers.onYield);
}


