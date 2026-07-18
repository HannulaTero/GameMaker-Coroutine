

/**
* Executes function in the coroutine's scope.
* 
* @context __CoroutineTask
* @param {Function} _func
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Execute(_func)
{
  with scope return _func();
  return self;
}