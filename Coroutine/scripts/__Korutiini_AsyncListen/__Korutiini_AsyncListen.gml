

/**
* Whenever async event is fired, this will trigger listeners.
* This is used by manager in Async-events, shouldn't be used elsewhere.
*/ 
function __Korutiini_AsyncListen()
{
  static asyncListeners = __KorutiiniRuntime_AsyncListeners();
  
  
  var _listeners    = asyncListeners[? event_number];
  var _identifiers  = ds_map_keys_to_array(_listeners);
  var _count        = array_length(_identifiers);
  
  
  for(var i = 0; i < _count; i++)
  {
    var _listener = _listeners[? _identifiers[i]];
    _listener.onListen(_listener);
  }
  
  
  array_resize(_identifiers, 0);
}