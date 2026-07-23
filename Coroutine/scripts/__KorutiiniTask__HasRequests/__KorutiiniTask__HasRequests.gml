

/**
* Whether has pending async requests.
* 
* @context __KorutiiniTask
* @returns {Bool}
*/ 
function __KorutiiniTask__HasRequests()
{
  return (ds_map_size(childRequests) > 0);
}