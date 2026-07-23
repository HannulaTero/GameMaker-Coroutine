

/**
* Destroyes the coroutine, and calls onCancel -trigger.
* 
* @context __KorutiiniTask
* @returns {Struct.__KorutiiniTask}
*/ 
function __KorutiiniTask__Cancel()
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