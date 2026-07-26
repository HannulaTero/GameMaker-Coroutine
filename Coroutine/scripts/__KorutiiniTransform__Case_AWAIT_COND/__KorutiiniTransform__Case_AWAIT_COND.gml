

/**
* Pauses execution until given condition is met.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_AWAIT_COND(_node, _next, _break, _continue)
{
  return {
    next: _next.execute,
    call: _node.call,
    execute: function()
    {
      if (__Korutiini_Execute(call))
      {
        KORUTIINI_CURRENT_EXECUTE = next;
        return;
      }
      KORUTIINI_CURRENT_EXECUTE = execute;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
}