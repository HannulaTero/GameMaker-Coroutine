

/**
* Reads the number.
* 
* @param {Id.Source} _tokens
* @param {Id.Source} _source
* returns {Undefined}
*/ 
function KorutiiniBuilderScanner_GetNumber(_tokens, _source)
{
  // TODO
  
  // Move source, write the token.
  buffer_seek(_source, buffer_seek_start, _tell);
  buffer_write(_tokens, buffer_u16, KorutiiniBuilderScanner_TokenType.NUMBER);
  buffer_write(_tokens, buffer_u16, _tokenData ?? 0);
  buffer_write(_tokens, buffer_u32, _tellBegin);
  buffer_write(_tokens, buffer_u32, _tell - 1);
}