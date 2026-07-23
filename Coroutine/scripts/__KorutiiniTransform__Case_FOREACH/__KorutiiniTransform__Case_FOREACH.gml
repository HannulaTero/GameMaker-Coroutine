

/**
* Foreach statement for iterating different iterable items.
* This uses own iterator-struct to keep up the state.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_FOREACH(_node, _next, _break, _continue)
{
  // Reserve local for storing iterator.
  var _register = register++;
      
  // Initializes iterator. 
  var _init = {
    next: undefined,
    call: _node.item,
    val: _node.val,
    key: _node.key,
    register: _register,
    execute: function()
    {
      var _item = __Korutiini_Execute(call);
      var _iterator = new __KorutiiniIterator(_item, key, val);
      KORUTIINI_CURRENT_LOCAL[register] = _iterator;
      KORUTIINI_CURRENT_EXECUTE = next;
    }
  }
      
  // Does the loop iteration.
  var _loop = {
    next: undefined,
    jump: undefined,
    register: _register,
    execute: function()
    {
      var _iterator = KORUTIINI_CURRENT_LOCAL[register];
      if (_iterator.index < _iterator.count)
      {
        _iterator.Next();
        KORUTIINI_CURRENT_EXECUTE = next;
      }
      else
      {
        KORUTIINI_CURRENT_LOCAL[register] = undefined;
        KORUTIINI_CURRENT_EXECUTE = jump;
      }
    }
  };
      
  // Solve body and then patch, as loop target must be known beforehand.
  var _body = Generate(_node.body, _loop, _next, _loop);
  _init.next = _loop.execute;
  _loop.next = _body.execute;
  _loop.jump = _next.execute;
      
  // Finalize, free register.
  register--;
  return _init;
}