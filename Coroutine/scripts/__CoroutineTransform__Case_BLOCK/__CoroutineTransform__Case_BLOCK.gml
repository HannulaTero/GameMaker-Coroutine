

/**
* Holds block of statements.
* When generating directed graph, block dissolves.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__Case_BLOCK(_block, _next, _break, _continue)
{
  var _nodes = _block.nodes;
  var _count = array_length(_nodes);
  for(var i = _count-1; i >= 0; i--)
  {
    _next = Generate(_nodes[i], _next, _break, _continue);
  }
  
  return _next;
}