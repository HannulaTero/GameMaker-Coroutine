

/**
* Sets iterator state for string.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsString()
{
  index = 1; // In GML, strings are 1-indexed.
  count = string_length(item) + 1;
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = string_char_at(item, index); };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}