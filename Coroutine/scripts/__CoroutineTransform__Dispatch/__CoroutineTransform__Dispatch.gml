

/**
* Transforms AST nodes into executable directed graph.
* 
* @context __CoroutineTransform
* @param {Struct} _root
*/ 
function __CoroutineTransform__Dispatch(_root)
{
  tables    = _root.tables;
  labels    = _root.labels;
  final     = undefined;
  register  = 0;
    
  _root.graph = Generate(_root.nodes, finalNode, errorBreak, errorContinue);
  _root.execute = _root.graph.execute;
  _root.final = final;
  return _root;
}