

/**
* Returns whether has subtasks.
* 
* @context __CoroutineTask
* @returns {Bool}
*/ 
function __CoroutineTask__HasChilds()
{
  return (ds_map_size(childTasks) > 0);
}