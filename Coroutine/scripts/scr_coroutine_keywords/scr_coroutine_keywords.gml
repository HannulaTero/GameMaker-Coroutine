

#macro COROUTINE        coroutine_create(function() { return { define: ({ options: ({

#macro ON_INIT          }), onInit: method(undefined, function() {
#macro ON_YIELD         }), onYield: method(undefined, function() {
#macro ON_PAUSE         }), onPause: method(undefined, function() {
#macro ON_CANCEL        }), onCancel: method(undefined, function() {
#macro ON_RESUME        }), onResume: method(undefined, function() {
#macro ON_LAUNCH        }), onLaunch: method(undefined, function() {
#macro ON_COMPLETE      }), onComplete: method(undefined, function() {
#macro ON_ERROR         }), onError: method(undefined, function(_error) {

#macro BEGIN            })}), code: [], labels: {}, nodes: CO_THEN([CO_PASS(function() {
#macro FINISH           }), CO_FINISH()] )}; })
#macro THEN             }), CO_THEN([CO_PASS(function() {
#macro PASS             }), CO_PASS(function() {
#macro END              })])), CO_PASS(function() {
#macro DISPATCH         .Dispatch()

#macro LABEL            }), CO_LABEL({ label: 
#macro YIELD            }), CO_YIELD(function() { return 
#macro PAUSE            }), CO_PAUSE(function() { return 
#macro DELAY            }), CO_DELAY(function() { return 
  
#macro TIMEOUT          }), CO_TIMEOUT(function() { return 
#macro MICROS           }, "MICROS"), CO_PASS(function() {
#macro MILLIS           }, "MILLIS"), CO_PASS(function() {
#macro FRAMES           }, "FRAMES"), CO_PASS(function() {
#macro SECONDS          }, "SECONDS"), CO_PASS(function() {

#macro AWAIT            }), CO_AWAIT("COND", function() { return 
#macro AWAIT_ASYNC      }), CO_AWAIT("ASYNC", function() { return 
#macro AWAIT_BROADCAST  }), CO_AWAIT("BROADCAST", function() { return 
#macro AWAIT_COROUTINE  }), CO_AWAIT("COROUTINE", function() { return 
#macro ASYNC            }), CO_ASYNC((function() { return

#macro IF               }), CO_IF_CHAIN((function() { return
#macro WHEN             }), CO_IF_CHAIN((function() { return
#macro ELIF             })]), (function() { return
#macro ELSE             })]), (CO_NOP), CO_THEN([CO_PASS(function() {

#macro FOR              }), CO_FOR((function() { 
#macro LOOP             }), CO_FOR((function() {
#macro INIT             }), "INIT", (function() { 
#macro COND             }), "COND", (function() { return
#macro ITER             }), "ITER", (function() {

#macro WHILE            }), CO_WHILE((function() { return
#macro REPEAT           }), CO_REPEAT((function() { return
#macro FOREACH          }), CO_FOREACH((function(key="KEY", value="VAL") { return {
#macro IN               }; }), (function() { return 
  
#macro RESTART    return CO_RUNTIME_RESTART()
#macro CONTINUE   return CO_RUNTIME_CONTINUE()
#macro BREAK      return CO_RUNTIME_BREAK()
#macro CANCEL     return CO_RUNTIME_CANCEL()
#macro QUIT       return CO_RUNTIME_QUIT()
#macro RETURN     for(var __;; { return CO_RUNTIME_RETURN(__); }) __ =
#macro GOTO       for(var __;; { return CO_RUNTIME_GOTO(__); }) __ =



