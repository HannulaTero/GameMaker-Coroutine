/// @desc MESSAGE.


COROUTINE BEGIN
  
  // Make the request.
  ASYNC_REQUEST
    DO_REQUEST return show_message_async("Hello world!");
    ON_SUCCESS show_debug_message($"[{_async.request}] Success!");
    ON_FAILURE show_debug_message($"[{_async.request}] Failed!");
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  show_debug_message($"Message is no more!");
  
FINISH DISPATCH

