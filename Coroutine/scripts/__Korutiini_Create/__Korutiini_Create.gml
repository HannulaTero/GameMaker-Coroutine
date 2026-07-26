

/**
* Creates coroutine prototype, or uses cached version of it.
* 
* @param {Function} _funcAST  Function which returns Abstract Syntax Tree.
* @returns {Function}
*/
function __Korutiini_Create(_funcAST)
{
  // _funcAST is function, which generates nodes (abstract syntax tree).
  // Nodes are transformed into executable directed graph.
  static transform  = new __KorutiiniTransform();
  static prototypes = __KorutiiniRuntime_CachePrototypes();
  
  // Pick coroutine prototype from cache.
  var _key = method_get_index(_funcAST);
  if (ds_map_exists(prototypes, _key))
  {
    return prototypes[? _key];
  }
  
  // Otherwise create a new prototype, and generate function for it. 
  var _root = _funcAST();
  transform.Dispatch(_root);
  var _prototype = new __KorutiiniPrototype(_root);
  prototypes[? _key] = _prototype;
  return _prototype;
}