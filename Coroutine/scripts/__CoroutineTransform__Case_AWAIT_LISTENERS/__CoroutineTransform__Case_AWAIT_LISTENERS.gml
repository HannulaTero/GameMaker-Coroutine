

/**
* Pauses execution until all async listeners have finished.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_AWAIT_LISTENERS(_node, _next, _break, _continue)
{
  return {
    next: _next.execute,
    execute: function()
    {
      if (ds_map_size(COROUTINE_CURRENT_TASK.asyncListeners) <= 0)
      {
        COROUTINE_CURRENT_EXECUTE = next;
        return;
      }
      COROUTINE_CURRENT_EXECUTE = execute;
      COROUTINE_CURRENT_YIELDED = true;
    }
  };
}