/// @desc WAIT SOUND TO FININSH.


// You can give settings for async action. 
// If you have made request already, you can just give index.
// But you can also use "DO_REQUEST return x" to define callback, 
// which is useful when you want multiple lines, and to be able to do retries.
COROUTINE BEGIN
  
  // Make the request.
  ASYNC_REQUEST
      name: "Sound end",
      desc: "Waits action until sound has stopped",
      request: audio_play_sound(snd_example, 0, false),
    ON_SUCCESS show_debug_message($"[{_async.request}] Success!");
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  show_debug_message($"Sound has finished!");
  
FINISH DISPATCH

