

/**
* For-statement.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_FOR(_node, _next, _break, _continue)
{
  // Initialize variables.
  var _init = {
    next: undefined,
    call: _node.init,
    execute: function()
    {
      __Coroutine_Execute(call);
      COROUTINE_CURRENT_EXECUTE = next;
    }
  }
      
  // Loop condition, whether break out.
  var _cond = {
    next: undefined,
    jump: undefined,
    cond: _node.cond,
    execute: function()
    {
      COROUTINE_CURRENT_EXECUTE = __Coroutine_Execute(cond) ? next : jump;
    }
  };
      
  // Loop iteration.
  var _iter = {
    next: undefined,
    call: _node.iter,
    execute: function()
    {
      __Coroutine_Execute(call);
      COROUTINE_CURRENT_EXECUTE = next;
    }
  };
      
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _iter, _next, _iter);
  _init.next = _cond.execute;
  _cond.next = _body.execute;
  _cond.jump = _next.execute;
  _iter.next = _cond.execute;
      
  return _init;
}