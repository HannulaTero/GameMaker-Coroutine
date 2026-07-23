

/**
* If-statement, regular branch statement.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_IF(_node, _next, _break, _continue)
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
      KORUTIINI_CURRENT_EXECUTE = __Korutiini_Execute(cond) ? next : jump;
    }
  };
}