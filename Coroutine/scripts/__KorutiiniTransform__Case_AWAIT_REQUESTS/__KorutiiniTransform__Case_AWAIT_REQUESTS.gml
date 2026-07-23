

/**
* Pauses execution until all async requests have finished.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_AWAIT_REQUESTS(_node, _next, _break, _continue)
{
  return {
    next: _next.execute,
    execute: function()
    {
      if (ds_map_size(KORUTIINI_CURRENT_TASK.childRequests) <= 0)
      {
        KORUTIINI_CURRENT_EXECUTE = next;
        return;
      }
      KORUTIINI_CURRENT_EXECUTE = execute;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
}