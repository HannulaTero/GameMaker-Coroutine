

/**
* Sets iterator state for object.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsObject()
{
  // Works only for single object-type, as array is iterable-type already.
  var _index = 0;
  var _object = item;
  var _instances = array_create(instance_number(item));
  with(_object) _instances[_index++] = self;
    
  item = _instances;
  count = array_length(item);
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = item[index]; };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}