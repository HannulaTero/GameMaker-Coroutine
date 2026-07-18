

/**
* Returns current result of coroutine.
* 
* @context __CoroutineTask
* @param {Any} _value
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Set(_value)
{
  result = _value;
  return self;
}