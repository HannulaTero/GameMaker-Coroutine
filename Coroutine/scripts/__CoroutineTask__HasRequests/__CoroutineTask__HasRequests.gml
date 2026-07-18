

/**
* Whether has pending async requests.
* 
* @context __CoroutineTask
* @returns {Bool}
*/ 
function __CoroutineTask__HasRequests()
{
  return (ds_map_size(asyncRequests) > 0);
}