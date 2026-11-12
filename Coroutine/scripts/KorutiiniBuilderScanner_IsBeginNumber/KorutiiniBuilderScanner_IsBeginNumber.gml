

/**
* Checks whether byte beginning of an number.
* 
* @param {Id.Buffer}  _source
* @param {Real}       _byte
*/ 
function KorutiiniBuilderScanner_IsBeginNumber(_source, _byte)
{
  // If digit, then it's a number.
  if (KorutiiniBuilderScanner_IsDigit(_byte) == true)
  {
    return true;
  }
  
  
  // Peek next character.
  var _peek = buffer_peek(_source, buffer_tell(_source) + 1, buffer_u8);
  
  
  // Check whether float number like: ".123"
  if (_byte == ord("."))
  && (KorutiiniBuilderScanner_IsDigit(_peek) == true)
  {
    return true;
  }
  
  
  // Otherwise it is not.
  return false;
}