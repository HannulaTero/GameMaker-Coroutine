

/**
* Basic conditional loop.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_WHILE(_node, _next, _break, _continue)
{
  var _loop = {
    next: undefined,
    jump: _next.execute,
    cond: _node.cond,
    execute: function()
    {
      COROUTINE_CURRENT_EXECUTE = __Coroutine_Execute(cond) ? next : jump;
    }
  };
      
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _loop, _next, _loop);
  _loop.next = _body.execute;
  return _loop;
}