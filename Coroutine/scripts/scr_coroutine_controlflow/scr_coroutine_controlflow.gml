



/// @func CO_RUNTIME_RESTART();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_RESTART()
{
  with(obj_coroutine_manager.oroutine)
  {
    Restart();
    return current;
  }
}


/// @func CO_RUNTIME_CONTINUE();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_CONTINUE()
{
  return method_get_self(obj_coroutine_manager.coroutine.current).onContinue;
}


/// @func CO_RUNTIME_BREAK();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_BREAK()
{
  return method_get_self(obj_coroutine_manager.coroutine.current).onBreak;
}


/// @func CO_RUNTIME_RETURN(_return);
/// @desc 
/// @param {Any} _return
/// @returns {Undefined}
function CO_RUNTIME_RETURN(_return)
{
  obj_coroutine_manager.coroutine.Return(_return);
  return undefined;
}


/// @func CO_RUNTIME_GOTO(_label);
/// @desc 
/// @param {String} _label
/// @returns {Function}
function CO_RUNTIME_GOTO(_label)
{
  with(obj_coroutine_manager.coroutine)
  {
    if (struct_exists(label, _label) == false)
    {
      throw($"{name}, Unknown GOTO -target: '{_label}'.");
    }
    return label[$ _label];
  }
}


