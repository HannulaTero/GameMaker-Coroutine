/*

  These are functions, which are used within macro.

*/


/**
* No operation, this is used as a marker instead!
* 
* @returns {Undefined}
*/
function __CoroutineNode_NOP()
{
  gml_pragma("forceinline"); 
  return undefined;
}


/**
* 
* @param {String} _name
* @returns {Struct}
*/ 
function __CoroutineNode_NODE(_name)
{ 
  gml_pragma("forceinline"); 
  return { name: _name }; 
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_FINISH()
{ 
  gml_pragma("forceinline"); 
  return { name: "FINISH" }; 
}


/**
* 
* @param {Array<Struct>} _nodes
* @returns {Struct}
*/
function __CoroutineNode_BLOCK(_nodes)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "BLOCK", 
    nodes: _nodes 
  }; 
}


/**
* 
* @param {Function} _call
* @returns {Struct}
*/
function __CoroutineNode_STMT(_call)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "STMT", 
    call: method(undefined, _call) 
  }; 
}


/**
* 
* @param {Struct} _label
* @returns {Struct}
*/
function __CoroutineNode_LABEL(_label)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "LABEL", 
    label: _label.label 
  };
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_YIELD()
{ 
  gml_pragma("forceinline"); 
  return { name: "YIELD" };
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_PAUSE()
{ 
  gml_pragma("forceinline"); 
  return { name: "PAUSE" };
}


/**
* 
* @param {Function} _call
* @returns {Struct}
*/
function __CoroutineNode_SET(_call)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "SET", 
    call: method(undefined, _call) 
  };
}


/**
* 
* @param {Function} _call
* @returns {Struct}
*/
function __CoroutineNode_YIELD_WITH(_call)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "YIELD_SET", 
    call: method(undefined, _call) 
  };
}


/**
* 
* @param {Function} _call
* @returns {Struct}
*/
function __CoroutineNode_PAUSE_WITH(_call)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "PAUSE_SET", 
    call: method(undefined, _call)
  };
}


/**
* 
* @param {Function} _call
* @param {String} _type
* @returns {Struct}
*/
function __CoroutineNode_DELAY(_call, _type)
{ 
  gml_pragma("forceinline"); 
  return {
    name: "DELAY", 
    call: method(undefined, _call), 
    type: _type 
  };
}


/**
* 
* @param {String} _type
* @param {Function} _call
* @returns {Struct}
*/
function __CoroutineNode_AWAIT(_type, _call)
{ 
  gml_pragma("forceinline"); 
  return {
    name: $"AWAIT_{_type}", 
    call: method(undefined, _call), 
  }; 
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_AWAIT_SUBTASKS()
{ 
  gml_pragma("forceinline"); 
  return { name: "AWAIT_SUBTASKS" }; 
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_AWAIT_REQUESTS()
{ 
  gml_pragma("forceinline"); 
  return { name: "AWAIT_REQUESTS" }; 
}


/**
* 
* @returns {Struct}
*/
function __CoroutineNode_AWAIT_LISTENERS()
{ 
  gml_pragma("forceinline"); 
  return { name: "AWAIT_LISTENERS" }; 
}


/**
* 
* @param {Function} _call
* @param {String} _type
* @returns {Struct}
*/
function __CoroutineNode_TIMEOUT(_call, _type) 
{ 
  gml_pragma("forceinline"); 
  return {
    name: "TIMEOUT", 
    call: method(undefined, _call), 
    type: _type 
  }; 
}



/**
* Chain of if-elif-else -statements, generates equilevant if-else -tree.
* 
* @returns {Struct}
*/
function __CoroutineNode_IF_CHAIN()
{
  gml_pragma("forceinline"); 
  
  // Macros generate if-statements as chain of [cond|node|cond|node|...]
  // The else-branch is also generated as two-parts to match pattern.
  // But it uses special "no action" function to mark itself.
  var _root = __CoroutineNode_IF(argument[0], argument[1]);
  var _prev = _root;
  for(var i = 2; i < argument_count; i+=2)
  {
    var _cond = argument[i + 0];
    var _node = argument[i + 1];
    if (_cond == __CoroutineNode_NOP)
    {
      _prev.nodeElse = _node;
      break;
    }
    var _next = __CoroutineNode_IF(_cond, _node);
    _prev.nodeElse = _next;
    _prev = _next;
  }
  return _root;
}


/**
* 
* @param {Function} _cond
* @param {Struct} _then
* @returns {Struct}
*/
function __CoroutineNode_IF(_cond, _then, _else=undefined) 
{ 
  gml_pragma("forceinline");   
  return {
    name: "IF", 
    cond: method(undefined, _cond),
    nodeThen: _then,
    nodeElse: _else,
  }; 
}


/**
* Switch-statement, which allows arbitrary number of cases. 
* This also creates constant lookup-table -> so finding each case is O(1)
* -> In regular GML switch is O(N), as it's like if-else-chain in trenchcoat.
* 
* @returns {Struct}
*/
function __CoroutineNode_SWITCH()
{
  gml_pragma("forceinline"); 
  var _item = argument[0][0]; // Macro uses array to avoid extra THEN.
  var _cases = [];
  var _default = undefined;
  for(var i = 1; i < argument_count; i+=2)
  {
    var _cond = argument[i + 0];
    var _body = argument[i + 1];
    if (_cond == __CoroutineNode_NOP)
    {
      _default = _body;
      break;
    }
    array_push(_cases, { 
      cond: _cond, 
      body: _body 
    });
  }
  
  return {
    name: "SWITCH",
    item: _item,
    cases: _cases,
    def: _default,
  };
}


/**
* 
* @param {Struct} _body
* @returns {Struct}
*/
function __CoroutineNode_LOOP(_body) 
{ 
  gml_pragma("forceinline"); 
  return {
    name: "LOOP", 
    body: _body,
  }; 
}


/**
* 
* @param {Function} _cond
* @param {Struct} _body
* @returns {Struct}
*/
function __CoroutineNode_WHILE(_cond, _body) 
{ 
  gml_pragma("forceinline"); 
  return {
    name: "WHILE", 
    cond: method(undefined, _cond),
    body: _body,
  }; 
}


/**
* 
* @param {Function} _call
* @param {Struct} _body
* @returns {Struct}
*/
function __CoroutineNode_REPEAT(_call, _body) 
{ 
  gml_pragma("forceinline"); 
  return {
    name: "REPEAT", 
    call: method(undefined, _call),
    body: _body,
  }; 
}


/**
* 
* @param {Struct} _body
* @param {Array<Function>} _cond 
* @returns {Struct}
*/
function __CoroutineNode_DO(_body, _cond) 
{ 
  gml_pragma("forceinline"); 
  // Condition is in array to work with macro syntax.
  _cond = _cond[0];
  return {
    name: "DO", 
    cond: method(undefined, _cond),
    body: _body,
  }; 
}


/**
* 
* @param {Function} _init
* @param {Function} _cond
* @param {Function} _iter
* @param {Struct} _body
* @returns {Struct}
*/
function __CoroutineNode_FOR(_init, _cond, _iter, _body) 
{ 
  gml_pragma("forceinline"); 
  return {
    name: "FOR", 
    init: method(undefined, _init),
    cond: method(undefined, _cond),
    iter: method(undefined, _iter),
    body: _body,
  }; 
}


/**
* Foreach, iterates through given item.
* This has ability to have custom names for (val, key) -iterators.
* 
* @param {Function} _names
* @param {Function} _item
* @param {Struct} _body
* @returns {Struct}
*/
function __CoroutineNode_FOREACH(_names, _item, _body) 
{ 
  gml_pragma("forceinline");
  
  // Find out the used iterator names.
  // This is a small hack, but it works, so don't mind.
  var _nameKey = undefined;
  var _nameVal = undefined;
  var _structNames = _names();
  var _structNameKeys = struct_get_names(_structNames); 
  var _structKeyCount = struct_names_count(_structNames);
  for(var i = 0; i < _structKeyCount; i++)
  {
    var _key = _structNameKeys[i];
    if (_structNames[$ _key] == "KEY") _nameKey = _key;
    if (_structNames[$ _key] == "VAL") _nameVal = _key;
  }
  array_resize(_structNameKeys, 0);
  
  // Return the struct
  return {
    name: "FOREACH", 
    item: method(undefined, _item),
    body: _body,
    key: _nameKey, 
    val: _nameVal,
  }; 
}




