

/**
* Pauses execution until given condition is met.
* Usual condition is boolean value, but it can be several other types.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_AWAIT_COND(_node, _next, _break, _continue)
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