

/**
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_AWAIT_COROUTINE(_node, _next, _break, _continue)
{
  var _wait = {
    next: _next.execute,
    register,
    execute: function()
    {
      if (COROUTINE_CURRENT_LOCAL[register].IsFinished())
      {
        COROUTINE_CURRENT_EXECUTE = next;
        return;
      }
      COROUTINE_CURRENT_EXECUTE = execute;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
      
  return {
    next: _wait.execute,
    call: _node.call,
    register,
    execute: function()
    {
      COROUTINE_CURRENT_LOCAL[register] = __Coroutine_Execute(call);
      COROUTINE_CURRENT_EXECUTE = next;
    }
  };
}