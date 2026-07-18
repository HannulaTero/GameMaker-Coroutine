

/**
* Creates lookup-mapping from given arguments
* 
* @returns {Struct}
*/
function __Coroutine_Mapping()
{
  var _mapping = { };
  
  for(var i = 0; i < argument_count; i += 2)
  {
    var _lhs = argument[i + 0];
    var _rhs = argument[i + 1];
    _mapping[$ _lhs] = method(undefined, _rhs);
  }
  
  return _mapping;
}