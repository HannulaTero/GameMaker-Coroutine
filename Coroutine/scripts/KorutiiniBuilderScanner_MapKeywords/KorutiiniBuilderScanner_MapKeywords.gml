

/**
* 
*/ 
function KorutiiniBuilderScanner_MapKeywords()
{
  static keywords = method_call(function()
  {
    var _lookup = { };
    var _keywords = KorutiiniBuilderScanner_ListKeywords();
    var _count = array_length(_keywords);
    for(var i = 0; i < _count; i++)
    {
      var _keyword = _keywords[i];
      _lookup[$ _keyword] = i;
    }
    
    return _lookup;
  });
  
  return keywords;
}

