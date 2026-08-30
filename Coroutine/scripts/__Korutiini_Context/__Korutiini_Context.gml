

/**
* Returns map of dispatchable coroutine prototypes.
*/ 
function __KorutiiniRuntime_CachePrototypes()
{
  static context = ds_map_create();
  return context;
}



/**
* Pool of coroutine tasks, which are active for execution.
*/ 
function __KorutiiniRuntime_PoolActive()
{
  static context = ds_map_create();
  return context;
}



/**
* Pool of coroutine tasks, which are paused and can be resumed.
*/ 
function __KorutiiniRuntime_PoolPaused()
{
  static context = ds_map_create();
  return context;
}



/**
* Pool of coroutine tasks, which are temporarily paused for given time.
*/ 
function __KorutiiniRuntime_PoolDelayed()
{
  static context = ds_map_create();
  return context;
}



/**
* Pools of current async requests.
*/ 
function __KorutiiniRuntime_AsyncRequests()
{
  static context = ds_map_create();
  return context;
}



/**
* Pools of current async listeners for each async-eent.
* Map contains map for each async-event type.
* Event-specific maps contains related listeners.
*/ 
function __KorutiiniRuntime_AsyncListeners()
{
  static context = ds_map_create();
  
  // Initialize async listeners for reach event types.
  static dummy = array_foreach([
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
    static asyncListeners = __KorutiiniRuntime_AsyncListeners();
    asyncListeners[? _type] = ds_map_create();
  });
  
  
  return context;
}


