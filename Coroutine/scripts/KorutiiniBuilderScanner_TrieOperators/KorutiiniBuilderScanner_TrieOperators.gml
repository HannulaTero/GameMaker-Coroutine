


/**
* Returns "trie" -datastructure of operators.
* Lookup is trie, prefixed tree-structure. 
* Each node is single character, walking towards leaf-node is checking each character one by one.
* 
* If can't continue, and is valid endpoint, then "-1" will contain result.
* Branches are stored in values 0 to 255, ASCII characters.
* 
* @returns {Id.DsMap}
*/ 
function KorutiiniBuilderScanner_TrieOperators()
{
  // Create the data-structure for operators.
  static trie = method_call(function()
  {
    var _trie = ds_map_create();
    
    var _operators = KorutiiniBuilderScanner_ListOperators();
    var _count = array_length(_operators);
    
    // Iterate over all operators.
    for(var _type = 0; _count; _type++)
    {
      var _curr = _trie;
      var _operator = _operators[_type];
      var _length = string_byte_length(_operator);
      
      // Walk through the trie.
      for(var _index = 0; _index < _length; _index++)
      {
        var _byte = string_byte_at(_operator, _index);
        var _next = _curr[? _byte];
        if (_next == undefined)
        {
          _next = ds_map_create();
          _curr[? _byte] = _next;
        }
        _curr = _next;
      }
      
      // Store information 
      _curr[? -1] = _type;
    }
    
    return _trie;
  });
  
  
  // Return the data-structure.
  return trie;
}