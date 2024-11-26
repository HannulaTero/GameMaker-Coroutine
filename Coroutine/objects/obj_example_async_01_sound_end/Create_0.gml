/// @desc WAIT SOUND TO FININSH.


COROUTINE BEGIN
  
  // Make the request.
  ASYNC_REQUEST
    DO_REQUEST return audio_play_sound(snd_example, 0, false);
    ON_SUCCESS show_debug_message($"[{_async.request}] Success!");
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  show_debug_message($"Sound has finished!");
  
FINISH DISPATCH

