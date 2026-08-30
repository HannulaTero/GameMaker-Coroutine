

/**
* Marks end of the coroutine execution.
* Calls trigger for completion.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_FINISH(_node, _next, _break, _continue)
{
  static nop = function() { };
  
  
  // NOTE! Updates transforms final node.
  final = { 
    next: nop,
    execute: function()
    {
      KORUTIINI_CURRENT_TASK.onComplete();
      KORUTIINI_CURRENT_TASK.Destroy();
      KORUTIINI_CURRENT_EXECUTE = next;
      KORUTIINI_CURRENT_YIELDED = true;
    }
  };
  
  return final;
}