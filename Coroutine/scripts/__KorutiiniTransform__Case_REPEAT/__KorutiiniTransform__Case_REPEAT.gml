

/**
* Repeat statement, which works similarly to GML.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_REPEAT(_node, _next, _break, _continue)
{
  // Reserve local for storing iterator.
  var _register = register++;
      
  // Loop is in two parts, first initalize repeat count.
  var _init = {
    next: undefined,
    call: _node.call,
    register: _register,
    execute: function()
    {
      KORUTIINI_CURRENT_LOCAL[register] = __Korutiini_Execute(call);
      KORUTIINI_CURRENT_EXECUTE = next;
    }
  };
      
  // Decrements counter and selects whether still do loop.
  var _loop = {
    next: undefined,
    jump: _next.execute,
    register: _register,
    execute: function()
    {
      KORUTIINI_CURRENT_EXECUTE = (--KORUTIINI_CURRENT_LOCAL[register] >= 0) ? next : jump;
    }
  };
      
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _loop, _next, _loop);
  _init.next = _loop.execute;
  _loop.next = _body.execute;

  // Finalize, free the register.
  register--;
  return _init;
}