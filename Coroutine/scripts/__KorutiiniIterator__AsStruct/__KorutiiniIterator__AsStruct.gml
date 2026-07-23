

/**
* Sets iterator state for struct.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsStruct()
{
  keys = struct_get_names(item);
  count = struct_names_count(item);
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = item[$ keys[index]]; };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = keys[index]; };
  return self;
}