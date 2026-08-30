

/**
* Do-until loop statement.
* Almost same as While-loop, but the body is executed first and condition is reversed.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_DO(_node, _next, _break, _continue)
{
  var _loop = {
    next: undefined,
    jump: _next.execute,
    cond: _node.cond,
    execute: function()
    {
      KORUTIINI_CURRENT_EXECUTE = __Korutiini_Execute(cond) ? jump : next;
    }
  };
  
  
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _loop, _next, _loop);
  _loop.next = _body.execute;
  return _body;
}