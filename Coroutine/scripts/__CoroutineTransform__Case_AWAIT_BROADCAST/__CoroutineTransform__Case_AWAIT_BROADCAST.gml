

/**
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_AWAIT_BROADCAST(_node, _next, _break, _continue)
{
  return {
    next: _next.execute,
    call: _node.call,
    execute: function()
    {
      if (__Coroutine_Execute(call))
      {
        COROUTINE_CURRENT_EXECUTE = next;
        return;
      }
      COROUTINE_CURRENT_EXECUTE = execute;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
}