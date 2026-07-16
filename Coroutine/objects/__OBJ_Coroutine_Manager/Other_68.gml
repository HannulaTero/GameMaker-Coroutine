

// Handle listeners.
__Coroutine_AsyncListen();


// Check whether request exists.
with(COROUTINE_ASYNC_REQUESTS[? async_load[? "id"]])
{
  onSuccess(self);
  Destroy();
}

