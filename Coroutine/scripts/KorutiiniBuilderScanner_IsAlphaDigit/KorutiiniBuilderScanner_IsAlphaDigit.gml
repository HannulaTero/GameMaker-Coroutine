

/**
* Returns whether given byte is alphanumerical or not.
* 
* @param {Real} _byte
*/ 
function KorutiiniBuilderScanner_IsAlphaDigit(_byte)
{
  static lookup = method_call(function()
  {
    var _buffer = buffer_create(256, buffer_fast, 1);
    for(var i = 0; i < 256; i++)
    {
      var _isAlpha = KorutiiniBuilderScanner_IsAlpha(i);
      var _isDigit = KorutiiniBuilderScanner_IsDigit(i);
      buffer_write(_buffer, buffer_u8, (_isAlpha || _isDigit));
    }
    return _buffer;
  });
  
  return buffer_peek(lookup, _byte, buffer_u8);
}