

/**
* Creates lookup-mapping from given array.
* 
* @param {Array<Any>} _array
* @returns {Struct}
*/
function __Coroutine_Mapping(_array)
{
  var _mapping = {};
  var _countOuter = array_length(_array);
  for(var i = 0; i < _countOuter; i+=2)
  {
    var _lhs = _array[i + 0];
    var _rhs = _array[i + 1];
    _rhs = method(undefined, _rhs);
    
    var _countInner = array_length(_lhs);
    for(var j = 0; j < _countInner; j++)
    {
      _mapping[$ _lhs[j]] = _rhs;
    }
  }
  return _mapping;
}