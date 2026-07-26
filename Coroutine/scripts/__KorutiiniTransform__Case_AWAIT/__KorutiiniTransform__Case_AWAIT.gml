

/**
* Pauses execution until given condition is met.
* Usual condition is boolean value, but it can be several other types.
* -> After initial check, jumps into correct path for later checks.
* 
* @context __KorutiiniTransform
*/ 
function __KorutiiniTransform__Case_AWAIT(_node, _next, _break, _continue)
{
  // TODO
  
  // // The first case checks what type 
  // var _firstCase = {
  //   next : _next.execute,
  //   call : _node.call,
  //   jump : {
  //     
  //   },
  //   execute : function()
  //   {
  //     var _cond = __Korutiini_Execute(call);
  //     var _jump = undefined;
  //     
  //     
  //     switch(typeof(_cond))
  //     {
  //       case "bool": case "number": 
  //       case "int32": case "int64": {
  //         _jump = jump.bool;
  //         break;
  //       }
  //       case "struct": {
  //         if (is_instanceof(_cond, __KorutiiniTask) == true)
  //         || (is_instanceof(_cond, __KorutiiniAsyncRequest) == true)
  //         {
  //           _jump = jump.coroutine;
  //         }
  //         break;
  //       }
  //     }
  //     
  //     // Check whether found valid case.
  //     if (_jump == undefined) 
  //     {
  //       throw($"[Korutiini] Unresolvable AWAIT -case: '{typeof(_cond)}'.");
  //       return; 
  //     }
  //     
  //     
  //   }
  // };
  // 
  // 
  // return {
  //   next: _next.execute,
  //   call: _node.call,
  //   execute: function()
  //   {
  //     if (__Korutiini_Execute(call))
  //     {
  //       KORUTIINI_CURRENT_EXECUTE = next;
  //       return;
  //     }
  //     KORUTIINI_CURRENT_EXECUTE = execute;
  //     KORUTIINI_CURRENT_YIELDED = true;
  //   }
  // };
}