

/**
* Statement, which may return control flow commands.
* These are way executing regular GML code.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_STMT(_node, _next, _break, _continue)
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
      KORUTIINI_CURRENT_EXECUTE = __Korutiini_Execute(call) ?? next;
    }
  };
}