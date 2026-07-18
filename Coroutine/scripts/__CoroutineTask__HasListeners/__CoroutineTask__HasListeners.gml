

/**
* Whether has async listeners.
* 
* @context __CoroutineTask
* @returns {Bool}
*/ 
function __CoroutineTask__HasListeners()
{
  return (ds_map_size(asyncListeners) > 0);
}