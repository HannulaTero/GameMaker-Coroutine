/// @desc MESSAGE.


// Alongside coroutines you can make async requests.
// Usually you make a request, and do action else-where in async-event.
// But the async and coroutine implementations allows you to wait results,
// and do stuff when the request has been handled.

// The async request behaves similarly to coroutine, but it doesn't have coroutine body.
// So it has settings and triggers for specific async status. 
// Note, that not all async events support all triggers, just because how GM works.
// Likewise coroutine triggers, async triggers will not support coroutine syntax within them.
// -> But you can launch another coroutine task within them.
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

