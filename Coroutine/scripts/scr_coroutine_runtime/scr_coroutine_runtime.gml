



/// @func CO_RUNTIME_RESTART();
/// @desc 
/// @returns {Bool}
function CO_RUNTIME_RESTART()
{
  coroutine.index = 0;
  array_resize(coroutine.local, 0);
  return true;
}


/// @func CO_RUNTIME_CONTINUE();
/// @desc 
/// @returns {Bool}
function CO_RUNTIME_CONTINUE()
{
  
}


/// @func CO_RUNTIME_BREAK();
/// @desc 
/// @returns {Bool}
function CO_RUNTIME_BREAK()
{
  
}


/// @func CO_RUNTIME_CANCEL();
/// @desc 
/// @returns {Bool}
function CO_RUNTIME_CANCEL()
{
  with(coroutine) Execute(triggers.onCancel);
  return false;
}


/// @func CO_RUNTIME_QUIT();
/// @desc 
/// @returns {Bool}
function CO_RUNTIME_QUIT()
{
  coroutine.finished = true;
  array_resize(coroutine.local, 0);
  return false;
}


/// @func CO_RUNTIME_RETURN(_return);
/// @desc 
/// @param {Any} _return
/// @returns {Bool}
function CO_RUNTIME_RETURN(_return)
{
  coroutine.finished = true;
  coroutine.result = _return;
  array_resize(coroutine.local, 0);
  return false;
}


/// @func CO_RUNTIME_GOTO(_label);
/// @desc 
/// @param {String} _label
/// @returns {Bool}
function CO_RUNTIME_GOTO(_label)
{
  coroutine.index = coroutine.labels[$ _label];
  return true;
}


