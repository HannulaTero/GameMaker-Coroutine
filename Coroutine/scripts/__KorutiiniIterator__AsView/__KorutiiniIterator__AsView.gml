

/**
* Sets iterator state for buffer in specific view.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsView()
{
  data    = item.data;
  dtype   = item.dtype;
  dsize   = item.dsize;
  start   = item.start;
  stop    = item.stop;
  step    = item.step;
  count   = floor((stop - start) / step);
  GetVal  = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = buffer_peek(data, (start + step * index) * dsize, dtype); };
  GetKey  = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}