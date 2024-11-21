

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