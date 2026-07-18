

/**
* Splits coroutine, more yielding points for manager.
* This will also set current value for coroutine.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_SET(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    call: _node.call, 
    execute: function()
    {
      COROUTINE_CURRENT_TASK.result = __Coroutine_Execute(call);
      COROUTINE_CURRENT_EXECUTE = next;
    }
  };
}