

/**
* Executes given callback in current coroutines scope.
*
* @param {Function} _callback
*/
function __Korutiini_Execute(_callback)
{
  gml_pragma("forceinline");
  with(KORUTIINI_CURRENT_SCOPE) 
  {
    return _callback();
  }
}
