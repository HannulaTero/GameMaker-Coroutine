

/**
* Switch-statement, jump-table.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_SWITCH(_node, _next, _break, _continue)
{
  // Check whether there is default case.
  var _def = (_node.def != undefined)
    ? Generate(_node.def, _next, _break, _continue)
    : undefined;
        
  // Solve all cases into jump-table.
  var _table = ds_map_create();
  var _cases = _node.cases;
  var _count = array_length(_cases);
  for(var i = 0; i < _count; i++)
  {
    // Fetch case information.
    var _case = _cases[i];
    var _cond = _case.cond(); // Compile-time, no dynamic cases.
    var _body = Generate(_case.body, _next, _break, _continue);
        
    // Check whether multiple case-conditions.
    if (is_array(_cond))
    {
      var _condArray = _cond;
      var _condCount = array_length(_cond);
      for(var j = 0; j < _condCount; j++)
      {
        _cond = _condArray[j];
        if (ds_map_exists(_table, _cond))
        {
          throw($"SWITCH duplicate case '{_cond}'");
        }
        _table[? _cond] = _body.execute;
      }
    }
        
    // Only accept single case-condition.
    else
    {
      if (ds_map_exists(_table, _cond))
      {
        throw($"SWITCH duplicate case '{_cond}'");
      }
      _table[? _cond] = _body.execute;
    }
  }
      
  // Push dsmap reference for easier cleaning when prototype is destroyed.
  array_push(tables, _table);
      
  // Create executor.
  return {
    next: _next.execute, 
    item: _node.item,
    table: _table,
    def: (_def != undefined) ? _def.execute : _next.execute,
    execute: function() 
    { 
      KORUTIINI_CURRENT_EXECUTE = table[? __Korutiini_Execute(item)] ?? def; 
    }
  };
}