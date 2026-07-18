

/**
* Sets iterator state for struct.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsStruct()
{
  keys = struct_get_names(item);
  count = struct_names_count(item);
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = item[$ keys[index]]; };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = keys[index]; };
  return self;
}