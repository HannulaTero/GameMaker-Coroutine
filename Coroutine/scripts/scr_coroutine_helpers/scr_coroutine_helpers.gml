

/// @func coroutine_create(_funcAST);
/// @desc Creates coroutine prototype, which has linear instructions.
/// @param {Function} _funcAST
/// @returns {Struct.CoroutinePrototype}
function coroutine_create(_funcAST)
{
  // Parameter is function, which generates nodes (abstract syntax tree).
  // Nodes are parsed into linearized instructions, 
  // and finally coroutine is created to handle execution state.
  static transform = new CoroutineTransform();
  
  // Pick coroutine prototype from cache.
  var _key = method_get_index(_funcAST);
  if (ds_map_exists(COROUTINE_CACHE_PROTOTYPES, _key))
  {
    return COROUTINE_CACHE_PROTOTYPES[? _key];
  }
  
  // Otherwise create a new protoptype, and add it to the cache.
  // This parses the nodes into linear instructions.
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











