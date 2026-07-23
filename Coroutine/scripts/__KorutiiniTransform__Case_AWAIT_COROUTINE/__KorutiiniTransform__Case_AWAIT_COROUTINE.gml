

/**
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_AWAIT_KORUTIINI(_node, _next, _break, _continue)
{
  var _wait = {
    next: _next.execute,
    register,
    execute: function()
    {
      if (KORUTIINI_CURRENT_LOCAL[register].IsFinished())
      {
        KORUTIINI_CURRENT_EXECUTE = next;
        return;
      }
      KORUTIINI_CURRENT_EXECUTE = execute;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
      
  return {
    next: _wait.execute,
    call: _node.call,
    register,
    execute: function()
    {
      KORUTIINI_CURRENT_LOCAL[register] = __Korutiini_Execute(call);
      KORUTIINI_CURRENT_EXECUTE = next;
    }
  };
}