

/**
* Yields execution, and allows others also to do execution.
* This doesn't change coroutine value.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_YIELD(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    execute: function()
    {
      COROUTINE_CURRENT_EXECUTE = next;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
}