

/**
* If-statement, regular branch statement.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_IF(_node, _next, _break, _continue)
{
  // Solve then and else -branches.
  var _then = Generate(_node.nodeThen, _next, _break, _continue);
  var _else = (_node.nodeElse != undefined)
    ? Generate(_node.nodeElse, _next, _break, _continue)
    : _next;
      
  return {
    next: _then.execute, 
    jump: _else.execute,
    cond: _node.cond,
    execute: function()
    {
      COROUTINE_CURRENT_EXECUTE = __Coroutine_Execute(cond) ? next : jump;
    }
  };
}