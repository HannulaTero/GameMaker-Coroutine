

/**
* Don't allow breaking outside the loop.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__nodeErrorBreak()
{
  return { 
    next: function() { },
    execute: function() 
    { 
      throw("BREAK used outside a loop.");
    }
  };
}