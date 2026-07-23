

/**
* Splits coroutine, more yielding points for manager.
* This will also set current value for coroutine.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_SET(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    call: _node.call, 
    execute: function()
    {
      KORUTIINI_CURRENT_TASK.result = __Korutiini_Execute(call);
      KORUTIINI_CURRENT_EXECUTE = next;
    }
  };
}