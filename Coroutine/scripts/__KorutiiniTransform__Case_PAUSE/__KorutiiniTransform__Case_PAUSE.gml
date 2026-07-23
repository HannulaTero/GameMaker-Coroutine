

/**
* Pauses and yields coroutine execution.
* This doesn't change coroutine value.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_PAUSE(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    execute: function()
    {
      KORUTIINI_CURRENT_TASK.Pause();
      KORUTIINI_CURRENT_EXECUTE = next;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
}