

// Initialize the object managers, and warm up pipeline.
call_later(1, time_source_units_frames, function()
{
  // Create coroutine managers.
  instance_create_depth(0, 0, 0, __OBJ_Coroutine_Manager);
  instance_create_depth(0, 0, 0, __OBJ_Coroutine_Timer);

  // Warm-up the pipeline.
  // This way statics and lookup tables are initialized.
  COROUTINE BEGIN
  
    DELAY 0.25 SECONDS
    show_debug_message(string(string_concat(
        "\n{4}\n\n",
        "Welcome using {0}! \n",
        " - You are in version: {1}\n",
        " - Provided by {2} \n\n",
        "{3}\n\n{4}\n",
      ), 
      COROUTINE_NAME,
      COROUTINE_VERSION,
      COROUTINE_AUTHOR,
      COROUTINE_URL,
      string_repeat("=", 92)
    ));

  FINISH DISPATCH
});

