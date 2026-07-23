

/**
* Sets iterator state for ds_list.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsList()
{
  count = ds_list_size(item);
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = item[| index]; };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}