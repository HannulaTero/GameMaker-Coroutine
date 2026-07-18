

/**
* Returns dummy final node.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__nodeFinal()
{
  return {
    next: function() { },
    execute: function() 
    { 
      /* Dummy. */ 
    }
  };
}