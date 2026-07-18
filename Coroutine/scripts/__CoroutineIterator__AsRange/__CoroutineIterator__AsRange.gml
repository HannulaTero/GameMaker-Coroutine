

/**
* Sets iterator state for range.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsRange()
{
  start = item.start;
  stop = item.stop;
  step = item.step;
  count = floor((stop - start) / step);
  GetVal = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = start + step * index; };
  GetKey = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}