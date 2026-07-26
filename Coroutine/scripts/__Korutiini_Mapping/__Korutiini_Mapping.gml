

/**
* Creates lookup-mapping from given arguments
* 
* @returns {Struct}
*/
function __Korutiini_Mapping()
{
  var _mapping = { };
  
  for(var i = 0; i < argument_count; i += 2)
  {
    var _lhs = argument[i + 0];
    var _rhs = argument[i + 1];
    
    if (is_array(_lhs) == false)
    {
      _mapping[$ _lhs] = method(undefined, _rhs);
    }
    else
    {
      var _func  = method(undefined, _rhs);
      var _count = array_length(_lhs);
      for(var j = 0; j < _count; j++)
      {
        _mapping[$ _lhs] = _func;
      }
    }
  }
  
  return _mapping;
}