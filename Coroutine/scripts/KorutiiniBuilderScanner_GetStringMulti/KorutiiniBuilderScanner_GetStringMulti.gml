

/**
* Get multi-line string.
* Assumes that ends in valid string, as otherwise GML compiler 
* would not let game to compile. And this tokenizer works as preproc.
* 
*/ 
function KorutiiniBuilderScanner_GetStringMulti(_tokens, _source)
{
  // Preparations.
  var _tellBegin = buffer_tell(_source);
  var _tell = _tellBegin;
  var _size = buffer_get_size(_source);
  var _byte = buffer_peek(_source, _tell, buffer_u8);
  var _marker = _byte;
  
  
  // Check for the start of the string.
  if (_byte != ord("\""))
  {
    return;
  }
  _tell += 1;
  
  
  // Continue as long as valid characters are met.
  while((_tell < _size) && (_byte != _marker))
  {
    _byte = buffer_peek(_source, _tell++, buffer_u8);
  }
  
  
  // Move source, write the token.
  buffer_seek(_source, buffer_seek_start, _tell);
  buffer_write(_tokens, buffer_u16, KorutiiniBuilderScanner_TokenType.STRING);
  buffer_write(_tokens, buffer_u16, 0);
  buffer_write(_tokens, buffer_u32, _tellBegin);
  buffer_write(_tokens, buffer_u32, _tell - 1);
}


