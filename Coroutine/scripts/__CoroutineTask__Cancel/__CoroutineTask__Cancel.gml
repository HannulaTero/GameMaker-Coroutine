

/**
* Destroyes the coroutine, and calls onCancel -trigger.
* 
* @context __CoroutineTask
* @returns {Struct.__CoroutineTask}
*/ 
function __CoroutineTask__Cancel()
{
  // Can't cancel if already finished.
  if (finished == true)
  {
    return self;
  }
    
  // Trigger and remove itself.
  onCancel();
  Destroy();
  return self; 
}