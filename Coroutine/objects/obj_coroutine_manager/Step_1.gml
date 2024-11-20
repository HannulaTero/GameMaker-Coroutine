/// @desc ASYNC REQUEST TIMEOUT.


// Loop over all async request types.
var _keys = ds_map_keys_to_array(COROUTINE_HASH_ASYNC);
var _count = array_length(_keys);

for(var i = 0; i < _count; i++)
{
  // Look up specific async type.
  var _key = _keys[i];
  var _requests = COROUTINE_HASH_ASYNC[? _key];
  var _requestKeys = ds_map_keys_to_array(_requests);
  var _requestCount = array_length(_requestKeys);
  
  // Loop over all requests of given type.
  for(var j = 0; j < _requestCount; j++)
  {
    // Remove erquests which have time out.
    var _requestKey = _requestKeys[j];
    var _request = _requests[? _requestKey];
    if (_request.isTimedOut())
    {
      ds_map_delete(_requests, _requestKey);
    }
  }
  
  array_resize(_requestKeys, 0);
}
array_resize(_keys, 0);