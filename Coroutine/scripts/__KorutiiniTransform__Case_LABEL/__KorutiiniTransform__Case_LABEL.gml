

/**
* Labels for goto -targets.
* Doesn't produce new node, only marks position.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_LABEL(_node, _next, _break, _continue)
{
  labels[$ _node.label] = _next.execute;
  return _next;
}