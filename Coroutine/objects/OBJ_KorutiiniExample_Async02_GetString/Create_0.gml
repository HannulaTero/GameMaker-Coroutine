/// @desc GET STRING


// Requests are user-defined actions with specific async identifier handle.
// But you may not always have one.
// So you can make async listener for specific async -event (must be defined).
// Listener will always trigger when given event is launched.
// Request in other hand only triggers when required.
KORUTIINI BEGIN

  text = "<waiting...>";
  
  // Listens to the event.
  ASYNC_LISTENER type: ev_async_dialog
    ON_LISTEN KorutiiniExample_Log($"Listener: {async_load[? "result"]}");
  ASYNC_END
  
  // Make the request.
  ASYNC_REQUEST
    DO_REQUEST return get_string_async("Give me string", "Hello world!");
    ON_SUCCESS text = async_load[? "result"];
    ON_FAILURE text = "<cancelled>";
  ASYNC_END
  
  // Await for the result.
  AWAIT_REQUESTS
  KorutiiniExample_Log($"String has been fetched!");
  KorutiiniExample_Log($"User wrote: {text}");
  
FINISH DISPATCH 


