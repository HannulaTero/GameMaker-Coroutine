



/// @func CO_RUNTIME_RESTART();
/// @desc Jumps directly at the beginning, doesn't do anything to ensure correctness.
/// @returns {Function}
function CO_RUNTIME_RESTART()
{
  return COROUTINE_CURRENT_TASK.graph.execute;
}


/// @func CO_RUNTIME_CONTINUE();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_CONTINUE()
{
  return method_get_self(COROUTINE_CURRENT_EXECUTE).onContinue;
}


/// @func CO_RUNTIME_BREAK();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_BREAK()
{
  return method_get_self(COROUTINE_CURRENT_EXECUTE).onBreak;
}


/// @func CO_RUNTIME_RETURN(_return);
/// @desc 
/// @param {Any} _return
/// @returns {Undefined}
// feather ignore GM1041
// feather ignore GM1049
function CO_RUNTIME_RETURN(_return)
{
  COROUTINE_CURRENT_YIELDED = true;
  with(COROUTINE_CURRENT_TASK)
  {
    result = _return;
    onComplete();
    Destroy(self);
  }
  return undefined;
}


/// @func CO_RUNTIME_GOTO(_label);
/// @desc 
/// @param {String} _label
/// @returns {Function}
function CO_RUNTIME_GOTO(_label)
{
  // feather ignore GM1049
  with(COROUTINE_CURRENT_TASK)
  {
    if (struct_exists(labels, _label) == false)
    {
      throw($"{option.name}, Unknown GOTO -target: '{_label}'.");
    }
    return labels[$ _label];
  }
}


