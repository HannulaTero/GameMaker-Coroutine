

/**
* Whenever async event is fired, this will trigger listeners.
*/ 
function __Coroutine_AsyncListen()
{
  var _listeners = COROUTINE_ASYNC_LISTENERS[? event_number];
  var _identifiers = ds_map_keys_to_array(_listeners);
  var _count = array_length(_identifiers);
  for(var i = 0; i < _count; i++)
  {
    var _listener = _listeners[? _identifiers[i]];
    _listener.onListen(_listener);
  }
  array_resize(_identifiers, 0);
}