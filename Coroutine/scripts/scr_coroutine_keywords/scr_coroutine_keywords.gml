

#macro COROUTINE        coroutine_create(function() { return { define: ({ option: ({

// Coroutine triggers.
#macro ON_INIT          }), onInit: method(undefined, function() {
#macro ON_YIELD         }), onYield: method(undefined, function() {
#macro ON_PAUSE         }), onPause: method(undefined, function() {
#macro ON_CANCEL        }), onCancel: method(undefined, function() {
#macro ON_RESUME        }), onResume: method(undefined, function() {
#macro ON_LAUNCH        }), onLaunch: method(undefined, function() {
#macro ON_COMPLETE      }), onComplete: method(undefined, function() {
#macro ON_ERROR         }), onError: method(undefined, function(error) {


// Coroutine statements.
#macro BEGIN            })}), graph: {}, tables: [], labels: {}, nodes: CO_BLOCK([CO_STMT(function() {
#macro FINISH           }), CO_FINISH()] )}; })
#macro THEN             }), CO_BLOCK([CO_STMT(function() {
#macro PASS             }), CO_STMT(function() {
#macro END              })])), CO_STMT(function() {
#macro DISPATCH         .Dispatch(self)

#macro LABEL            }), CO_LABEL({ label: 
#macro YIELD            }), CO_YIELD(function() { return 
#macro PAUSE            }), CO_PAUSE(function() { return 
#macro DELAY            }), CO_DELAY(function() { return 
  
#macro TIMEOUT          }), CO_TIMEOUT(function() { return 
#macro MICROS           }, "MICROS"), CO_STMT(function() {
#macro MILLIS           }, "MILLIS"), CO_STMT(function() {
#macro FRAMES           }, "FRAMES"), CO_STMT(function() {
#macro SECONDS          }, "SECONDS"), CO_STMT(function() {

#macro AWAIT            }), CO_AWAIT("COND", function() { return 
#macro AWAIT_ASYNC      }), CO_AWAIT("ASYNC", function() { return 
#macro AWAIT_BROADCAST  }), CO_AWAIT("BROADCAST", function() { return 
#macro AWAIT_COROUTINE  }), CO_AWAIT("COROUTINE", function() { return 
#macro AWAIT_CHILDRENS  }), CO_AWAIT_CHILDRENS(), CO_STMT(function() { return 
#macro ASYNC            }), CO_ASYNC((function() { return

#macro IF               }), CO_IF_CHAIN((function() { return
#macro WHEN             }), CO_IF_CHAIN((function() { return
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


// Runtime control flow statements.
#macro RESTART          return CO_RUNTIME_RESTART()
#macro CONTINUE         return CO_RUNTIME_CONTINUE()
#macro BREAK            return CO_RUNTIME_BREAK()
#macro QUIT             return CO_RUNTIME_RETURN(undefined) 
#macro CANCEL           return CO_RUNTIME_CANCEL() 
#macro RETURN           for(var ____;; { return CO_RUNTIME_RETURN(____); }) ____ =
#macro GOTO             for(var ____;; { return CO_RUNTIME_GOTO(____); }) ____ =


// Runtime async request, and its triggers.
#macro ASYNC_BEGIN      ((new CoroutineAsync({
#macro GET_REQUEST      })).SetRequest((function() {
#macro ON_WAITING       })).SetWaiting((function() {
#macro ON_SUCCESS       })).SetSuccess((function() {
#macro ON_FAILURE       })).SetFailure((function() {
#macro ON_TIMEOUT       })).SetTimeout((function() {
#macro ON_LISTEN        })).SetListen((function() {
#macro ASYNC_END        })).AsyncDispatch())



