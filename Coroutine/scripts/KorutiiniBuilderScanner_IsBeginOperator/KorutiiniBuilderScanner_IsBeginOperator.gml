

/**
* Checks whether byte beginning of an operator.
* 
* @param {Real} _byte
*/ 
function KorutiiniBuilderScanner_IsBeginOperator(_byte)
{
  // Create lookup-table.
  static lookup = method_call(function()
  {
    var _chars = "";
    var _operators = KorutiiniBuilderScanner_ListOperators();
    var _count = array_length(_operators);
    for(var i = 0; i < _count; i++)
    {
      _chars += string_char_at(_operators[i], 1);
    }
    
    var _buffer = buffer_create(256, buffer_fast, 1);
    for(var i = 0; i < 256; i++)
    {
      var _isOperator = (string_pos(chr(i), _chars) > 0);
      buffer_write(_buffer, buffer_u8, _isOperator);
    }
    return _buffer;
  });
  
  
  return buffer_peek(lookup, _byte, buffer_u8);
}