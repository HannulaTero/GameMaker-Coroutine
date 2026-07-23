
/*
  
  These "nodes" are runtime functions, which return required information for execution.
  
*/ 



/**
* Jumps directly at the beginning, doesn't do anything to ensure correctness.
* 
* @returns {Function}
*/
function __KorutiiniNode_RUNTIME_RESTART()
{
  return KORUTIINI_CURRENT_TASK.graph.execute;
}



/**
*
* @returns {Function}
*/
function __KorutiiniNode_RUNTIME_CONTINUE()
{
  return method_get_self(KORUTIINI_CURRENT_EXECUTE).onContinue;
}



/**
*
* @returns {Function}
*/
function __KorutiiniNode_RUNTIME_BREAK()
{
  return method_get_self(KORUTIINI_CURRENT_EXECUTE).onBreak;
}



/**
*
* @param {Any} _return
* @returns {Undefined}
* feather ignore GM1041
* feather ignore GM1049
*/
function __KorutiiniNode_RUNTIME_RETURN(_return)
{
  KORUTIINI_CURRENT_YIELDED = true;
  with(KORUTIINI_CURRENT_TASK)
  {
    result = _return ?? result;
    onComplete();
    Destroy();
  }
  return undefined;
}



/**
*
* @returns {Undefined}
* feather ignore GM1041
* feather ignore GM1049
*/
function __KorutiiniNode_RUNTIME_CANCEL()
{
  KORUTIINI_CURRENT_YIELDED = true;
  with(KORUTIINI_CURRENT_TASK)
  {
    onCancel();
    Destroy(self);
  }
  return undefined;
}



/**
*
* @param {String} _label
* @returns {Function}
*/
function __KorutiiniNode_RUNTIME_GOTO(_label)
{
  // feather ignore GM1049
  with(KORUTIINI_CURRENT_TASK)
  {
    if (struct_exists(labels, _label) == false)
    {
      throw($"{option.name}, Unknown GOTO -target: '{_label}'.");
    }
    return labels[$ _label];
  }
}


