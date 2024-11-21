
#macro COROUTINE_NAME       ("Coroutine for GML")
#macro COROUTINE_CREDITS    ("Tero Hannula")
#macro COROUTINE_VERSION    ("v2024.11.21.0")


#macro COROUTINE_LIST_ACTIVE        global.gCOROUTINE_LIST_ACTIVE       // Coroutines, which are active for execution.
#macro COROUTINE_LIST_PAUSED        global.gCOROUTINE_LIST_PAUSED       // Paused coroutines, whichc can be resumed.
#macro COROUTINE_CACHE_PROTOTYPES   global.gCOROUTINE_CACHE_PROTOTYPES  // Coroutine blueprints, which have already been made.
#macro COROUTINE_ASYNC_REQUESTS     global.gCOROUTINE_ASYNC_REQUESTS    // Pending async requests, maps them to each async-type separately.
#macro COROUTINE_ASYNC_LISTENERS    global.gCOROUTINE_ASYNC_LISTENERS   // Async listeners, which are just listening for specific async events.

#macro COROUTINE_CURRENT            global.gCOROUTINE_CURRENT           // Coroutine instance which is currently being executed.
#macro COROUTINE_EXECUTE            global.gCOROUTINE_EXECUTE           // Current executable callback of current coroutine.
#macro COROUTINE_RESULT             global.gCOROUTINE_RESULT            // Current result of execution.
#macro COROUTINE_LOCAL              global.gCOROUTINE_LOCAL             // Current coroutine's hidden local variables.
#macro COROUTINE_SCOPE              global.gCOROUTINE_SCOPE             // Current coroutine's variables.
#macro COROUTINE_YIELD              global.gCOROUTINE_YIELD             // Whether current coroutine should yield.
#macro COROUTINE_INDEX              global.gCOROUTINE_INDEX             // Index of current coroutine.

#macro COROUTINE_FRAME_TIME_BEGIN   global.gCOROUTINE_FRAME_TIME_BEGIN  // For timing how much time is spent on current frame.


#macro COROUTINE_SINGLETON  if (instance_number(object_index) > 1) { instance_destroy(); exit; } // For keeping single manager of each.
