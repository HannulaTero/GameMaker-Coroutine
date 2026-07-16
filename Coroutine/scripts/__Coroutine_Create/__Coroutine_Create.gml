

/**
* Creates coroutine prototype, or uses cached version of it.
* 
* @param {Function} _funcAST
* @returns {Function}
*/
function __Coroutine_Create(_funcAST)
{
  // _funcAST is function, which generates nodes (abstract syntax tree).
  // Nodes are transformed into executable directed graph.
  static transform = new __CoroutineTransform();
  
  // Pick coroutine prototype from cache.
  var _key = method_get_index(_funcAST);
  if (ds_map_exists(COROUTINE_CACHE_PROTOTYPES, _key))
  {
    return COROUTINE_CACHE_PROTOTYPES[? _key];
  }
  
  // Otherwise create a new protoptype, and generate function for it. 
  var _root = _funcAST();
  transform.Dispatch(_root);
  var _prototype = new __CoroutinePrototype(_root);
  COROUTINE_CACHE_PROTOTYPES[? _key] = _prototype;
  return _prototype;
}