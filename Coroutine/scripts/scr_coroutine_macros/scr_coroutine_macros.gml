
#macro COROUTINE_NAME       ("Coroutine for GML")
#macro COROUTINE_CREDIT     ("by Tero Hannula")
#macro COROUTINE_VERSION    ("v2024.11.20.0")

#macro COROUTINE_SINGLETON  if (instance_number(object_index) > 1) { instance_destroy(); exit; }

#macro COROUTINE_LIST_ACTIVE  global.gCOROUTINE_LIST_ACTIVE
#macro COROUTINE_LIST_PAUSED  global.gCOROUTINE_LIST_PAUSED
#macro COROUTINE_HASH_CACHE   global.gCOROUTINE_HASH_CACHE
#macro COROUTINE_HASH_ASYNC   global.gCOROUTINE_HASH_ASYNC

#macro COROUTINE_CURRENT      global.gCOROUTINE_CURRENT
#macro COROUTINE_EXECUTE      global.gCOROUTINE_EXECUTE
#macro COROUTINE_RESULT       global.gCOROUTINE_RESULT
#macro COROUTINE_LOCAL        global.gCOROUTINE_LOCAL
#macro COROUTINE_SCOPE        global.gCOROUTINE_SCOPE
#macro COROUTINE_YIELD        global.gCOROUTINE_YIELD

#macro COROUTINE_FRAME_TIME_BEGIN   global.gCOROUTINE_FRAME_TIME_BEGIN
