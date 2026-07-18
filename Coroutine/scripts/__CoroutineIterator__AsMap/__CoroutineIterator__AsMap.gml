

/**
* Sets iterator state for ds_map.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsMap()
{
  keys    = ds_map_keys_to_array(item);
  count   = ds_map_size(item);
  GetVal  = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = item[? keys[index]]; };
  GetKey  = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = keys[index]; };
  return self;
}