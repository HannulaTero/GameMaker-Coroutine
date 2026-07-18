// feather ignore GM1051 - To ignore ending macros with semicolons. 
/*
  Macros use parenthesis to ensure correct keyword usages (force THEN ... END etc.)
  
  If some macros doesn't end with semicolon, following expansion can happen:
    keyword(...) (...)
  Second parenthesis are interpreted as function call, even though that's not intention.
  With semicolons with macros in correct places, there is no ambiguity:
    keyword(...); (...);
  
*/


#macro __COROUTINE_KEYWORD__COROUTINE         __Coroutine_Create(function() { return { graph: { }, tables: [ ], labels: { }, define: ({ option: ({


// Coroutine triggers.                        
#macro __COROUTINE_KEYWORD__ON_INIT           }), onInit:     method(undefined, function(_params={}) {
#macro __COROUTINE_KEYWORD__ON_YIELD          }), onYield:    method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_PAUSE          }), onPause:    method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_LAUNCH         }), onLaunch:   method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_RESUME         }), onResume:   method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_CANCEL         }), onCancel:   method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_COMPLETE       }), onComplete: method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_CLEANUP        }), onCleanup:  method(undefined, function() {
#macro __COROUTINE_KEYWORD__ON_ERROR          }), onError:    method(undefined, function(_error) {


// Coroutine statements.                      
#macro __COROUTINE_KEYWORD__BEGIN             })}), nodes: __CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__FINISH            }), __CoroutineNode_FINISH() ] )}; })
#macro __COROUTINE_KEYWORD__THEN              }), __CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__PASS              }), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__SET               }), __CoroutineNode_SET(function() { return
#macro __COROUTINE_KEYWORD__END               }) ])), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__DISPATCH          .Dispatch(self); 

#macro __COROUTINE_KEYWORD__LABEL             }), __CoroutineNode_LABEL({ label: 
#macro __COROUTINE_KEYWORD__YIELD             }), __CoroutineNode_YIELD(), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__PAUSE             }), __CoroutineNode_PAUSE(), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__YIELD_SET         }), __CoroutineNode_YIELD_WITH(function() { return
#macro __COROUTINE_KEYWORD__PAUSE_SET         }), __CoroutineNode_PAUSE_WITH(function() { return

#macro __COROUTINE_KEYWORD__DELAY             }), __CoroutineNode_DELAY(function() { return
#macro __COROUTINE_KEYWORD__MICROS            }, "<MICROS>"), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__MILLIS            }, "<MILLIS>"), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__FRAMES            }, "<FRAMES>"), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__SECONDS           }, "<SECONDS>"), __CoroutineNode_STMT(function() {

#macro __COROUTINE_KEYWORD__AWAIT             }), __CoroutineNode_AWAIT("COND", function() { return 
#macro __COROUTINE_KEYWORD__AWAIT_ASYNC       }), __CoroutineNode_AWAIT("ASYNC", function() { return 
#macro __COROUTINE_KEYWORD__AWAIT_COROUTINE   }), __CoroutineNode_AWAIT("COROUTINE", function() { return
#macro __COROUTINE_KEYWORD__AWAIT_BROADCAST   }), __CoroutineNode_AWAIT("BROADCAST", function() { return  // Not implemented yet.

#macro __COROUTINE_KEYWORD__AWAIT_SUBTASKS    }), __CoroutineNode_AWAIT_SUBTASKS(), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__AWAIT_REQUESTS    }), __CoroutineNode_AWAIT_REQUESTS(), __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__AWAIT_LISTENERS   }), __CoroutineNode_AWAIT_LISTENERS(), __CoroutineNode_STMT(function() {

#macro __COROUTINE_KEYWORD__IF                }), __CoroutineNode_IF_CHAIN((function() { return
#macro __COROUTINE_KEYWORD__ELIF              }) ]), (function() { return
#macro __COROUTINE_KEYWORD__ELSE              }) ]), (__CoroutineNode_NOP), __CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {

#macro __COROUTINE_KEYWORD__SWITCH            }), __CoroutineNode_SWITCH(([ (function() { return 
#macro __COROUTINE_KEYWORD__CASE              }) ]), (function() { return
#macro __COROUTINE_KEYWORD__DEFAULT           }) ]), (__CoroutineNode_NOP), __CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {

#macro __COROUTINE_KEYWORD__LOOP              }), __CoroutineNode_LOOP(__CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__WHILE             }), __CoroutineNode_WHILE((function() { return
#macro __COROUTINE_KEYWORD__REPEAT            }), __CoroutineNode_REPEAT((function() { return
#macro __COROUTINE_KEYWORD__DO                }), __CoroutineNode_DO(__CoroutineNode_BLOCK([ __CoroutineNode_STMT(function() {
#macro __COROUTINE_KEYWORD__UNTIL             }) ]), ([ (function() { return

#macro __COROUTINE_KEYWORD__FOR               }), __CoroutineNode_FOR((function() { 
#macro __COROUTINE_KEYWORD__COND              }), (function() { return
#macro __COROUTINE_KEYWORD__ITER              }), (function() {
                                              
#macro __COROUTINE_KEYWORD__FOREACH           }), __CoroutineNode_FOREACH((function(key="KEY", value="VAL") { return {
#macro __COROUTINE_KEYWORD__IN                }; }), (function() { return 
#macro __COROUTINE_KEYWORD__RANGE             new __CoroutineRange
#macro __COROUTINE_KEYWORD__VIEW              new __CoroutineView


// Runtime evaluated statements.              
#macro __COROUTINE_KEYWORD__RESTART           return __CoroutineNode_RUNTIME_RESTART()
#macro __COROUTINE_KEYWORD__CONTINUE          return __CoroutineNode_RUNTIME_CONTINUE()
#macro __COROUTINE_KEYWORD__BREAK             return __CoroutineNode_RUNTIME_BREAK()
#macro __COROUTINE_KEYWORD__EXIT              return __CoroutineNode_RUNTIME_RETURN(undefined)
#macro __COROUTINE_KEYWORD__CANCEL            return __CoroutineNode_RUNTIME_CANCEL()
#macro __COROUTINE_KEYWORD__RETURN            for(var ____;; { return __CoroutineNode_RUNTIME_RETURN(____); }) ____ =
#macro __COROUTINE_KEYWORD__GOTO              for(var ____;; { return __CoroutineNode_RUNTIME_GOTO(____); }) ____ =
#macro __COROUTINE_KEYWORD__PRINT             for(var ____;; { show_debug_message(____); break; }) ____ =


// Runtime async request, and its triggers.   
#macro __COROUTINE_KEYWORD__ASYNC_REQUEST     (new __CoroutineAsyncRequest({ option: (({
#macro __COROUTINE_KEYWORD__ASYNC_LISTENER    (new __CoroutineAsyncListener({ option: (({
#macro __COROUTINE_KEYWORD__DO_REQUEST        })), onRequest: ((function(_async) {
#macro __COROUTINE_KEYWORD__ON_PENDING        })), onPending: ((function(_async) {
#macro __COROUTINE_KEYWORD__ON_SUCCESS        })), onSuccess: ((function(_async) {
#macro __COROUTINE_KEYWORD__ON_FAILURE        })), onFailure: ((function(_async) {
#macro __COROUTINE_KEYWORD__ON_TIMEOUT        })), onTimeout: ((function(_async) {
#macro __COROUTINE_KEYWORD__ON_LISTEN         })), onListen:  ((function(_async) {
#macro __COROUTINE_KEYWORD__ASYNC_END         })) }));

