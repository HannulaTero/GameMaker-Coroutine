


/**
* Tries to find how much can match in given input.
* Return how much it has matched.
* 
* @param {Id.DsMap}   _trie
* @param {Id.Buffer}  _input
* @returns {Real}
*/ 
function KorutiiniBuilder_TrieWalk(_trie, _input)
{
  // Preparations.
  var _tellBegin = buffer_tell(_input);
  var _tell = _tellBegin;
  var _size = buffer_get_size(_input);
  var _byte = buffer_peek(_input, _tell, buffer_u8);
  var _next = _trie[? _byte];
  var _curr = undefined;
  
  
  // Walk through the trie.
  while((_tell < _size) && (_next != undefined))
  {
    _curr = _next;
    _byte = buffer_peek(_input, _tell++, buffer_u8);
    _next = _curr[? _byte];
  }
  
  
  // No match was found.
  if (_curr == undefined)
  {
    return 0;
  }
  
  
  // Whether was an end-point.
  var _tokenData = _curr[? -1];
  if (_tokenData == undefined)
  {
    return 0;
  }
  
  
  // There was a match, return the length.
  return (_tell - _tellBegin);
}