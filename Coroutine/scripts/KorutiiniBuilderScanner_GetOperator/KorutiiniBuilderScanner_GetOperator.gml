

/**
* Tries to match operator by biggest-munch. 
* Advances source seek-position while it can.
* 
* Uses "trie"-structure.
* 
* @param {Id.Source} _tokens
* @param {Id.Source} _source
* returns {Undefined}
*/ 
function KorutiiniBuilderScanner_GetOperator(_tokens, _source)
{  
  // Preparations.
  var _tellBegin = buffer_tell(_source);
  var _tell = _tellBegin;
  var _size = buffer_get_size(_source);
  var _byte = buffer_peek(_source, _tell, buffer_u8);
  
  
  // Walk through the trie.
  var _trie = KorutiiniBuilderScanner_TrieOperators();
  var _next = _trie[? _byte];
  var _curr = undefined;
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



