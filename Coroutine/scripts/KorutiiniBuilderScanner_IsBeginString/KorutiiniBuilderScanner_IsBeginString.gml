

/**
* Checks whether byte beginning of an string.
* 
* @param {Id.Buffer}  _source
* @param {Real}       _byte
*/ 
function KorutiiniBuilderScanner_IsBeginString(_source, _byte)
{
  // If quote then for sure it is a string.
  if (_byte == ord("\""))
  {
    return true;
  }
  
  
  // Peek next character.
  var _peek = buffer_peek(_source, buffer_tell(_source) + 1, buffer_u8);
  
  
  // Check for string literal.
  if (_byte == ord("$"))
  && (_peek == ord("\""))
  {
    return true;
  }
  
  
  // Check for multi-line string.
  if (_byte == ord("@"))
  && ((_peek == ord("\"")) || (_peek == ord("'")))
  {
    return true;
  }
  
  
  // Otherwise it is not.
  return false;
}