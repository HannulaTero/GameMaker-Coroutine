

/**
* Marks end of the coroutine execution.
* Calls trigger for completion.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_FINISH(_node, _next, _break, _continue)
{
  static nop = function() { };
  
  // NOTE! Updates transforms final node.
  final = { 
    next: nop,
    execute: function()
    {
      COROUTINE_CURRENT_TASK.onComplete();
      COROUTINE_CURRENT_TASK.Destroy();
      COROUTINE_CURRENT_EXECUTE = next;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
  
  return final;
}