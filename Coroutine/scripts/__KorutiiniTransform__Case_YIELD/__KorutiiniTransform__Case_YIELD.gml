

/**
* Yields execution, and allows others also to do execution.
* This doesn't change coroutine value.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_YIELD(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    execute: function()
    {
      KORUTIINI_CURRENT_EXECUTE = next;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
}