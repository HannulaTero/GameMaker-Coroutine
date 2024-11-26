

// Handle listeners.
coroutine_async_listen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  // Trigger request based on status.
  switch(async_load[? "status"])
  {
    case "1": 
      onPending(self);
      break;
    case "2": 
      onSuccess(self);
      Destroy();
      break;
    case "0": 
    case "3": 
      Failure();
      break;
    default:
      throw($"Async Social: Unknown status '{async_load[? "status"]}'.");
      break;
  }
}

