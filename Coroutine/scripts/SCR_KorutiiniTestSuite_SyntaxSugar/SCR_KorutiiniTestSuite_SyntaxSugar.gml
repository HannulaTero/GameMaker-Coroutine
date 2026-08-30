

/**
* 
*/ 
function KorutiiniTestSuite_SyntaxSugar()
{
  var _coroutine = ko_rutiini(_x, _y)
  {
    ko_onLaunch {
      show_debug_message("Launched!");
    }
    
    var _variable = "Hello world!";
    
    if (true) { }
    if (true) { } else { }
    if (true) { } else if (true) { }
    if (true) { } else if (true) { } else { }
    
    for(;;) { }
  }
}