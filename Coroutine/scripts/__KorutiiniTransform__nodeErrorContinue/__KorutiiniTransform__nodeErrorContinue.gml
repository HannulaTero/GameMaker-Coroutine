

/**
* Don't allow using continue outside the loop.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__nodeErrorContinue()
{
  return { 
    next: function() { },
    execute: function() 
    { 
      throw("CONTINUE used outside a loop.");
    }
  };
}