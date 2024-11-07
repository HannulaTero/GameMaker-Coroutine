


/// @func CO_NOP();
/// @desc
/// @returns {Undefined}
function CO_NOP()
{
  gml_pragma("forceinline"); 
  return undefined;
}


/// @func CO_BEGIN();
/// @desc
/// @returns {Struct}
function CO_BEGIN()
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "BEGIN" 
  }; 
}


/// @func CO_FINISH();
/// @desc
/// @returns {Struct}
function CO_FINISH()
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "FINISH" 
  }; 
}


/// @func CO_THEN(_nodes);
/// @desc
/// @param {Array<Struct>} _nodes
/// @returns {Struct}
function CO_THEN(_nodes)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "THEN", 
    nodes: _nodes 
  }; 
}


/// @func CO_PASS(_call);
/// @desc
/// @param {Function} _call
/// @returns {Struct}
function CO_PASS(_call)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "PASS", 
    call: method(undefined, _call) 
  }; 
}


/// @func CO_LABEL(_label);
/// @desc
/// @param {Struct} _label
/// @returns {Struct}
function CO_LABEL(_label)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "LABEL", 
    label: _label.name 
  }
};


/// @func CO_YIELD(_call);
/// @desc
/// @param {Function} _call
/// @returns {Struct}
function CO_YIELD(_call)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "YIELD", 
    call: method(undefined, _call) 
  };
}


/// @func CO_PAUSE(_call);
/// @desc
/// @param {Function} _call
/// @returns {Struct}
function CO_PAUSE(_call)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "PAUSE", 
    call: method(undefined, _call)
  };
}


/// @func CO_DELAY(_call, _type);
/// @desc
/// @param {Function} _call
/// @param {String} _type
/// @returns {Struct}
function CO_DELAY(_call, _type)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "DELAY", 
    call: method(undefined, _call), 
    type: _type 
  };
}


/// @func CO_AWAIT(_type, _call);
/// @desc
/// @param {String} _type
/// @param {Function} _call
/// @returns {Struct}
function CO_AWAIT(_type, _call)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "AWAIT", 
    call: method(undefined, _call), 
    type: _type 
  }; 
}


/// @func CO_ASYNC(_type, _body);
/// @desc
/// @param {String} _type
/// @param {Struct} _body
/// @returns {Struct}
function CO_ASYNC(_type, _body)
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "ASYNC", 
    body: _body, 
    type: _type 
  }; 
}


/// @func CO_TIMEOUT(_call, _type);
/// @desc
/// @param {Function} _call
/// @param {String} _type
/// @returns {Struct}
function CO_TIMEOUT(_call, _type) 
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "TIMEOUT", 
    call: method(undefined, _call), 
    type: _type 
  }; 
}


/// @func CO_IF_CHAIN();
/// @desc Chain of if-elif-else -statements, generates equilevant if-else -tree.
/// @returns {Struct}
function CO_IF_CHAIN()
{
  gml_pragma("forceinline"); 
  
  // Macros generate if-statements as chain of [cond|node|cond|node|...]
  // The else-branch is also generated as two-parts to match pattern.
  // But it uses special "no action" function to mark itself.
  var _root = CO_IF(argument[0], argument[1]);
  var _prev = _root;
  for(var i = 2; i < argument_count; i+=2)
  {
    var _cond = argument[i + 0];
    var _node = argument[i + 1];
    if (_cond == CO_NOP)
    {
      _prev.nodeElse = _node;
      break;
    }
    var _next = CO_IF(_cond, _node);
    _prev.nodeElse = _next;
    _prev = _next;
  }
  return _root;
}


/// @func CO_IF(_cond, _then);
/// @desc
/// @param {Function} _cond
/// @param {Struct} _then
/// @returns {Struct}
function CO_IF(_cond, _then, _else=undefined) 
{ 
  gml_pragma("forceinline");   
  return { 
    name: "IF", 
    cond: method(undefined, _cond),
    nodeThen: _then,
    nodeElse: _else,
  }; 
}


/// @func CO_WHILE(_cond, _body);
/// @desc
/// @param {Function} _cond
/// @param {Struct} _body
/// @returns {Struct}
function CO_WHILE(_cond, _body) 
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "WHILE", 
    cond: method(undefined, _cond),
    body: _body,
  }; 
}


/// @func CO_REPEAT(_call, _body);
/// @desc
/// @param {Function} _call
/// @param {Struct} _body
/// @returns {Struct}
function CO_REPEAT(_call, _body) 
{ 
  gml_pragma("forceinline"); 
  return { 
    name: "REPEAT", 
    call: method(undefined, _call),
    body: _body,
  }; 
}


/// @func CO_FOR();
/// @desc Init is always first. Cond and iter are optional. Last argument should be the body.
/// @returns {Struct}
function CO_FOR() 
{ 
  gml_pragma("forceinline"); 
  
  // Handle optional parts.
  var _init = method(undefined, argument[0]);
  var _cond = undefined;
  var _iter = undefined;
  var _body = argument[argument_count - 1];
  var _count = argument_count - 2;
  for(var i = 1; i < _count; i+=2)
  {
    var _mark = argument[i];
    var _call = method(undefined, argument[i+1]);
    if (_mark == "INIT") _init = _call;
    else if (_mark == "COND") _cond = _call;
    else if (_mark == "ITER") _iter = _call;
  }
  
  return { 
    name: "FOR", 
    init: _init,
    cond: _cond,
    iter: _iter,
    body: _body,
  }; 
}


/// @func CO_FOREACH(_names, _item, _body);
/// @desc
/// @param {Function} _names
/// @param {Function} _item
/// @param {Struct} _body
/// @returns {Struct}
function CO_FOREACH(_names, _item, _body) 
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
    key: _nameKey, 
    val: _nameVal,
    item: method(undefined, _item),
    body: _body,
  }; 
}

