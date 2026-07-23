

/**
* Sets iterator state for range.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__AsRange()
{
  start = item.start;
  stop = item.stop;
  step = item.step;
  count = floor((stop - start) / step);
  GetVal = function() { KORUTIINI_CURRENT_SCOPE[$ nameVal] = start + step * index; };
  GetKey = function() { KORUTIINI_CURRENT_SCOPE[$ nameKey] = index; };
  return self;
}