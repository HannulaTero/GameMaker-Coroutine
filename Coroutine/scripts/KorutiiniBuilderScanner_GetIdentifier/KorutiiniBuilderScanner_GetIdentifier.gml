

/**
* Tries to match identifier. 
* 
* @param {Id.Source} _tokens
* @param {Id.Source} _source
* returns {Undefined}
*/ 
function KorutiiniBuilderScanner_GetIdentifier(_tokens, _source)
{
  // Preparations.
  var _tellBegin = buffer_tell(_source);
  var _tell = _tellBegin;
  var _size = buffer_get_size(_source);
  var _byte = buffer_peek(_source, _tell, buffer_u8);
  
  
  // Have to start with alpha-value.
  if (KorutiiniBuilderScanner_IsAlpha(_byte) == false)
  {
    return;
  }
  
  
  // Continue as long as valid characters are met.
  while((_tell < _size) && KorutiiniBuilderScanner_IsAlphaDigit(_byte))
  {
    _byte = buffer_peek(_source, _tell++, buffer_u8);
  }
  
  
  // Get the identifier as string.
  // -> Temporarily edit source to add terminator-byte.
  // -> Read the identifier as string, and return original byte.
  var _original = buffer_peek(_source, _tell, buffer_u8);
  buffer_poke(_source, _tell, buffer_u8, 0);
  var _identifier = buffer_peek(_source, _tellBegin, buffer_string);
  buffer_poke(_source, _tell, buffer_u8, _original);
  
  
  // Check whether it's a keyword.
  static keywords = KorutiiniBuilderScanner_MapKeywords();
  var _tokenType = KorutiiniBuilderScanner_TokenType.IDENTIFIER;
  var _tokenData = keywords[$ _identifier];
  if (_tokenData != undefined)
  {
    _tokenType = KorutiiniBuilderScanner_TokenType.KEYWORD;
  }
  
  
  // Move source, write the token.
  buffer_seek(_source, buffer_seek_start, _tell);
  buffer_write(_tokens, buffer_u16, _tokenType);
  buffer_write(_tokens, buffer_u16, _tokenData ?? 0);
  buffer_write(_tokens, buffer_u32, _tellBegin);
  buffer_write(_tokens, buffer_u32, _tell - 1);
}