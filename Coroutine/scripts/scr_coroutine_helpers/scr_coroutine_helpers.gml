

/// @func coroutine_create(_funcAST);
/// @desc Creates coroutine prototype, or uses cached version of it.
/// @param {Function} _funcAST
/// @returns {Struct.CoroutinePrototype}
function coroutine_create(_funcAST)
{
  // _funcAST is function, which generates nodes (abstract syntax tree).
  // Nodes are transformed into executable directed graph.
  static transform = new CoroutineTransform();
  
  // Pick coroutine prototype from cache.
  var _key = method_get_index(_funcAST);
  if (ds_map_exists(COROUTINE_CACHE_PROTOTYPES, _key))
  {
    return COROUTINE_CACHE_PROTOTYPES[? _key];
  }
  
  // Otherwise create a new protoptype, and add it to the cache.
  var _root = _funcAST();
  transform.Dispatch(_root);
  var _prototype = new CoroutinePrototype(_root);
  COROUTINE_CACHE_PROTOTYPES[? _key] = _prototype;
  return _prototype;
}


/// @func coroutine_execute(_callback);
/// @desc Executes given callback in current coroutines scope.
/// @param {Function} _callback
function coroutine_execute(_callback)
{
  gml_pragma("forceinline");
  with(COROUTINE_SCOPE) return _callback();
}


/// @func coroutine_async_listen();
/// @desc When async event is fired, this will trigger listeners.
function coroutine_async_listen()
{
  gml_pragma("forceinline");
  // Keys are same as values, so no need to read the map itself.
  var _listeners = ds_map_keys_to_array(COROUTINE_ASYNC_LISTENERS[? event_number]);
  var _count = array_length(_listeners);
  for(var i = 0; i < _count; i++)
  {
    _listeners[i].onListen();
  }
  array_resize(_listeners, 0);
}


/// @func coroutine_mapping(_array);
/// @desc
/// @param {Array<Any>} _array
/// @returns {Struct}
function coroutine_mapping(_array)
{
  gml_pragma("forceinline");
  var _mapping = {};
  var _countOuter = array_length(_array);
  for(var i = 0; i < _countOuter; i+=2)
  {
    var _lhs = _array[i + 0];
    var _rhs = _array[i + 1];
    _rhs = method(undefined, _rhs);
    
    var _countInner = array_length(_lhs);
    for(var j = 0; j < _countInner; j++)
    {
      _mapping[$ _lhs[j]] = _rhs;
    }
  }
  return _mapping;
}


/// @func coroutine_frame_time_get();
/// @desc Tells how much time has passed since frame started.
/// @returns {Real}
function coroutine_frame_time_get()
{
  gml_pragma("forceinline");
  return (current_time - COROUTINE_FRAME_TIME_BEGIN);
}


/// @func coroutine_frame_time_usage();
/// @desc Returns how much of frame time budget has been used already.
/// @returns {Real}
function coroutine_frame_time_usage()
{
  gml_pragma("forceinline");
  return (current_time - COROUTINE_FRAME_TIME_BEGIN) / game_get_speed(gamespeed_microseconds);
}











