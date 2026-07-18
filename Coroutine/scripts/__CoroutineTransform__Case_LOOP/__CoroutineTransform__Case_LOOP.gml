

/**
* Simple forever loop, always will repeat body.
* Statement must either break or jump out the loop.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_LOOP(_node, _next, _break, _continue)
{
  var _loop = {
    next: undefined,
    execute: function() 
    { 
      COROUTINE_CURRENT_EXECUTE = next;
    }
  };
      
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _loop, _next, _loop);
  _loop.next = _body.execute;
  return _loop;
}