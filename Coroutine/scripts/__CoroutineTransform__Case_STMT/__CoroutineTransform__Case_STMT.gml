

/**
* Statement, which may return control flow commands.
* These are way executing regular GML code.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_STMT(_node, _next, _break, _continue)
{
  return { 
    next: _next.execute,
    call: _node.call, 
    onBreak: _break.execute,
    onContinue: _continue.execute,
    execute: function()
    {
      // Return value should be from calling coroutine control flow statements.
      // Or undefined, so it just proceeds to the next.
      COROUTINE_CURRENT_EXECUTE = __Coroutine_Execute(call) ?? next;
    }
  };
}