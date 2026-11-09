

/**
* Returns static list mapping of operators.
*/ 
function KorutiiniBuilderScanner_MapOperators()
{
  static operators = method_call(function()
  {
    var _lookup = { };
    var _keywords = KorutiiniBuilderScanner_ListOperators();
    var _count = array_length(_keywords);
    for(var i = 0; i < _count; i++)
    {
      var _operator = _keywords[i];
      _lookup[$ _operator] = i;
    }
    
    return _lookup;
  });
  
  return operators;
}

