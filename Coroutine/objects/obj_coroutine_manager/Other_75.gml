

// Handle listeners.
coroutine_async_listen();


// Check whether request exists. 
// Normally there are none(?), but user can also fire async events.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  onSuccess(self);
  Destroy();
}

