

/**
* Add EOF token.
* 
* @param {Id.Buffer} _tokens
* @param {Id.Buffer} _source
* returns {Undefined}
*/ 
function KorutiiniBuilderScanner_AddEOF(_tokens, _source)
{
  var _tell = buffer_tell(_source);
  buffer_write(_tokens, buffer_u16, KorutiiniBuilderScanner_TokenType.EOF);
  buffer_write(_tokens, buffer_u16, 0);
  buffer_write(_tokens, buffer_u32, _tell);
  buffer_write(_tokens, buffer_u32, _tell);
}


