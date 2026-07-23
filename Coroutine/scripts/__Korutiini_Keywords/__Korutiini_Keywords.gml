// feather ignore GM1051 - To ignore ending macros with semicolons. 
/*
  Macros use parenthesis to ensure correct keyword usages (force THEN ... END etc.)
  
  If some macros doesn't end with semicolon, following expansion can happen:
    keyword(...) (...)
  Second parenthesis are interpreted as function call, even though that's not intention.
  With semicolons with macros in correct places, there is no ambiguity:
    keyword(...); (...);
  
*/


// Korutiini handles.
#macro __KORUTIINI_KEYWORD__KORUTIINI         __Korutiini_Create(function() { return { graph: { }, tables: [ ], labels: { }, define: ({ option: ({


// Korutiini triggers.                        
#macro __KORUTIINI_KEYWORD__ON_INIT           }), onInit:     method(undefined, function(_params={}) {
#macro __KORUTIINI_KEYWORD__ON_YIELD          }), onYield:    method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_PAUSE          }), onPause:    method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_LAUNCH         }), onLaunch:   method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_RESUME         }), onResume:   method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_CANCEL         }), onCancel:   method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_COMPLETE       }), onComplete: method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_CLEANUP        }), onCleanup:  method(undefined, function() {
#macro __KORUTIINI_KEYWORD__ON_ERROR          }), onError:    method(undefined, function(_error) {


// Korutiini statements.                      
#macro __KORUTIINI_KEYWORD__BEGIN             })}), nodes: __KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__FINISH            }), __KorutiiniNode_FINISH() ] )}; })
#macro __KORUTIINI_KEYWORD__THEN              }), __KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__PASS              }), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__SET               }), __KorutiiniNode_SET(function() { return
#macro __KORUTIINI_KEYWORD__END               }) ])), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__DISPATCH          .Dispatch(self); 

#macro __KORUTIINI_KEYWORD__LABEL             }), __KorutiiniNode_LABEL({ label: 
#macro __KORUTIINI_KEYWORD__YIELD             }), __KorutiiniNode_YIELD(), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__PAUSE             }), __KorutiiniNode_PAUSE(), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__YIELD_SET         }), __KorutiiniNode_YIELD_SET(function() { return
#macro __KORUTIINI_KEYWORD__PAUSE_SET         }), __KorutiiniNode_PAUSE_SET(function() { return

#macro __KORUTIINI_KEYWORD__DELAY             }), __KorutiiniNode_DELAY(function() { return
#macro __KORUTIINI_KEYWORD__MICROS            }, "<MICROS>"), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__MILLIS            }, "<MILLIS>"), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__FRAMES            }, "<FRAMES>"), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__SECONDS           }, "<SECONDS>"), __KorutiiniNode_STMT(function() {

#macro __KORUTIINI_KEYWORD__AWAIT             }), __KorutiiniNode_AWAIT("COND", function() { return 
#macro __KORUTIINI_KEYWORD__AWAIT_ASYNC       }), __KorutiiniNode_AWAIT("ASYNC", function() { return 
#macro __KORUTIINI_KEYWORD__AWAIT_KORUTIINI   }), __KorutiiniNode_AWAIT("KORUTIINI", function() { return
#macro __KORUTIINI_KEYWORD__AWAIT_BROADCAST   }), __KorutiiniNode_AWAIT("BROADCAST", function() { return  // Not implemented yet.

#macro __KORUTIINI_KEYWORD__AWAIT_SUBTASKS    }), __KorutiiniNode_AWAIT_SUBTASKS(), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__AWAIT_REQUESTS    }), __KorutiiniNode_AWAIT_REQUESTS(), __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__AWAIT_LISTENERS   }), __KorutiiniNode_AWAIT_LISTENERS(), __KorutiiniNode_STMT(function() {

#macro __KORUTIINI_KEYWORD__IF                }), __KorutiiniNode_IF_CHAIN((function() { return
#macro __KORUTIINI_KEYWORD__ELIF              }) ]), (function() { return
#macro __KORUTIINI_KEYWORD__ELSE              }) ]), (__KorutiiniNode_NOP), __KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {

#macro __KORUTIINI_KEYWORD__SWITCH            }), __KorutiiniNode_SWITCH(([ (function() { return 
#macro __KORUTIINI_KEYWORD__CASE              }) ]), (function() { return
#macro __KORUTIINI_KEYWORD__DEFAULT           }) ]), (__KorutiiniNode_NOP), __KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {

#macro __KORUTIINI_KEYWORD__LOOP              }), __KorutiiniNode_LOOP(__KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__WHILE             }), __KorutiiniNode_WHILE((function() { return
#macro __KORUTIINI_KEYWORD__REPEAT            }), __KorutiiniNode_REPEAT((function() { return
#macro __KORUTIINI_KEYWORD__DO                }), __KorutiiniNode_DO(__KorutiiniNode_BLOCK([ __KorutiiniNode_STMT(function() {
#macro __KORUTIINI_KEYWORD__UNTIL             }) ]), ([ (function() { return

#macro __KORUTIINI_KEYWORD__FOR               }), __KorutiiniNode_FOR((function() { 
#macro __KORUTIINI_KEYWORD__COND              }), (function() { return
#macro __KORUTIINI_KEYWORD__ITER              }), (function() {
                                              
#macro __KORUTIINI_KEYWORD__FOREACH           }), __KorutiiniNode_FOREACH((function(key="KEY", value="VAL") { return {
#macro __KORUTIINI_KEYWORD__IN                }; }), (function() { return 
#macro __KORUTIINI_KEYWORD__RANGE             new __KorutiiniRange
#macro __KORUTIINI_KEYWORD__VIEW              new __KorutiiniView


// Runtime evaluated statements.   
// -> These allow placing inside regular GML statements.
#macro __KORUTIINI_KEYWORD__RESTART           return __KorutiiniNode_RUNTIME_RESTART()
#macro __KORUTIINI_KEYWORD__CONTINUE          return __KorutiiniNode_RUNTIME_CONTINUE()
#macro __KORUTIINI_KEYWORD__BREAK             return __KorutiiniNode_RUNTIME_BREAK()
#macro __KORUTIINI_KEYWORD__EXIT              return __KorutiiniNode_RUNTIME_RETURN(undefined)
#macro __KORUTIINI_KEYWORD__CANCEL            return __KorutiiniNode_RUNTIME_CANCEL()
#macro __KORUTIINI_KEYWORD__RETURN            for(var ____;; { return __KorutiiniNode_RUNTIME_RETURN(____); }) ____ =
#macro __KORUTIINI_KEYWORD__GOTO              for(var ____;; { return __KorutiiniNode_RUNTIME_GOTO(____); }) ____ =
#macro __KORUTIINI_KEYWORD__PRINT             for(var ____;; { show_debug_message(____); break; }) ____ =


// Runtime async request, and its triggers.   
#macro __KORUTIINI_KEYWORD__ASYNC_REQUEST     (new __KorutiiniAsyncRequest({ option: (({
#macro __KORUTIINI_KEYWORD__ASYNC_LISTENER    (new __KorutiiniAsyncListener({ option: (({
#macro __KORUTIINI_KEYWORD__DO_REQUEST        })), onRequest: ((function(_async) {
#macro __KORUTIINI_KEYWORD__ON_PENDING        })), onPending: ((function(_async) {
#macro __KORUTIINI_KEYWORD__ON_SUCCESS        })), onSuccess: ((function(_async) {
#macro __KORUTIINI_KEYWORD__ON_FAILURE        })), onFailure: ((function(_async) {
#macro __KORUTIINI_KEYWORD__ON_TIMEOUT        })), onTimeout: ((function(_async) {
#macro __KORUTIINI_KEYWORD__ON_LISTEN         })), onListen:  ((function(_async) {
#macro __KORUTIINI_KEYWORD__ASYNC_END         })) }));

