

/**
* Get the keys and values for next iteration.
* 
* @context __KorutiiniIterator
* @returns {__KorutiiniIterator}
*/ 
function __KorutiiniIterator__Next()
{
  if (nameVal != undefined) GetVal();
  if (nameKey != undefined) GetKey(); 
  index++;
  return self;
}