
/*
#macro COROUTINE        coroutine_create(function() { return { define: ({ option: ({

#macro ON_INIT          }), onInit: method(undefined, function() {
#macro ON_YIELD         }), onYield: method(undefined, function() {
#macro ON_PAUSE         }), onPause: method(undefined, function() {
#macro ON_CANCEL        }), onCancel: method(undefined, function() {
#macro ON_RESUME        }), onResume: method(undefined, function() {
#macro ON_LAUNCH        }), onLaunch: method(undefined, function() {
#macro ON_COMPLETE      }), onComplete: method(undefined, function() {
#macro ON_ERROR         }), onError: method(undefined, function(error) {

#macro BEGIN            })}), code: [], label: {}, nodes: ["BLOCK", ["STMT", function() {
#macro FINISH           }], ["FINISH"]] }; })
#macro THEN             }], ["BLOCK", ["STMT", function() {
#macro PASS             }], ["STMT", function() {
#macro END              }]]], ["STMT", function() {
#macro DISPATCH         .Dispatch(self)

#macro LABEL            }], ["LABEL", { label: 
#macro YIELD            }], ["YIELD", function() { return 
#macro PAUSE            }], ["PAUSE", function() { return 
#macro DELAY            }], ["DELAY", function() { return 
  
#macro TIMEOUT          }], ["TIMEOUT", function() { return 
#macro MICROS           }, "MICROS"], ["STMT", function() {
#macro MILLIS           }, "MILLIS"], ["STMT", function() {
#macro FRAMES           }, "FRAMES"], ["STMT", function() {
#macro SECONDS          }, "SECONDS"], ["STMT", function() {

#macro AWAIT            }], ["AWAIT", function() { return 
#macro AWAIT_ASYNC      }], ["AWAIT_ASYNC", function() { return 
#macro AWAIT_BROADCAST  }], ["AWAIT_BROADCAST", function() { return 
#macro AWAIT_COROUTINE  }], ["AWAIT_COROUTINE", function() { return 
#macro AWAIT_CHILDRENS  }], ["AWAIT_CHILDRENS"], ["STMT", function() { 
#macro ASYNC            }], ["ASYNC", ((function() { return

#macro IF               }], ["IF", ["COND", function() { return
#macro WHEN             }], ["IF", ["COND", function() { return
#macro ELSE             }]], ["ELSE"], ["BLOCK", ["STMT", function() {
#macro ELIF             }]], ["ELIF", function() { return

#macro FOR              }], ["FOR", ["INIT", function() { 
#macro LOOP             }], ["FOR", ["INIT", function() {
#macro INIT             }], ["INIT", function() { 
#macro COND             }], ["COND", function() { return
#macro ITER             }], ["ITER", function() {

#macro WHILE            }], ["WHILE", ["COND", function() { return
#macro REPEAT           }], ["REPEAT", ["ITER", function() { return
#macro FOREACH          }], ["FOREACH", ["INIT", function(key="KEY", value="VAL") { return {
#macro IN               }; }], ["ITEM", function() { return 
  
#macro RESTART    return CO_RUNTIME_RESTART()
#macro CONTINUE   return CO_RUNTIME_CONTINUE()
#macro BREAK      return CO_RUNTIME_BREAK()
#macro CANCEL     return CO_RUNTIME_CANCEL()
#macro QUIT       return CO_RUNTIME_RETURN(undefined) 
#macro RETURN     for(var __;; { return CO_RUNTIME_RETURN(__); }) __ =
#macro GOTO       for(var __;; { return CO_RUNTIME_GOTO(__); }) __ =


