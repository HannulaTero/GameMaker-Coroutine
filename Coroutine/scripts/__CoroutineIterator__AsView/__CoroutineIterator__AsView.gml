

/**
* Sets iterator state for buffer in specific view.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__AsView()
{
  data    = item.data;
  dtype   = item.dtype;
  dsize   = item.dsize;
  start   = item.start;
  stop    = item.stop;
  step    = item.step;
  count   = floor((stop - start) / step);
  GetVal  = function() { COROUTINE_CURRENT_SCOPE[$ nameVal] = buffer_peek(data, (start + step * index) * dsize, dtype); };
  GetKey  = function() { COROUTINE_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}