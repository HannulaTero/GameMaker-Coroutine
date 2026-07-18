

/**
* Executes given callback in current coroutines scope.
*
* @param {Function} _callback
*/
function __Coroutine_Execute(_callback)
{
  gml_pragma("forceinline");
  with(COROUTINE_CURRENT_SCOPE) 
  {
    return _callback();
  }
}
