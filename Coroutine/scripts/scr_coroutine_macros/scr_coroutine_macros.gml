
#macro COROUTINE_VERSION    ("v2024.11.17.0")

#macro COROUTINE_MANAGER    global.gCOROUTINE_MANAGER
#macro COROUTINE_ACTIVE     global.gCOROUTINE_ACTIVE
#macro COROUTINE_PAUSED     global.gCOROUTINE_PAUSED
#macro COROUTINE_CACHE      global.gCOROUTINE_CACHE

#macro COROUTINE_FRAME_TIME_BEGIN   global.gCOROUTINE_FRAME_TIME_BEGIN

#macro COROUTINE_SINGLETON  if (instance_number(object_index) > 1) { instance_destroy(); exit; }
