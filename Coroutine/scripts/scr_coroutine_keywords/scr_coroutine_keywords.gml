// feather ignore GM1051
// feather ignore GM2023


#macro COROUTINE        coroutine_create(function() { return { graph: {}, tables: [], labels: {}, define: ({ option: ({


// Coroutine triggers.
#macro ON_INIT          }), onInit: method(undefined, function(_params={}) {
#macro ON_YIELD         }), onYield: method(undefined, function() {
#macro ON_PAUSE         }), onPause: method(undefined, function() {
#macro ON_LAUNCH        }), onLaunch: method(undefined, function() {
#macro ON_RESUME        }), onResume: method(undefined, function() {
#macro ON_CANCEL        }), onCancel: method(undefined, function() {
#macro ON_COMPLETE      }), onComplete: method(undefined, function() {
#macro ON_CLEANUP       }), onCleanup: method(undefined, function() {
#macro ON_ERROR         }), onError: method(undefined, function(_error) {


// Coroutine statements.
#macro BEGIN            })}), nodes: CO_BLOCK([CO_STMT(function() {
#macro FINISH           }), CO_FINISH()] )}; })
#macro THEN             }), CO_BLOCK([CO_STMT(function() {
#macro PASS             }), CO_STMT(function() {
#macro SET              }), CO_SET(function() { return
#macro END              })])), CO_STMT(function() {
#macro DISPATCH         .Dispatch(self);

#macro LABEL            }), CO_LABEL({ label: 
#macro YIELD            }), CO_YIELD(), CO_STMT(function() {
#macro PAUSE            }), CO_PAUSE(), CO_STMT(function() {
#macro YIELD_SET        }), CO_YIELD_WITH(function() { return
#macro PAUSE_SET        }), CO_PAUSE_WITH(function() { return
  
#macro DELAY            }), CO_DELAY(function() { return
#macro MICROS           }, "MICROS"), CO_STMT(function() {
#macro MILLIS           }, "MILLIS"), CO_STMT(function() {
#macro FRAMES           }, "FRAMES"), CO_STMT(function() {
#macro SECONDS          }, "SECONDS"), CO_STMT(function() {

#macro AWAIT            }), CO_AWAIT("COND", function() { return 
#macro AWAIT_ASYNC      }), CO_AWAIT("ASYNC", function() { return 
#macro AWAIT_COROUTINE  }), CO_AWAIT("COROUTINE", function() { return
#macro AWAIT_BROADCAST  }), CO_AWAIT("BROADCAST", function() { return  // Not implemented yet.
  
#macro AWAIT_SUBTASKS   }), CO_AWAIT_SUBTASKS(), CO_STMT(function() {
#macro AWAIT_REQUESTS   }), CO_AWAIT_REQUESTS(), CO_STMT(function() {
#macro AWAIT_LISTENERS  }), CO_AWAIT_LISTENERS(), CO_STMT(function() {

#macro IF               }), CO_IF_CHAIN((function() { return
#macro ELIF             })]), (function() { return
#macro ELSE             })]), (CO_NOP), CO_BLOCK([CO_STMT(function() {
  
#macro SWITCH           }), CO_SWITCH(([(function() { return 
#macro CASE             })]), (function() { return
#macro DEFAULT          })]), (CO_NOP), CO_BLOCK([CO_STMT(function() {

#macro LOOP             }), CO_LOOP(CO_BLOCK([CO_STMT(function() {
#macro WHILE            }), CO_WHILE((function() { return
#macro REPEAT           }), CO_REPEAT((function() { return
#macro DO               }), CO_DO(CO_BLOCK([CO_STMT(function() {
#macro UNTIL            })]), ([(function() { return
  
#macro FOR              }), CO_FOR((function() { 
#macro COND             }), (function() { return
#macro ITER             }), (function() {

#macro FOREACH          }), CO_FOREACH((function(key="KEY", value="VAL") { return {
#macro IN               }; }), (function() { return 
#macro RANGE            new CoroutineRange
#macro VIEW             new CoroutineView


// Runtime evaluated statements.
#macro RESTART          return CO_RUNTIME_RESTART()
#macro CONTINUE         return CO_RUNTIME_CONTINUE()
#macro BREAK            return CO_RUNTIME_BREAK()
#macro EXIT             return CO_RUNTIME_RETURN(undefined)
#macro CANCEL           return CO_RUNTIME_CANCEL()
#macro RETURN           for(var ____;; { return CO_RUNTIME_RETURN(____); }) ____ =
#macro GOTO             for(var ____;; { return CO_RUNTIME_GOTO(____); }) ____ =
#macro PRINT            for(var ____;; { show_debug_message(____); break; }) ____ =


// Runtime async request, and its triggers.
#macro ASYNC_REQUEST    (new CoroutineAsyncRequest({ option: (({
#macro ASYNC_LISTENER   (new CoroutineAsyncListener({ option: (({
#macro DO_REQUEST       })), onRequest: ((function(_async) {
#macro ON_PENDING       })), onPending: ((function(_async) {
#macro ON_SUCCESS       })), onSuccess: ((function(_async) {
#macro ON_FAILURE       })), onFailure: ((function(_async) {
#macro ON_TIMEOUT       })), onTimeout: ((function(_async) {
#macro ON_LISTEN        })), onListen: ((function(_async) {
#macro ASYNC_END        }))})); 







