

/**
* Sets iterator state for string.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsString()
{
  index = 1; // In GML, strings are 1-indexed.
  count = string_length(item) + 1;
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = string_char_at(item, index); };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}