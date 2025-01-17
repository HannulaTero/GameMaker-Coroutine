// feather ignore all


/// @func coroutine_create(_funcAST);
/// @desc Creates coroutine prototype, or uses cached version of it.
/// @param {Function} _funcAST
/// @returns {Function}
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
  
  // Otherwise create a new protoptype, and generate function for it. 
  // 
  var _root = _funcAST();
  transform.Dispatch(_root);
  var _prototype = new CoroutinePrototype(_root);
  COROUTINE_CACHE_PROTOTYPES[? _key] = _prototype;
  return _prototype;
}


/// @func coroutine_async_listen();
/// @desc Whenever async event is fired, this will trigger listeners.
function coroutine_async_listen()
{
  gml_pragma("forceinline");
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
  return (current_time - COROUTINE_FRAME_TIME_BEGIN) * 1_000.0 / game_get_speed(gamespeed_microseconds);
}


/// @func coroutine_execute(_callback);
/// @desc Executes given callback in current coroutines scope.
/// @param {Function} _callback
function coroutine_execute(_callback)
{
  gml_pragma("forceinline");
  with(COROUTINE_CURRENT_SCOPE) return _callback();
}




