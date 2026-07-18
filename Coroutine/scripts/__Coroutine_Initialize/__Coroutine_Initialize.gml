

// Initialize globals.
COROUTINE_POOL_ACTIVE       = ds_map_create();
COROUTINE_POOL_PAUSED       = ds_map_create();
COROUTINE_POOL_DELAYED      = ds_map_create();

COROUTINE_CACHE_PROTOTYPES  = ds_map_create();
COROUTINE_ASYNC_REQUESTS    = ds_map_create();
COROUTINE_ASYNC_LISTENERS   = ds_map_create();

COROUTINE_CURRENT_TASK      = undefined;
COROUTINE_CURRENT_EXECUTE   = undefined;
COROUTINE_CURRENT_LOCAL     = undefined;
COROUTINE_CURRENT_SCOPE     = undefined;
COROUTINE_CURRENT_YIELDED   = false;

COROUTINE_FRAME_COUNTER     = 0;
COROUTINE_FRAME_TIME_BEGIN  = 0;


// Initialize async listeners for reach event types.
array_foreach([
  ev_async_web_image_load,
  ev_async_web,
  ev_async_dialog,
  ev_async_web_iap,
  ev_async_web_cloud,
  ev_async_web_networking,
  ev_async_web_steam,
  ev_async_social,
  ev_async_push_notification,
  ev_async_save_load,
  ev_async_audio_recording,
  ev_async_audio_playback,
  ev_async_audio_playback_ended,
  ev_async_system_event,
  ev_broadcast_message,
], function(_type, i) 
{
  COROUTINE_ASYNC_LISTENERS[? _type] = ds_map_create();
});

