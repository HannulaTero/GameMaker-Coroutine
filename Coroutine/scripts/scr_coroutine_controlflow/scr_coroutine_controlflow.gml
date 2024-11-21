



/// @func CO_RUNTIME_RESTART();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_RESTART()
{
  // feather ignore GM1049
  with(COROUTINE_CURRENT)
  {
    Restart();
    return execute;
  }
}


/// @func CO_RUNTIME_CONTINUE();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_CONTINUE()
{
  return method_get_self(COROUTINE_EXECUTE).onContinue;
}


/// @func CO_RUNTIME_BREAK();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_BREAK()
{
  return method_get_self(COROUTINE_EXECUTE).onBreak;
}


/// @func CO_RUNTIME_RETURN(_return);
/// @desc 
/// @param {Any} _return
/// @returns {Undefined}
function CO_RUNTIME_RETURN(_return)
{
  COROUTINE_CURRENT.Finish(_return);
  COROUTINE_YIELD = true;
  return undefined;
}


/// @func CO_RUNTIME_CANCEL();
/// @desc 
/// @returns {Undefined}
function CO_RUNTIME_CANCEL()
{
  COROUTINE_CURRENT.Cancel();
  COROUTINE_YIELD = true;
  return undefined;
}


/// @func CO_RUNTIME_GOTO(_label);
/// @desc 
/// @param {String} _label
/// @returns {Function}
function CO_RUNTIME_GOTO(_label)
{
  // feather ignore GM1049
  with(COROUTINE_CURRENT)
  {
    if (struct_exists(labels, _label) == false)
    {
      throw($"{name}, Unknown GOTO -target: '{_label}'.");
    }
    return labels[$ _label];
  }
}


