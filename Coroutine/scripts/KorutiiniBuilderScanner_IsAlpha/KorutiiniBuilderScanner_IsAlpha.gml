

/**
* Returns whether given byte is alpha or not.
* 
* @param {Real} _byte
*/ 
function KorutiiniBuilderScanner_IsAlpha(_byte)
{
  static lookup = method_call(function()
  {
    var _chars = "_qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
    var _buffer = buffer_create(256, buffer_fast, 1);
    for(var i = 0; i < 256; i++)
    {
      var _isAlpha = (string_pos(chr(i), _chars) > 0);
      buffer_write(_buffer, buffer_u8, _isAlpha);
    }
    return _buffer;
  });
  
  return buffer_peek(lookup, _byte, buffer_u8);
}