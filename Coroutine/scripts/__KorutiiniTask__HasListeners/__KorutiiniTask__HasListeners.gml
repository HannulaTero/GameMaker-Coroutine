

/**
* Whether has async listeners.
* 
* @context __KorutiiniTask
* @returns {Bool}
*/ 
function __KorutiiniTask__HasListeners()
{
  return (ds_map_size(childListeners) > 0);
}