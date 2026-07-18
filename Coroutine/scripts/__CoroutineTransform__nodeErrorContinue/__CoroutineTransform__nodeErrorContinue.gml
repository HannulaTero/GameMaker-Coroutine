

/**
* Don't allow using continue outside the loop.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__nodeErrorContinue()
{
  return { 
    next: function() { },
    execute: function() 
    { 
      throw("CONTINUE used outside a loop.");
    }
  };
}