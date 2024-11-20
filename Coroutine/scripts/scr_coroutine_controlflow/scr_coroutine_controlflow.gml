



/// @func CO_RUNTIME_RESTART();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_RESTART()
{
  with(COROUTINE_CURRENT)
  {
    Restart();
    COROUTINE_EXECUTE = execute;
  }
}


/// @func CO_RUNTIME_CONTINUE();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_CONTINUE()
{
  COROUTINE_EXECUTE = method_get_self(COROUTINE_EXECUTE).onContinue;
}


/// @func CO_RUNTIME_BREAK();
/// @desc 
/// @returns {Function}
function CO_RUNTIME_BREAK()
{
  COROUTINE_EXECUTE = method_get_self(COROUTINE_EXECUTE).onBreak;
}


/// @func CO_RUNTIME_RETURN(_return);
/// @desc 
/// @param {Any} _return
/// @returns {Undefined}
function CO_RUNTIME_RETURN(_return)
{
  COROUTINE_CURRENT.Return(_return);
  COROUTINE_EXECUTE = undefined;
}


/// @func CO_RUNTIME_GOTO(_label);
/// @desc 
/// @param {String} _label
/// @returns {Function}
function CO_RUNTIME_GOTO(_label)
{
  with(COROUTINE_CURRENT)
  {
    if (struct_exists(label, _label) == false)
    {
      throw($"{name}, Unknown GOTO -target: '{_label}'.");
    }
    COROUTINE_EXECUTE = label[$ _label];
  }
}


