

/**
* Returns dummy final node.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__nodeFinal()
{
  return {
    next: function() { },
    execute: function() 
    { 
      /* Dummy. */ 
    }
  };
}