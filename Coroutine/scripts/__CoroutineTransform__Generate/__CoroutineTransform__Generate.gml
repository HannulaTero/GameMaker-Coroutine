

/**
* Finds out generator based on node-type.
*
* @context __CoroutineTransform
* @param {Struct} _node
* @param {Struct} _next
* @param {Struct} _break
* @param {Struct} _continue
* @returns {Function}
*/ 
function __CoroutineTransform__Generate(_node, _next, _break, _continue)
{
  // Assumes nodes are valid, and there is always functor for given node-name.
  return cases[$ _node.name](_node, _next, _break, _continue);
}