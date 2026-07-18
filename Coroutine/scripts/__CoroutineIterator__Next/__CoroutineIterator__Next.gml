

/**
* Get the keys and values for next iteration.
* 
* @context __CoroutineIterator
* @returns {__CoroutineIterator}
*/ 
function __CoroutineIterator__Next()
{
  if (nameVal != undefined) GetVal();
  if (nameKey != undefined) GetKey(); 
  index++;
  return self;
}