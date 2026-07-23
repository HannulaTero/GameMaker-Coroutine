

/**
* Executes function in the coroutine's scope.
* 
* @context __KorutiiniTask
* @param {Function} _func
* @returns {Struct.__KorutiiniTask}
*/ 
function __KorutiiniTask__Execute(_func)
{
  with scope return _func();
  return self;
}