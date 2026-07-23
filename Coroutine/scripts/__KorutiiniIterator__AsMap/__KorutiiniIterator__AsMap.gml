

/**
* Sets iterator state for ds_map.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsMap()
{
  keys    = ds_map_keys_to_array(item);
  count   = ds_map_size(item);
  GetVal  = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = item[? keys[index]]; };
  GetKey  = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = keys[index]; };
  return self;
}