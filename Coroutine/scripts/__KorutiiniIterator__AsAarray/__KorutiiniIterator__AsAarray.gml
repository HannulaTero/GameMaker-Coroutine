

/**
* Sets iterator state for array.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsArray()
{
  count = array_length(item);
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = item[index]; };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}