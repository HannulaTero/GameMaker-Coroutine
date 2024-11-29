
#macro COROUTINE_NAME       ("Coroutines for GML")
#macro COROUTINE_CREDITS    ("Tero Hannula")
#macro COROUTINE_VERSION    ("v2024.11.29.0")


#macro COROUTINE_POOL_ACTIVE        global.gCOROUTINE_POOL_ACTIVE       // Coroutines, which are active for execution.
#macro COROUTINE_POOL_PAUSED        global.gCOROUTINE_POOL_PAUSED       // Paused coroutines, which can be resumed.
#macro COROUTINE_POOL_DELAYED       global.gCOROUTINE_POOL_DELAYED      // Temporarily paused coroutines, which will resumed.

#macro COROUTINE_CACHE_PROTOTYPES   global.gCOROUTINE_CACHE_PROTOTYPES  // Coroutine blueprints, which have already been made.
#macro COROUTINE_ASYNC_REQUESTS     global.gCOROUTINE_ASYNC_REQUESTS    // Pending async requests, maps them to each async-type separately.
#macro COROUTINE_ASYNC_LISTENERS    global.gCOROUTINE_ASYNC_LISTENERS   // Async listeners, which are just listening for specific async events.

#macro COROUTINE_CURRENT_TASK       global.gCOROUTINE_CURRENT_TASK      // Active coroutine task which is currently being executed.
#macro COROUTINE_CURRENT_EXECUTE    global.gCOROUTINE_CURRENT_EXECUTE   // Current executable callback of current coroutine.
#macro COROUTINE_CURRENT_LOCAL      global.gCOROUTINE_CURRENT_LOCAL     // Current coroutine's hidden local variables.
#macro COROUTINE_CURRENT_SCOPE      global.gCOROUTINE_CURRENT_SCOPE     // Current coroutine's variables.
#macro COROUTINE_CURRENT_YIELDED    global.gCOROUTINE_CURRENT_YIELDED   // Whether current coroutine has yielded.

#macro COROUTINE_FRAME_COUNTER      global.gCOROUTINE_FRAME_COUNTER     // For keeping up which frame currently is.
#macro COROUTINE_FRAME_TIME_BEGIN   global.gCOROUTINE_FRAME_TIME_BEGIN  // For timing how much time is spent on current frame in seconds.


#macro COROUTINE_SINGLETON  if (instance_number(object_index) > 1) { instance_destroy(); exit; } // For keeping single manager of each.
