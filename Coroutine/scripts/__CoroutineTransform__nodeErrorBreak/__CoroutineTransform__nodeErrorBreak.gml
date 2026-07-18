

/**
* Don't allow breaking outside the loop.
* 
* @context __CoroutineTransform
*/ 
function __CoroutineTransform__nodeErrorBreak()
{
  return { 
    next: function() { },
    execute: function() 
    { 
      throw("BREAK used outside a loop.");
    }
  };
}