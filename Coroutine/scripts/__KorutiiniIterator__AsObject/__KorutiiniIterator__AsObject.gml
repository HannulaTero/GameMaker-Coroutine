

/**
* Sets iterator state for object.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsObject()
{
  // Works only for single object-type, as array is iterable-type already.
  var _index = 0;
  var _object = item;
  var _instances = array_create(instance_number(item));
  with(_object) _instances[_index++] = self;
    
  item = _instances;
  count = array_length(item);
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = item[index]; };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}