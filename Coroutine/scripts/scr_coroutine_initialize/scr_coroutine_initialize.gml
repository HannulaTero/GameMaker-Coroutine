

// Initialize globals.
__COROUTINE_MANAGER = {};
__COROUTINE_ACTIVE = new CoroutineDoubleLinkedList();
__COROUTINE_PAUSED = new CoroutineDoubleLinkedList();
__COROUTINE_CURRENT = 0;
__COROUTINE_CACHE = ds_map_create();

__COROUTINE_FLAG_EXECUTING = false;
__COROUTINE_FRAME_TIME_BEGIN = 0;

__COROUTINE_ASYNC_REQUESTS = ds_map_create();
array_foreach([
  "Image Loaded",
  "HTTP",
  "Dialog",
  "In-App Purchase",
  "Cloud",
  "Networking",
  "Steam",
  "Social",
  "Push Notification",
  "Save/Load",
  "Audio Recording",
  "Audio Playback",
  "System",
  "Audio Playback Ended",
], function(_name, i) 
{
  _name = string_lower(_name);
  __COROUTINE_ASYNC_REQUESTS[? _name] = ds_map_create();
});


// Initialize the object managers, and warm up pipeline.
call_later(1, time_source_units_frames, function()
{
  // Create coroutine managers.
  instance_create_depth(0, 0, 0, obj_coroutine_manager);
  instance_create_depth(0, 0, 0, obj_coroutine_timer);

  // Warm-up the pipeline.
  // This way statics and lookup tables are initialized.
  COROUTINE BEGIN 
    DELAY 2.0 SECONDS
    show_debug_message("Welcome using Coroutine!");
    DELAY 0.1 SECONDS
    show_debug_message(" - You are in version: ");
    DELAY 0.1 SECONDS
    show_debug_message($" - {COROUTINE_VERSION}");
  FINISH DISPATCH;
});

