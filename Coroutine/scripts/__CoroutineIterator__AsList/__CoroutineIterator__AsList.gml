

/**
* Sets iterator state for ds_list.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsList()
{
  count = ds_list_size(item);
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = item[| index]; };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}