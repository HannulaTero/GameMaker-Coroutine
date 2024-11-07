

/// @func coroutine_create(_funcNodeCreator);
/// @desc Creates coroutine prototype, which has linear instructions.
/// @param {Function} _funcNodeCreator
function coroutine_create(_funcNodeCreator)
{
  // Parameter is function, which generates nodes (abstract syntax tree).
  // Nodes are compiled into linearized instructions, 
  // and finally coroutine is created to handle execution state.
  static compiler = new CoroutineCompiler();
  
  // Pick coroutine prototype from cache.
  var _key = method_get_index(_funcNodeCreator);
  if (ds_map_exists(COROUTINE_CACHE, _key))
  {
    return COROUTINE_CACHE[? _key];
  }
  
  // Otherwise create a new protoptype, and add it to the cache.
  // This compiles the nodes into linear instructions.
  var _root = _funcNodeCreator();
  var _prototype = compiler.Dispatch(_root);
  COROUTINE_CACHE[? _key] = _prototype;
  return _prototype;
}