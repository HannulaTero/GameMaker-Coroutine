

// Initialize globals.
COROUTINE_MANAGER = {};
COROUTINE_ACTIVE = new CoroutineDoubleLinkedList();
COROUTINE_PAUSED = new CoroutineDoubleLinkedList();
COROUTINE_CACHE = ds_map_create();


// Initialize the object managers, and warm up pipeline.
call_later(1, time_source_units_frames, function()
{
  // Create coroutine managers.
  instance_create_depth(0, 0, 0, obj_coroutine_manager);
  instance_create_depth(0, 0, 0, obj_coroutine_timer);

  // Warm-up the pipeline by 
  // This way statics and lookup tables are initialized.
  COROUTINE BEGIN 
    DELAY 2.0 SECONDS
    show_debug_message("Welcome using Coroutine!");
    DELAY 0.5 SECONDS
    show_debug_message(" - You are in version: ");
    DELAY 0.5 SECONDS
    show_debug_message($" - {COROUTINE_VERSION}");
  FINISH DISPATCH;
});

