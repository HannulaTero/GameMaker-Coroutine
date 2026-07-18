

/**
* Sets iterator state for array.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsArray()
{
  count = array_length(item);
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = item[index]; };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}