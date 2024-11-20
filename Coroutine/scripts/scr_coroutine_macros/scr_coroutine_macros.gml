
#macro COROUTINE_NAME       ("Coroutine for GML")
#macro COROUTINE_CREDIT     ("by Tero Hannula")
#macro COROUTINE_VERSION    ("v2024.11.18.0")

#macro __COROUTINE_SINGLETON  if (instance_number(object_index) > 1) { instance_destroy(); exit; }

#macro __COROUTINE_MANAGER    global.__gCOROUTINE_MANAGER
#macro __COROUTINE_ACTIVE     global.__gCOROUTINE_ACTIVE
#macro __COROUTINE_PAUSED     global.__gCOROUTINE_PAUSED
#macro __COROUTINE_CURRENT    global.__gCOROUTINE_CURRENT
#macro __COROUTINE_CACHE      global.__gCOROUTINE_CACHE

#macro __COROUTINE_FLAG_EXECUTING     global.__gCOROUTINE_FLAG_EXECUTING
#macro __COROUTINE_FRAME_TIME_BEGIN   global.__gCOROUTINE_FRAME_TIME_BEGIN

#macro __COROUTINE_ASYNC_REQUESTS     global.__gCOROUTINE_ASYNC_REQUESTS

#macro __COROUTINE_DEBUG_PRINT        if (false) {} else show_debug_message