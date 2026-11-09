

/**
* Tries to match operator by biggest-munch. 
* Advances source seek-position while it can.
* 
* Uses "trie"-structure.
* 
* @param {Id.Source} _tokens
* @param {Id.Source} _source
*/ 
function KorutiiniBuilderScanner_GetOperator(_tokens, _source)
{
  // Lookup is trie, prefixed tree-structure. 
  // -> If can't continue, and is valid endpoint, then "-1" will contain result.
  // -> Branches are stored in values 0 to 255.
  static trie = method_call(function()
  {
    var _trie = ds_map_create();
    
    var _operators = KorutiiniBuilderScanner_ListOperators();
    var _count = array_length(_operators);
    
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
  
  
  // Preparations.
  var _tellBegin = buffer_tell(_source);
  var _tell = _tellBegin;
  var _size = buffer_get_size(_source);
  var _byte = buffer_peek(_source, _tell, buffer_u8);
  var _next = trie[? _byte];
  var _curr = undefined;
  
  
  // Walk through the trie.
  while((_tell < _size) && (_next != undefined))
  {
    _curr = _next;
    _byte = buffer_peek(_source, _tell++, buffer_u8);
    _next = _curr[? _byte];
  }
  
  
  // No tokens were found.
  if (_curr == undefined)
  {
    return;
  }
  
  var _tokenData = _curr[? -1];
  if (_tokenData == undefined)
  {
    return;
  }
  
  
  // Move source, write the token.
  buffer_seek(_source, buffer_seek_start, _tell);
  buffer_write(_tokens, buffer_u16, KorutiiniBuilderScanner_TokenType.OPERATOR);
  buffer_write(_tokens, buffer_u16, _tokenData);
  buffer_write(_tokens, buffer_u32, _tellBegin);
  buffer_write(_tokens, buffer_u32, _tell - 1);
}



