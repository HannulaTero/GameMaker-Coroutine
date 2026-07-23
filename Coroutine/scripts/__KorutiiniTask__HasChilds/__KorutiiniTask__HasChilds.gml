

/**
* Returns whether has subtasks.
* 
* @context __KorutiiniTask
* @returns {Bool}
*/ 
function __KorutiiniTask__HasChilds()
{
  return (ds_map_size(childTasks) > 0);
}